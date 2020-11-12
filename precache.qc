void ()  Footstep_precache =
{
	precache_sound2 ("player/footstep1.wav");
	precache_sound2 ("player/footstep2.wav");
	precache_sound2 ("player/footstep3.wav");
	precache_sound2 ("player/footstep4.wav");
	
	precache_sound2 ("player/ladder1.wav");
	precache_sound2 ("player/ladder2.wav");
	precache_sound2 ("player/ladder3.wav");
	precache_sound2 ("player/ladder4.wav");
};
 
void ()  Player_precache =
{
	precache_sound2 ("player/jump1.wav");
	precache_sound2 ("player/jump1.wav");
	 
	precache_sound2 ("player/jump1.wav");
	precache_sound2 ("player/jump2.wav");
	precache_sound2 ("player/land.wav");			// player landing
	precache_sound2 ("player/land2.wav");		// player hurt landing

	precache_sound2 ("player/pain1.wav");
	precache_sound2 ("player/pain2.wav");
	precache_sound2 ("player/pain3.wav");
	precache_sound2 ("player/pain4.wav");
	precache_sound2 ("player/pain5.wav");

	precache_sound2 ("player/pickup.wav");



	precache_sound2 ("player/death1.wav");
	precache_sound2 ("player/death2.wav");
	precache_sound2 ("player/death3.wav");

	precache_model2("models/usa_m4.md3");
	precache_model2("models/usa_xm.md3");
	precache_model2("models/usa_glock.md3");
	precache_model2("models/usa_awp.md3");
	precache_model2("models/usa_knife.md3");

	precache_model2("models/ussr_ak74.md3");
	precache_model2("models/ussr_toz.md3");
	precache_model2("models/ussr_knife.md3");
	precache_model2("models/ussr_mosin.md3");
	precache_model2("models/ussr_aps.md3");

	precache_model2("models/runner_red.md3");
	precache_model2("models/runner_blue.md3");

	precache_model2("models/barricade.bsp");
	precache_sound2 ("weapons/build.wav");
	precache_sound2("func/metal1.wav");

	precache_model2("models/chain.mdl");
	precache_model2("models/hook.mdl");
	precache_sound2("hook/chain1.wav");
	precache_sound2("hook/chain2.wav");
	precache_sound2("hook/retract.wav");
	precache_sound2("hook/fire.wav");



};

void () pdude_precache =
{
	precache_model2 ("models/npc/light.md3");
    precache_model2 ("models/npc/nohead.md3");
    precache_model2 ("models/npc/corpse.md3");
    precache_model2 ("models/npc/corpse2.md3");
    precache_model2 ("models/npc/Rleg.md3");
    precache_model2 ("models/npc/tors.md3");
    precache_model2 ("models/npc/Lleg.md3");
	precache_model2("models/w_apsammo.md3");

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
	
	precache_sound2 ("npc/soldier_scorpion.wav");
}

void ()  Knife_precache =
{
	precache_model2 ("models/v_knife.md3");
	precache_sound2 ("weapons/knife/knife_whoosh1.wav");
	precache_sound2 ("weapons/knife/knife_hit1.wav");
	precache_sound2 ("weapons/knife/knife_hit2.wav");

};
 
void ()  PM_precache =
{
	precache_model2 ("models/v_pm.md3");
	precache_sound2 ("weapons/pm/pm_clipin.wav");
	precache_sound2 ("weapons/pm/pm_clipout.wav");
	precache_sound2 ("weapons/pm/pm_noammo.wav");
	precache_sound2 ("weapons/pm/pm.wav");
	precache_sound2 ("weapons/pm/pm_cloth.wav");
	precache_sound2 ("weapons/pm/pm_slideback.wav");

	precache_model2 ("models/v_glock.md3");
	precache_sound2 ("weapons/pm/glock.wav");
};

void ()  AK_precache =
{
	precache_model2("models/v_m4.md3");
	precache_model2("models/v_ak74.md3");
	precache_model2("models/w_ak74.md3");
	precache_sound2("weapons/ak47/ak47-1.wav");
	precache_sound2("weapons/ak47/ak47_clipout.wav");
	precache_sound2("weapons/ak47/ak47_clipin.wav");
	precache_sound2("weapons/ak47/ak47_boltpull.wav");
	precache_sound2("weapons/ak47/ak47_click.wav");
	precache_sound2("weapons/ak47/m4.wav");
};
 
void ()  TOZ_precache =
{
	precache_model2("models/v_toz.md3");
	precache_sound2("weapons/toz/toz-1.wav");
	precache_sound2("weapons/toz/toz-insertshell.wav");
	precache_sound2("weapons/toz/toz-pump.wav");
	precache_model2("models/v_xm.md3");

};
 
void ()  Grenade_precache =
{
	precache_model2("models/v_grenade.md3");
	precache_model2("models/w_grenade.md3");
	precache_sound2("weapons/grenade/grenade_explode1.wav");
	precache_sound2("weapons/grenade/grenade_explode2.wav");
	precache_sound2("weapons/grenade/grenade_explode3.wav");
	precache_sound2("weapons/grenade/grenade_hit1.wav");
	precache_sound2("weapons/grenade/grenade_hit2.wav");
	precache_sound2("weapons/grenade/grenade_hit3.wav");
	precache_sound2("weapons/grenade/grenade_pinpull.wav");
};
 
void () Mosin_precache =
{
	precache_model2 ("models/v_mosin.md3");
	precache_sound2 ("weapons/mosin/mosin-1.wav");
	precache_sound2 ("weapons/mosin/mosin_boltback.wav");
	precache_sound2 ("weapons/mosin/mosin_boltrelease.wav");
	precache_sound2 ("weapons/mosin/mosin_clipin.wav");
	precache_sound2 ("weapons/mosin/mosin_put.wav");
	
	precache_model2 ("models/v_awp.md3");
	precache_sound2 ("weapons/mosin/awp.wav");
};

void ()  Other_precache =
{
	precache_sound2("misc/h2ohit1.wav");
	precache_sound2("weapons/hitsound.wav");
	precache_sound2("weapons/ric1.wav");
	precache_sound2("weapons/ric2.wav");
	precache_model2("models/shells/shell.md3");
	precache_model2("models/shells/aps_shell.md3");
	precache_model2("models/shells/shotgun_shell.md3");
	precache_sound2("weapons/shellhit2.wav");
	precache_sound2("weapons/shellhit3.wav");

	precache_model2("models/shrap.md3");
	precache_model2("models/explode.mdl");
	precache_model2("models/gib.md3");
};