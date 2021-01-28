
void() InitBodyQue;


void() main =
{
	dprint ("main function\n");
	
// these are just commands the the prog compiler to copy these files

	precache_file2("progs.dat");
	precache_file2("gfx.wad");
	//precache_file2("quake.rc");
	precache_file2("default.cfg");

	//precache_file2("demo1.dem");
	//precache_file2("demo2.dem");
	//precache_file2("demo3.dem");

//
// these are all of the lumps from the cached.ls files
//
	precache_file2("gfx/palette.lmp");
	precache_file2("gfx/colormap.lmp");

	precache_file2 ("gfx/pop.lmp");

	precache_file2("gfx/complete.lmp");
	precache_file2("gfx/inter.lmp");

	precache_file2("gfx/ranking.lmp");
	precache_file2("gfx/vidmodes.lmp");
	precache_file2("gfx/finale.lmp");
	precache_file2("gfx/conback.lmp");
	precache_file2("gfx/qplaque.lmp");

	precache_file2("gfx/menudot1.lmp");
	precache_file2("gfx/menudot2.lmp");
	precache_file2("gfx/menudot3.lmp");
	precache_file2("gfx/menudot4.lmp");
	precache_file2("gfx/menudot5.lmp");
	precache_file2("gfx/menudot6.lmp");

	precache_file2("gfx/menuplyr.lmp");
	precache_file2("gfx/bigbox.lmp");
	precache_file2("gfx/dim_modm.lmp");
	precache_file2("gfx/dim_drct.lmp");
	precache_file2("gfx/dim_ipx.lmp");
	precache_file2("gfx/dim_tcp.lmp");
	precache_file2("gfx/dim_mult.lmp");
	precache_file2("gfx/mainmenu.lmp");
	
	precache_file2("gfx/box_tl.lmp");
	precache_file2("gfx/box_tm.lmp");
	precache_file2("gfx/box_tr.lmp");
	
	precache_file2("gfx/box_ml.lmp");
	precache_file2("gfx/box_mm.lmp");
	precache_file2("gfx/box_mm2.lmp");
	precache_file2("gfx/box_mr.lmp");
	
	precache_file2("gfx/box_bl.lmp");
	precache_file2("gfx/box_bm.lmp");
	precache_file2("gfx/box_br.lmp");
	
	precache_file2("gfx/sp_menu.lmp");
	precache_file2("gfx/ttl_sgl.lmp");
	precache_file2("gfx/ttl_main.lmp");
	precache_file2("gfx/ttl_cstm.lmp");
	
	precache_file2("gfx/mp_menu.lmp");
	
	precache_file2("gfx/netmen1.lmp");
	precache_file2("gfx/netmen2.lmp");
	precache_file2("gfx/netmen3.lmp");
	precache_file2("gfx/netmen4.lmp");
	precache_file2("gfx/netmen5.lmp");
	
	precache_file2("gfx/sell.lmp");
	
	precache_file2("gfx/help0.lmp");
	precache_file2("gfx/help1.lmp");
	precache_file2("gfx/help2.lmp");
	precache_file2("gfx/help3.lmp");
	precache_file2("gfx/help4.lmp");
	precache_file2("gfx/help5.lmp");

	precache_file2("gfx/pause.lmp");
	precache_file2("gfx/loading.lmp");

	precache_file2("gfx/p_option.lmp");
	precache_file2("gfx/p_load.lmp");
	precache_file2("gfx/p_save.lmp");
	precache_file2("gfx/p_multi.lmp");

// sounds loaded by C code
	precache_sound ("misc/menu1.wav");
	precache_sound ("misc/menu2.wav");
	precache_sound ("misc/menu3.wav");

	precache_file2 ("maps/start.bsp");
	precache_file2 ("maps/e1m1.bsp");
	precache_file2 ("maps/e1m2.bsp");
	precache_file2 ("maps/e1m3.bsp");
	precache_file2 ("maps/e1m4.bsp");
	precache_file2 ("maps/e1m5.bsp");
	precache_file2 ("maps/e1m6.bsp");
	precache_file2 ("maps/e1m7.bsp");
	precache_file2 ("maps/e1m8.bsp");
	precache_file2 ("gfx/pop.lmp");
};


entity	lastspawn;

//=======================
/*QUAKED worldspawn (0 0 0) ?
Only used for the world entity.
Set message to the level name.
Set sounds to the cd track to play.

World Types:
0: medieval
1: metal
2: base
*/
//=======================

