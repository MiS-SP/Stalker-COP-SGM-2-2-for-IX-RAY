#include "common.hlsli"

struct v2p
{
    float2 tc0 : TEXCOORD0; // base
};

// Pixel
float4 main(v2p I) : COLOR
{
    float4 r = tex2D(s_base, I.tc0);
    //	r.x = 1 - r.x;
    //	r.y = 1 - r.y;
    //	r.z = 1 - r.z;
    r.w = 1 - r.w;
    return r;
    //	return	/*(float4(1,1,1,1) - */ tex2D	(s_base,I.tc0);
}
