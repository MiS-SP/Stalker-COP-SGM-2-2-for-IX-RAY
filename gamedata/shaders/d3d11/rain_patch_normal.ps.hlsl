#include "common.hlsli"
#include "lmodel.hlsli"
#include "shadow.hlsli"

#ifndef USE_SUNMASK
float3x4 m_sunmask; // ortho-projection
#endif

Texture3D s_water;
Texture2D s_waterFall;
float4 RainDensity; //	float
float4 RainFallof;
float4 WorldX; //	Float3
float4 WorldZ; //	Float3

float3 GetNVNMap(Texture3D s_texture, float2 tc, float time)
{
    //	Unpack NVidia normal map
    float4 water = s_texture.SampleBias(smp_base, float3(tc, time), -3.) - 0.5;

    //	Swizzle
    water.xyz = water.wyz;

    //	Renormalize (*2) and scale (*3)
    water.xyz *= 6;
    water.y = 0;

    return water.xyz;
}

float3 GetWaterNMap(Texture2D s_texture, float2 tc)
{
    //	Unpack normal map
    float4 water = s_texture.Sample(smp_base, tc);
    water.xyz = (water.xzy - 0.5) * 2;

    water.xyz *= 0.3;
    water.y = 0;

    return water.xyz;
}

#ifndef ISAMPLE
    #define ISAMPLE 0
#endif

float4 main(float2 tc : TEXCOORD0, float2 tcJ : TEXCOORD1, float4 Color : COLOR, float4 pos2d : SV_Position) : SV_Target
{
    IXrayGbuffer O;
    GbufferUnpack(tc, pos2d, O);

    // gbuffer_data gbd = gbuffer_load_data(tc, pos2d);

    float4 _P = float4(O.PointReal, 1.0);
    float3 _N = O.Normal;
    float3 D = O.Color;

    _N.xyz = normalize(_N.xyz);

    _P.xyz += _N.xyz * 0.15f;
    float4 PS = mul(m_shadow, _P);

    float3 WorldP = mul(m_sunmask, _P);
    float3 WorldN = mul(m_sunmask, _N.xyz);

    // Read rain projection with some jetter. Also adding pixel normal
    // factor to jitter to make rain strips more realistic.
    float s = shadow_hw(PS) * saturate(O.Hemi * 10.0f);

    //	Apply distance falloff
    // Using fixed fallof factors according to float16 depth coordinate precision.
    float fAtten = 1 - smoothstep(min(RainFallof.y - 15.0f, RainFallof.x), RainFallof.y, _P.z);
    s *= fAtten * fAtten;

    //	Apply rain density
    s *= RainDensity.x;

    float fIsUp = -dot(Ldynamic_dir.xyz, _N.xyz);
    s *= saturate(fIsUp * 10 + (10 * 0.5) + 0.5);
    fIsUp = max(0, fIsUp);

    float fIsX = WorldN.x;
    float fIsZ = WorldN.z;

    float3 waterSplash = GetNVNMap(s_water, WorldP.xz, timers.x * 3.0);

    float3 tc1 = WorldP / 2;

    float fAngleFactor = 1 - fIsUp;

    fAngleFactor = 0.1 * ceil(10 * fAngleFactor);

    //	Just slow down effect.
    fAngleFactor *= 0.5;

    float3 waterFallX = GetWaterNMap(s_waterFall, float2(tc1.z, tc1.y + timers.x * fAngleFactor));
    float3 waterFallZ = GetWaterNMap(s_waterFall, float2(tc1.x, tc1.y + timers.x * fAngleFactor));

    float2 IsDir = (float2(fIsZ, fIsX));

    IsDir = normalize(IsDir);

    float3 waterFall = GetWaterNMap(s_waterFall, float2(dot(tc1.xz, IsDir), tc1.y + timers.x));
    float WeaponAttenuation = O.Depth > 0.2 ? 1.0f : 0.0f;
    float ApplyNormalCoeff = s * WeaponAttenuation;

    float3 water = waterSplash * (fIsUp * ApplyNormalCoeff);

    water += waterFallX.yxz * (abs(fIsX) * ApplyNormalCoeff);
    water += waterFallZ.zxy * (abs(fIsZ) * ApplyNormalCoeff);

    //	Translate NM to view space
    water.xyz = mul(m_V, water.xyz);

    _N += water.xyz;
    _N = normalize(_N);
    s *= dot(D.xyz, float3(0.33, 0.33, 0.33));

    return float4(_N, s);
}