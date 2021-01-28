void() playerPrecache =
{
	precache_sound2 ("player/footstep1.wav");
	precache_sound2 ("player/footstep2.wav");
	precache_sound2 ("player/footstep3.wav");
	precache_sound2 ("player/footstep4.wav");
	
	precache_sound2 ("player/ladder1.wav");
	precache_sound2 ("player/ladder2.wav");
	precache_sound2 ("player/ladder3.wav");
	precache_sound2 ("player/ladder4.wav");
	
	precache_sound2 ("player/jump1.wav");
	precache_sound2 ("player/land1.wav");		// player landing
	precache_sound2 ("player/land2.wav");		// player hurt landing
	
	precache_sound2 ("impacts/hit1.wav");
	precache_sound2 ("impacts/hit2.wav");
	precache_sound2 ("impacts/hit3.wav");
	precache_sound2 ("impacts/hit4.wav");
	precache_sound2 ("impacts/ric1.wav");
	precache_sound2 ("impacts/ric2.wav");

	precache_sound2 ("player/pain1.wav");
	precache_sound2 ("player/pain2.wav");
	precache_sound2 ("player/pain3.wav");
	precache_sound2 ("player/pain4.wav");
	precache_sound2 ("player/pain5.wav");
	precache_sound2 ("player/pain6.wav");
	precache_sound2 ("player/pain7.wav");

	precache_sound2 ("player/pickup.wav");
	precache_sound2 ("player/switch.wav");

	precache_sound2 ("player/death1.wav");
	precache_sound2 ("player/death2.wav");
	precache_sound2 ("player/death3.wav");

	precache_model2("models/ussr_rifle.md3");
	precache_model2("models/ussr_shot.md3");
	precache_model2("models/ussr_knife.md3");
	precache_model2("models/ussr_sniper.md3");
	precache_model2("models/ussr_pistol.md3");

	if(deathmatch)
	{		
		precache_model2("models/usa_rifle.md3");
		precache_model2("models/usa_shot.md3");
		precache_model2("models/usa_pistol.md3");
		precache_model2("models/usa_sniper.md3");
		precache_model2("models/usa_knife.md3");
		precache_model2("models/runner_red.md3");
		precache_model2("models/runner_blue.md3");

		precache_model2("models/v_hammer.md3");
		precache_model2("models/barricade.bsp");
		precache_sound2("weapons/build.wav");
		precache_sound2("func/metal1.wav");
		precache_model2("models/chain.bsp");
		precache_model2("models/hook.bsp");
		precache_sound2("weapons/hook/chain1.wav");
		precache_sound2("weapons/hook/chain2.wav");
		precache_sound2("weapons/hook/retract.wav");
		precache_sound2("weapons/hook/fire.wav");
	}
};

void() pdude_precache =
{
	precache_model2 ("models/npc/light.md3");
    precache_model2 ("models/npc/nohead.md3");
    precache_model2 ("models/npc/corpse.md3");
    precache_model2 ("models/npc/corpse2.md3");
    precache_model2 ("models/npc/Rleg.md3");
    precache_model2 ("models/npc/tors.md3");
    precache_model2 ("models/npc/Lleg.md3");
	precache_model2 ("models/w_pmammo.md3");

    precache_sound2 ("npc/soldier_death1.wav");
    precache_sound2 ("npc/soldier_death2.wav");
    precache_sound2 ("npc/soldier_death3.wav");
	precache_sound2 ("npc/soldier_pain1.wav");
    precache_sound2 ("npc/soldier_pain1.wav");
    precache_sound2 ("npc/soldier_pain1.wav");
	
	precache_sound2 ("npc/sight1.wav");
    precache_sound2 ("npc/sight2.wav");
    precache_sound2 ("npc/sight3.wav");
	precache_sound2 ("npc/sight4.wav");
	precache_sound2 ("npc/sight5.wav");
	precache_sound2 ("npc/sight6.wav");
	precache_sound2 ("npc/sight7.wav");
	precache_sound2 ("npc/sight8.wav");
	precache_sound2 ("npc/sight9.wav");
	precache_sound2 ("npc/sight10.wav");
	precache_sound2 ("npc/sight11.wav");
	precache_sound2 ("npc/sight12.wav");
	precache_sound2 ("npc/sight13.wav");
	precache_sound2 ("npc/sight14.wav");
	
	precache_sound2 ("weapons/pistol/pm.wav");
}

