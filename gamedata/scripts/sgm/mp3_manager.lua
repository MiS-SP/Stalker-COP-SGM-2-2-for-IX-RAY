local Class = require('gamedata.scripts.lib.oop').Class
local Track = Class()

function Track:init(id_sound, sound_type_name, author)
    self.id = id_sound
    self.sound = "[[" .. sound_type_name .. "\\" .. "Трек_" .. id_sound
    self.title = "Дорожка " .. id_sound
    if author ~= nil then
        self.author = author
    else
        self.author = "-"
    end
end

-- todo в ltx
-- example { sound = [[Веселая\Трек_1]], title = "Дорожка 1", author = "Ленинград - Агент 007", id = 1 },
local mp3_table_merry = {
    Track(1, "Веселая", "Ленинград - Агент 007"),
    Track(2, "Веселая"),
    Track(3, "Веселая"),
    Track(4, "Веселая"),
    Track(5, "Веселая"),
    Track(6, "Веселая"),
    Track(7, "Веселая"),
    Track(8, "Веселая", "Chakaron - El Mudo")
}
local mp3_table_dance = {
    Track(1, "Клубная", "Fatboy Slim - Weapon Of Choice 2010"),
    Track(2, "Клубная", "The Prodigy - Omen"),
    Track(3, "Клубная"),
    Track(4, "Клубная", "Dj Winner - Electro zhest"),
    Track(5, "Клубная", "Dj Xeon - Sweet Pill's 4"),
    Track(6, "Клубная", "DJ Romantic & Andi Vax - I Feel You"),
    Track(7, "Клубная"),
    Track(8, "Клубная"),
    Track(9, "Клубная", "Bald Bros feat Levie - Love in Redlight"),
    Track(10, "Клубная"),
    Track(11, "Клубная"),
    Track(12, "Клубная"),
    Track(13, "Клубная"),
    Track(14, "Клубная", "Antoine Clamaran - Gold"),
    Track(15, "Клубная"),
    Track(16, "Клубная", "Fragma - Forever and a day"),
    Track(17, "Клубная"),
    Track(18, "Клубная", "Max Creative & DJ Cross - Rock This"),
    Track(19, "Клубная", "Смысловые галлюцинации - Вечно молодой"),
    Track(20, "Клубная"),
    Track(21, "Клубная", "Klaas - Feel The Love"),
    Track(22, "Клубная"),
    Track(23, "Клубная"),
    Track(24, "Клубная", "Denis The Menace - Show Me A Reason"),
    Track(25, "Клубная", "Serge Devant - Take Me With You"),
    Track(26, "Клубная", "Serge Devant - Addicted"),
    Track(27, "Клубная", "Chase And Status Feat. Plan B - End Credits"),
    Track(28, "Клубная", "Promodj - Only for you mix"),
    Track(29, "Клубная", "Stromae - Alors on Danse"),
    Track(30, "Клубная"),
    Track(31, "Клубная", "Laselva Feat Charlotte Spink - Take Me Away"),
    Track(32, "Клубная"),
    Track(33, "Клубная"),
    Track(34, "Клубная"),
    Track(35, "Клубная"),
    Track(36, "Клубная", "Sonique - Sky"),
    Track(37, "Клубная"),
    Track(38, "Клубная"),
    Track(39, "Клубная"),
    Track(40, "Клубная"),
    Track(41, "Клубная"),
    Track(42, "Клубная"),
    Track(43, "Клубная"),
    Track(44, "Клубная"),
    Track(45, "Клубная"),
    Track(46, "Клубная"),
    Track(47, "Клубная"),
    Track(48, "Клубная"),
    Track(49, "Клубная", "Tiesto - In The Dark"),
    Track(50, "Клубная", "DVJ Bazuka - Saw"),
    Track(51, "Клубная", "DVJ Bazuka - Slipin Away"),
    Track(52, "Клубная", "DVJ Bazuka - Saw"),
    Track(53, "Клубная", "DVJ Bazuka - Saw"),
    Track(54, "Клубная", "DVJ Bazuka - Saw"),
    Track(55, "Клубная", "DVJ Bazuka - Saw"),
    Track(56, "Клубная", "Dj Natasha Rostova - 17-01-2009"),
    Track(57, "Клубная", "Marcel Woods - Tomorrow"),
    Track(58, "Клубная", "Sultan & Ned Shepard feat Dirty Vegas - Crimson Sun"),
    Track(59, "Клубная", "Armin Van Buuren feat. sophie Ellis Bextor - not giving up on loves"),
    Track(60, "Клубная", "David Guetta - love dont let me go"),
    Track(61, "Клубная", "David Guetta - the world is mine"),
    Track(62, "Клубная", "David Guetta - winner of the game"),
    Track(63, "Клубная", "Dj Kaffein - Follow Me"),
    Track(64, "Клубная", "Moonbeam & Marrow Dojah - Insincere"),
    Track(65, "Клубная", "Moonbeam - 7 seconds"),
    Track(66, "Клубная", "Moonbeam - i love mornings extended mix"),
    Track(67, "Клубная", "Smart Apes - One Day You Won't See The Sunrise"),
    Track(68, "Клубная", "Tiga - you gonna want me"),
    Track(69, "Клубная"),
    Track(70, "Клубная", "Underworld - Always Loved A Film"),
    Track(71, "Клубная", "AnnaGrace - Don't Let Go"),
    Track(72, "Клубная", "AnnaGrace - You Do Want Me"),
    Track(73, "Клубная", "Sgt Slick - Like This"),
    Track(74, "Клубная", "Paul Johns Feat. Umberto Tabbi - Ciao Siciliano"),
    Track(75, "Клубная", "TV Rock & Zoe Badwi -  Release Me"),
    Track(76, "Клубная", "Schiller feat. September - Breathe"),
    Track(77, "Клубная", "Maurizio Inzaghi - Searching For Love"),
    Track(78, "Клубная", "Supermode - Tell Me Why 2009"),
    Track(79, "Клубная", "Annagrace - You Make Me Feel"),
    Track(80, "Клубная", "Moby - Disco Lies"),
    Track(81, "Клубная", "Roger Sanchez - Not Enough"),
    Track(82, "Клубная", "A.G.Trio - Jungle"),
    Track(83, "Клубная", "Blank & Jones - Miracle Cure"),
    Track(84, "Клубная", "Everything But The Girls - Missing"),
    Track(85, "Клубная", "Fukkk Offf - Brain Rock"),
    Track(86, "Клубная", "Michael Jackson - Who Is It"),
    Track(87, "Клубная"),
    Track(88, "Клубная", "Jozhy & Angel - Wait For Tomorrow"),
    Track(89, "Клубная", "4 Strings - Take Me Away"),
    Track(90, "Клубная", "Lara Fabian - I Will Love Again"),
    Track(91, "Клубная", "DJ Free Pink - Please Dont Leave"),
    Track(92, "Клубная", "Eurythmics - Sweet Dreams"),
    Track(93, "Клубная", "Levi Star - Melt Inside"),
    Track(94, "Клубная", "Armin Van Buuren - Mirage"),
    Track(95, "Клубная", "Plan B - Prayin"),
    Track(96, "Клубная", "Plan B - She Said Original"),
    Track(97, "Клубная", "Christina Aguilera - Not Myself Tonight"),
    Track(98, "Клубная", "David Guetta - Love Is Gone"),
    Track(99, "Клубная", "Jaydee - Plastic Dreams"),
    Track(100, "Клубная", "Spencer & Hill - Dub Disco"),
    Track(101, "Клубная", "Eminem ft. Rihanna - Love The Way You Lie"),
    Track(102, "Клубная", "Kato & Dj Jose & Jon - Turn the lights off"),
    Track(103, "Клубная", "Supermode - Tell me why"),
    Track(104, "Клубная", "Massive Attack - Paradise Circus"),
    Track(105, "Клубная", "Melanie C - I Turn To You"),
    Track(106, "Клубная", "September - Cry For You"),
    Track(107, "Клубная", "Mondotek - Alive"),
    Track(108, "Клубная", "Jay-Z - 99 Problems"),
    Track(109, "Клубная", "Prodigy - Mescaline"),
    Track(110, "Клубная", "Dj Miller - Makes Me Happy"),
    Track(111, "Клубная", "Britney Spears - Till The World Ends"),
    Track(112, "Клубная", "Bobina - Invincible Touch"),
    Track(113, "Клубная", "Deepside Deejays - Never Be Alone Radio Edit"),
    Track(114, "Клубная", "Ferry Corsten - Punk Arty"),
    Track(115, "Клубная", "Ian Carey - Redlight"),
    Track(116, "Клубная", "Justin Timberlake - Cry Me A River"),
    Track(117, "Клубная", "Britney Spears - Till The World Ends"),
    Track(118, "Клубная", "Katy Perry - Last Friday Night"),
    Track(119, "Клубная", "Lenny Kravitz - Fly Away"),
    Track(120, "Клубная", "Lenny Kravitz - I Belong To You"),
    Track(121, "Клубная", "Lenny Kravitz - If You Cant Say No"),
    Track(122, "Клубная", "Lenny Kravitz - Ill Be Waiting"),
    Track(123, "Клубная", "Lenny Kravitz - Let Love Rule"),
    Track(124, "Клубная", "Lenny Kravitz - Love Love Love"),
    Track(125, "Клубная", "Madcon - Beggin Ost Step Up"),
    Track(126, "Клубная", "Martin Solveig - Jealousy"),
    Track(127, "Клубная", "Martin Solveig - Madan"),
    Track(128, "Клубная", "Martin Solveig - Rejection"),
    Track(129, "Клубная", "Meck - Windmills"),
    Track(130, "Клубная", "Miley Cyrus - Who Owns My Heart"),
    Track(131, "Клубная", "Narcotic Thrust - I Like It"),
    Track(132, "Клубная", "Richard Durand & Ellie Lawson - Wide Awake"),
    Track(133, "Клубная", "Rihanna - Sandm"),
    Track(134, "Клубная", "Robbie Williams - Bodies"),
    Track(135, "Клубная", "Sandra - In The Heat Of The Night"),
    Track(136, "Клубная", "Techno Mafia - Openair Silence"),
    Track(137, "Клубная", "The Cranberries - Zombie"),
    Track(138, "Клубная"),
    Track(139, "Клубная"),
    Track(140, "Клубная"),
    Track(141, "Клубная"),
    Track(142, "Клубная"),
    Track(143, "Клубная"),
    Track(144, "Клубная"),
    Track(145, "Клубная"),
    Track(146, "Клубная"),
    Track(147, "Клубная"),
    Track(148, "Клубная", "Solid Base feat Robson - Mirror Mirror"),
    Track(149, "Клубная", "The Kdms - Tonight"),
    Track(150, "Клубная", "We Once Had An Empire"),
    Track(151, "Клубная", "G Spott - Sadness"),
    Track(152, "Клубная", "The White Stripes - Seven Nation Army"),
    Track(153, "Клубная", "Nero - Guilt"),
    Track(154, "Клубная", "Nero - Must Be The Feeling"),
    Track(155, "Клубная", "Example - Changed The Way You Kiss Me"),
    Track(156, "Клубная", "Swanky Tunes - Wanna Be Your Dog"),
    Track(157, "Клубная", "Michael Calfan - Resurrection"),
    Track(158, "Клубная", "Borshit - Neuropi"),
    Track(159, "Клубная", "Starkillers & Alex Kenji - Pressure")
}
local mp3_table_theme = {
    Track(1, "Саундтреки"),
    Track(2, "Саундтреки"),
    Track(3, "Саундтреки"),
    Track(4, "Саундтреки"),
    Track(5, "Саундтреки"),
    Track(6, "Саундтреки"),
    Track(7, "Саундтреки", "Soundtrack - Resident evil"),
    Track(8, "Саундтреки", "Fluke - Absurd"),
    Track(9, "Саундтреки", "Hans Zimmer - Discombobulate"),
    Track(10, "Саундтреки", "Hell March 3"),
    Track(11, "Саундтреки"),
    Track(12, "Саундтреки"),
    Track(13, "Саундтреки"),
    Track(14, "Саундтреки"),
    Track(15, "Саундтреки"),
    Track(16, "Саундтреки", "Alexandre Desplat - The Ghost Writer"),
    Track(17, "Саундтреки")
}
local mp3_table_other = {
    Track(1, "Другая"),
    Track(2, "Другая"),
    Track(3, "Другая"),
    Track(4, "Другая"),
    Track(5, "Другая"),
    Track(6, "Другая"),
    Track(7, "Другая"),
    Track(8, "Другая"),
    Track(9, "Другая"),
    Track(10, "Другая"),
    Track(11, "Другая"),
    Track(12, "Другая"),
    Track(13, "Другая"),
    Track(14, "Другая"),
    Track(15, "Другая"),
    Track(16, "Другая", "17-Apocalyptica-Path Vol.2 Feat. Sandra Nasic"),
    Track(17, "Другая"),
    Track(18, "Другая"),
    Track(19, "Другая", "Shitlist (Natural Born Killers)"),
    Track(20, "Другая", "Shiny Toy Guns - Le Disko"),
    Track(21, "Другая", "-aFx-"),
    Track(22, "Другая", "ACDC - Hells Bells"),
    Track(23, "Другая", "ACDC - Highway To Hell"),
    Track(24, "Другая", "Black Sabbath - Seventh Star"),
    Track(25, "Другая", "Def Leppard - Woman"),
    Track(26, "Другая", "Guns'N'Roses - Don't cry"),
    Track(27, "Другая", "Manowar - Warriors Of The World"),
    Track(28, "Другая", "Metallica - Nothing Else Matters"),
    Track(29, "Другая", "Queen - The show must go on"),
    Track(30, "Другая", "Scorpions - Still loving you"),
    Track(31, "Другая", "Limp Bizkit - Take A Look Around"),
    Track(32, "Другая", "Rammstein - Spookshow Baby"),
    Track(33, "Другая", "System Of A Down - Toxicity"),
    Track(34, "Другая", "Black Strobe - Im A Man"),
    Track(35, "Другая", "Adriano Celentano - Ja Tebia Liubliu"),
    Track(36, "Другая", "Carl Douglas - Kung Fu Fighting"),
    Track(37, "Другая", "Coolio - Ganstas Paradise"),
    Track(38, "Другая", "David Usher - Black Black Heart"),
    Track(39, "Другая", "Joe Cocker - Noubliez Jamais"),
    Track(40, "Другая", "Madonna - Youl ll See"),
    Track(41, "Другая", "Madonna - Frozen"),
    Track(42, "Другая", "Mylene Farmer - Appelle Mon Numero"),
    Track(43, "Другая", "Mylene Farmer - California"),
    Track(44, "Другая", "Mylene Farmer - Desenchantee"),
    Track(45, "Другая", "Mylene Farmer - Je Te Rends Ton Amour"),
    Track(46, "Другая", "Mylene Farmer - Lamour Nest Rien"),
    Track(47, "Другая", "Mylene Farmer - Pourvu Quelles"),
    Track(48, "Другая", "No Doubt - Dont Speak"),
    Track(49, "Другая", "Roxette - Real Sugar"),
    Track(50, "Другая", "Sting - Shape Of My Heart"),
    Track(51, "Другая", "Sting - Desert Rose"),
    Track(52, "Другая", "Sting - Ill Be Missing You"),
    Track(53, "Другая", "Sting - Mad About You"),
    Track(54, "Другая", "Sugababes - Stronger"),
    Track(55, "Другая", "Tarkan - Nu Gece"),
    Track(56, "Другая", "22-22 - Immortal"),
    Track(57, "Другая", "Aelyn - Believe In Us"),
    Track(58, "Другая", "Aelyn - In And Out Of Love"),
    Track(59, "Другая", "Bruno Mars - It Will Rain"),
    Track(60, "Другая", "Headstrong Feat Kirsty Hawkshaw - Love Calls"),
    Track(61, "Другая", "House Massive feat J Golubeva - Apologize"),
    Track(62, "Другая", "Iio - Rapture"),
    Track(63, "Другая", "Jazzamor - Caminho"),
    Track(64, "Другая", "Kirsty Hawkshaw meets Tenishia - Reason To Forgive"),
    Track(65, "Другая", "Kosmopolitans - I Belong To You"),
    Track(66, "Другая", "Lowland - Children"),
    Track(67, "Другая", "ReUnited - Sing It Back"),
    Track(68, "Другая", "The Tone - Relax Take It Easy"),
    Track(69, "Другая", "Tina Cousins - Wonderful Life"),
    Track(70, "Другая", "Thomas Anders - Why Do You Cry"),
    Track(71, "Другая", "Gary Jules - Mad World"),
    Track(72, "Другая", "Sade - Love Is Found")
}
local mp3_table_bonus = {
    Track(1, "Бонусы", "Armin van Buuren Feat. Sharon den Adel - In And Out Of Love"),
    Track(2, "Бонусы"),
    Track(3, "Бонусы", "Freemasons feat. Sophie Ellis-Bextor - Heartbreak"),
    Track(4, "Бонусы", "Klaxons - It's Not Over Yet"),
    Track(5, "Бонусы"),
    Track(6, "Бонусы"),
    Track(7, "Бонусы", "Benny Benassi - Happiness Factory"),
    Track(8, "Бонусы", "David Guetta & Kelly Rowland - When Love Takes Over"),
    Track(9, "Бонусы", "Dj Tiesto - I Will Be Here"),
    Track(10, "Бонусы"),
    Track(11, "Бонусы"),
    Track(12, "Бонусы"),
    Track(13, "Бонусы", "Milk And Sugar - Let The Sun Shine"),
    Track(14, "Бонусы"),
    Track(15, "Бонусы"),
    Track(16, "Бонусы", "04 Laurent Wolf - Club Fg Le Dancefloor"),
    Track(17, "Бонусы"),
    Track(18, "Бонусы", "Sander Van Doorn & Purple Haze - Bliksem"),
    Track(19, "Бонусы"),
    Track(20, "Бонусы", "Black & Jones - Catch"),
    Track(21, "Бонусы", "Angel Tears - Marrakech Atrium"),
    Track(22, "Бонусы", "ATB - Behind"),
    Track(23, "Бонусы", "Blank & Jones - Lazy Life"),
    Track(24, "Бонусы", "Casanovy - I Need Your Lovin"),
    Track(25, "Бонусы", "Ciaran McAuley - Forgotten"),
    Track(26, "Бонусы", "Dinka - Hopelessly Devoted"),
    Track(27, "Бонусы", "Imogen Heap - Hide And Seek"),
    Track(28, "Бонусы", "Moonbeam - Emotion"),
    Track(29, "Бонусы", "Richard Durand - No Way Home"),
    Track(30, "Бонусы", "Roger Sanchez - Lost"),
    Track(31, "Бонусы", "Superbass Feat Delline Bass - New Life"),
    Track(32, "Бонусы", "Yuri Kane - Right Back"),
    Track(33, "Бонусы", "Adam Lambert - Want From Me"),
    Track(34, "Бонусы", "September - Cry For You"),
    Track(35, "Бонусы", "Duran Duran - Come Undone"),
    Track(36, "Бонусы", "Oceana - Cry Cry"),
    Track(37, "Бонусы", "Garbage - The World Is Not Enough"),
    Track(38, "Бонусы", "Keri Hilson - I Like"),
    Track(39, "Бонусы", "Madonna - The Power Of Goodbye"),
    Track(40, "Бонусы", "Youssou Ndour & Neneh Cherry - 7 Seconds"),
}