void() worldspawn =
{
	//bprint("debug worldspawn()\n");
	lastspawn = world;
	InitBodyQue ();

	//cvar_set ("sv_gravity", "800");
	cvar_set ("sv_maxspeed", "200");
	addstat(STAT_TIMER, 2, timer);

	// the area based ambient sounds MUST be the first precache_sounds

	// player precaches	
	knifePrecache();
	pistolPrecache();
	riflePrecache();
	shotgunPrecache();
	sniperPrecache();
	grenadePrecache();
	otherPrecache();
	
	playerPrecache();
	pdude_precache();

	// Setup light animation tables. 'a' is total darkness, 'z' is maxbright.
	lightstyle(0, "m"); 													// 0 normal
	lightstyle(1, "mmnmmommommnonmmonqnmmo"); 								// 1 FLICKER (first variety)
	lightstyle(2, "abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba"); 	// 2 SLOW STRONG PULSE
	lightstyle(3, "mmmmmaaaaammmmmaaaaaabcdefgabcdefg"); 					// 3 CANDLE (first variety)
	lightstyle(4, "mamamamamama"); 											// 4 FAST STROBE
	lightstyle(5,"jklmnopqrstuvwxyzyxwvutsrqponmlkj"); 						// 5 GENTLE PULSE 1
	lightstyle(6, "nmonqnmomnmomomno"); 									// 6 FLICKER (second variety)
	lightstyle(7, "mmmaaaabcdefgmmmmaaaammmaamm"); 							// 7 CANDLE (second variety)
	lightstyle(8, "mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa"); 			// 8 CANDLE (third variety)
	lightstyle(9, "aaaaaaaazzzzzzzz"); 										// 9 SLOW STROBE (fourth variety)
	lightstyle(10, "mmamammmmammamamaaamammma"); 							// 10 FLUORESCENT FLICKER
	lightstyle(11, "abcdefghijklmnopqrrqponmlkjihgfedcba");					// 11 SLOW PULSE NOT FADE TO BLACK
	
	// styles 32-62 are assigned by the light program for switchable lights
	lightstyle(63, "a");// 63 testing
};

void() StartFrame =
{
	teamplay = cvar("teamplay");
	skill = cvar("skill");
	framecount = framecount + 1;
	
	//if(world.lastTouch  + 1 < time)
	// if(deathmatch)
	// {
		// local entity e;
		// local float players;
		// for (e = findchain(classname, "player"); e; e = e.chain) players = players + 1;
		// for (e = findchain(classname, "observer"); e; e = e.chain) players = players + 1;
		// if(players < 5) SpawnBot();
		// if(players > 5)
		// {
			// head = find(world, classname, "player");
			// while (head)
			// {
				// if (clienttype(head) == CLIENTTYPE_BOT) 
				// {
					// dropclient(head);
					// return;
				// }
			// }
		// }
	// }
};

/*
==============================================================================

BODY QUE

==============================================================================
*/

entity	bodyque_head;

void() bodyque =
{	// just here so spawn functions don't complain after the world
	// creates bodyques
};

void() InitBodyQue =
{	
	//bprint("debug InitBodyQue()\n");
	bodyque_head = spawn();
	bodyque_head.classname = "bodyque";
	bodyque_head.owner = spawn();
	bodyque_head.owner.classname = "bodyque";
	bodyque_head.owner.owner = spawn();
	bodyque_head.owner.owner.classname = "bodyque";
	bodyque_head.owner.owner.owner = spawn();
	bodyque_head.owner.owner.owner.classname = "bodyque";
	bodyque_head.owner.owner.owner.owner = bodyque_head;
};


// make a body que entry for the given ent so the ent can be
// respawned elsewhere
void(entity ent) CopyToBodyQue =
{
	//bprint("debug CopyToBodyQue()\n");
	bodyque_head.angles = ent.angles;
	bodyque_head.model = ent.model;
	bodyque_head.modelindex = ent.modelindex;
	bodyque_head.frame = ent.frame;
	bodyque_head.colormap = ent.colormap;
	bodyque_head.movetype = ent.movetype;
	bodyque_head.velocity = ent.velocity;
	bodyque_head.flags = 0;
	setorigin (bodyque_head, ent.origin);
	setsize (bodyque_head, ent.mins, ent.maxs);
	bodyque_head = bodyque_head.owner;
};