void() knifePrecache =
{
	precache_model2 ("models/v_knife.md3");
	if(deathmatch) precache_model2 ("models/v_knife_usa.md3");
	precache_sound2 ("weapons/knife/whoosh1.wav");
	precache_sound2 ("weapons/knife/whoosh2.wav");
	precache_sound2 ("weapons/knife/hit.wav");
	precache_sound2 ("weapons/knife/miss.wav");
};
 
void() pistolPrecache =
{
	precache_model2 ("models/v_pm.md3");
	precache_sound2 ("weapons/pistol/clipin.wav");
	precache_sound2 ("weapons/pistol/clipout.wav");
	precache_sound2 ("weapons/noammo.wav");
	precache_sound2 ("weapons/pistol/pm.wav");
	precache_sound2 ("weapons/pistol/slideback.wav");

	precache_model2 ("models/v_colt.md3");
	precache_sound2 ("weapons/pistol/glock.wav");
};

void() riflePrecache =
{
	precache_model2("models/v_ak.md3");
	precache_model2("models/w_ak.md3");
	precache_sound2("weapons/rifle/shot.wav");
	precache_sound2("weapons/rifle/clipout.wav");
	precache_sound2("weapons/rifle/clipin.wav");
	if(deathmatch) 
	{
		precache_model2("models/v_m4.md3");
		precache_sound2("weapons/rifle/m4.wav");
	}
};
 
void() shotgunPrecache =
{
	precache_model2("models/v_shot.md3");
	precache_sound2("weapons/shotgun/shot.wav");
	precache_sound2("weapons/shotgun/insertshell.wav");
	precache_sound2("weapons/shotgun/pump.wav");
	if(deathmatch) precache_model2("models/v_shot_usa.md3");

};
 
void() grenadePrecache =
{
	precache_model2("models/v_grenade.md3");
	if(deathmatch) precache_model2("models/v_grenade_usa.md3");
	precache_model2("models/w_grenade.md3");
	precache_sound2("weapons/grenade/explosion.wav");
	precache_sound2("weapons/grenade/hit.wav");
	precache_sound2("weapons/grenade/pinpull.wav");
};
 
void() sniperPrecache =
{
	precache_model2 ("models/v_svd.md3");
	precache_sound2 ("weapons/sniper/shot.wav");
	precache_sound2 ("weapons/sniper/boltback.wav");
	precache_sound2 ("weapons/sniper/boltrelease.wav");
	precache_sound2 ("weapons/sniper/clipin.wav");
	precache_sound2 ("weapons/sniper/put.wav");
	
	if(deathmatch) 
	{
		precache_model2 ("models/v_sniper.md3");
		//precache_sound2 ("weapons/mosin/awp.wav");
	}
};

void() otherPrecache =
{
	precache_sound2("misc/h2ohit1.wav");
	precache_model2("models/shells/rifleShell.md3");
	precache_model2("models/shells/pistolShell.md3");
	precache_model2("models/shells/shotgunShell.md3");
	precache_model2("models/shells/sniperShell.md3");
	precache_sound2("weapons/shell1.wav");
	precache_sound2("weapons/shell2.wav");

	precache_model2("models/shrap.md3");
	precache_model2("models/explode.md3");
	precache_model2("models/gib.md3");
	
	if(deathmatch || coop) precache_sound ("misc/item_respawn.wav");	// item respawn sound
	precache_sound ("misc/talk.wav");			// talk
	
	precache_model2("models/gib1.md3");
	precache_model2("models/gib2.md3");
	precache_model2("models/gib3.md3");
};