local Class = require('gamedata.scripts.lib.oop').Class
local MP3Manager = Class()
MP3Manager.mp3_obj = nil
MP3Manager.mp3_info = ""
MP3Manager.mp3_mode = "default"
MP3Manager.mp3_add_value = 0.1
MP3Manager.mp3_chosen_list = nil
MP3Manager.mp3_played_list = nil
MP3Manager.mp3_player_section = 1
MP3Manager.mp3_length_position, MP3Manager.mp3_last_position, MP3Manager.mp3_plays = 0, 0, nil

function MP3Manager:update()
    if has_alife_info("mp3_player_repeat") then
        if MP3Manager.mp3_mode ~= "repeat" then MP3Manager.mp3_mode = "repeat" end
    elseif has_alife_info("mp3_player_queue") then
        if MP3Manager.mp3_mode ~= "queue" then MP3Manager.mp3_mode = "queue" end
    else
        if MP3Manager.mp3_mode ~= "default" then MP3Manager.mp3_mode = "default" end
    end
    if MP3Manager.mp3_mode == "repeat" then
        if MP3Manager.mp3_obj ~= nil then
            if MP3Manager.mp3_obj:playing() == false then
                MP3Manager.mp3_obj:play(db.actor, 0, sound_object.s2d)
                MP3Manager.mp3_obj.volume = read_mod_param("mp3_currert_volume")
                MP3Manager.mp3_last_position = string.format(math.floor(time_global() / 1000))
                MP3Manager.mp3_length_position = string.format(math.floor(time_global() / 1000)) -
                MP3Manager.mp3_last_position
                MP3Manager.mp3_obj.min_distance, MP3Manager.mp3_obj.max_distance = 2, 6
            end
        end
    elseif MP3Manager.mp3_mode == "queue" then
        if MP3Manager.mp3_obj ~= nil then
            if MP3Manager.mp3_obj:playing() == false then
                local next_sound, next_title = nil, nil
                if MP3Manager.mp3_played_list ~= nil and MP3Manager.next_sound == nil then
                    for k, v in pairs(MP3Manager.mp3_played_list) do
                        if v.title == MP3Manager.mp3_plays then
                            local next_id = v.id + 1
                            if next_id > get_table_lines(MP3Manager.mp3_played_list) then
                                next_id = 1
                            end
                            for a, s in pairs(MP3Manager.mp3_played_list) do
                                if s.id == next_id then
                                    if s.precond == nil or (s.precond ~= nil and has_alife_info(s.precond)) then
                                        next_sound = s.sound
                                        next_title = s.title
                                    else
                                        next_id = next_id + 1
                                    end
                                end
                            end
                        end
                    end
                end
                if next_sound ~= nil then
                    MP3Manager.mp3_obj = sound_object(next_sound)
                    MP3Manager.mp3_plays = next_title
                    MP3Manager.mp3_info = next_title .. " (" .. mp3_player():get_sound_length(MP3Manager.mp3_obj) .. ")"
                end
                MP3Manager.mp3_obj:play(db.actor, 0, sound_object.s2d)
                MP3Manager.mp3_obj.volume = read_mod_param("mp3_currert_volume")
                MP3Manager.mp3_last_position = string.format(math.floor(time_global() / 1000))
                MP3Manager.mp3_length_position = string.format(math.floor(time_global() / 1000)) -
                MP3Manager.mp3_last_position
                MP3Manager.mp3_obj.min_distance, MP3Manager.mp3_obj.max_distance = 2, 6
            end
        end
    else
        if MP3Manager.mp3_obj ~= nil then
            if MP3Manager.mp3_obj:playing() == false and MP3Manager.mp3_info ~= "" then
                MP3Manager.mp3_info = ""
            end
            if MP3Manager.mp3_obj:playing() == false and MP3Manager.mp3_plays ~= nil then
                MP3Manager.mp3_plays = nil
                MP3Manager.mp3_length_position, MP3Manager.mp3_last_position = 0, 0
            end
        end
    end
    if db.actor and check_ui_worked() and (not db.actor:object("mp3_player")) then
        if MP3Manager.mp3_obj ~= nil then
            if MP3Manager.mp3_obj:playing() == true then
                MP3Manager.mp3_obj:stop()
                MP3Manager.mp3_obj = nil
                MP3Manager.mp3_info = ""
            end
        end
        MP3Manager.mp3_plays = nil
        MP3Manager.mp3_length_position, MP3Manager.mp3_last_position = 0, 0
    end
end

function MP3Manager:add_mp3_bonus(info_name)
    if dont_has_alife_info(info_name) then
        news_manager.send_tip(db.actor, "st_mp3_new_content_descr", 0, "mp3_player", 3500, nil,
            "st_mp3_new_content_title")
    end
    give_info(info_name)
end
