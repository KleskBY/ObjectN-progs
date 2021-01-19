void() W_WeaponFrame;
void() W_SetCurrentAmmo;
void() player_pain;
void() player_stand1;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;

/*
=============================================================================

				LEVEL CHANGING / INTERMISSION

=============================================================================
*/

float	intermission_running;
float	intermission_exittime;

/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
This is the camera point for the intermission.
Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
*/
void() info_intermission =
{
};



void() SetChangeParms =
{
	//bprint("debug SetChangeParms()\n");
	if (self.health <= 0)
	{
		SetNewParms();
		return;
	}

// remove items
	self.items = self.items - (self.items & (IT_KEY1 | IT_KEY2 /*| IT_INVISIBILITY | IT_INVULNERABILITY | IT_SUIT | IT_QUAD*/));
	
// cap super health
	if (self.health > 100) self.health = 100;
	if (self.health < 50) self.health = 50;
	parm1 = self.items;
	parm2 = self.health;
	//parm3 = self.armorvalue;
	parm4 = self.ammoPistol;
	parm5 = self.ammoRifle;
	parm6 = self.ammoGrenades;
	parm7 = self.ammoShells;
	parm3 = self.ammoSniper;
	parm8 = self.weapon;
	parm9 = self.armortype * 100;
	parm10 = self.weapons;
	parm11 = self.pistolClip;
    parm12 = self.shotgunClip;
    parm13 = self.rifleClip;
	parm15 = self.sniperClip;
	parm16 = self.m60clip;
	
};

void() SetNewParms =
{
	//bprint("debug SetNewParms()\n");
	parm1 = IT_PM | IT_KNIFE | IT_GRENADE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 0;
        parm8 = WP_PISTOL;
	parm9 = 0;
        parm10 = WP_ONE | WP_PISTOL | WP_GRENADE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = CLIP_SNIPER;
        parm16 = 0;
};

void() SetNewParmsObserver =
{
	//bprint("debug SetNewParmsObserver()\n");
	parm1 = 0;
	parm2 = 666;
	parm3 = 0;
	parm4 = 0;
	parm5 = 0;
        parm6 = 0;
	parm7 = 0;
        parm8 = 0;
	parm9 = 0;
        parm10 = 0;
        parm11 = 0;
        parm12 = 0;
        parm13 = 0;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() SetNewParmsKZ =
{
	//bprint("debug SetNewParmsKZ()\n");
	parm1 = 0;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 0;
        parm8 = 0;
	parm9 = 0;
        parm10 = 0;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = CLIP_SNIPER;
        parm16 = 0;
};

void() SetNewParmsSeeker =
{
	//bprint("debug SetNewParmsSeeker()\n");
	parm1 = IT_KNIFE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 0;
        parm8 = WP_ONE;
	parm9 = 0;
        parm10 = WP_ONE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = CLIP_SNIPER;
        parm16 = 0;
};


void() SetNewParmsStormtrooper =
{
	//bprint("debug SetNewParmsStormtrooper()\n");
	parm1 = IT_PM | IT_KNIFE | IT_AKM | IT_GRENADE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 90;
        parm6 = 1;
	parm7 = 0;
        parm8 = WP_RIFLE;
	parm9 = 0;
        parm10 = WP_ONE | WP_PISTOL | WP_RIFLE | WP_GRENADE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() SetNewParmsBreacher =
{
	//bprint("debug SetNewParmsBreacher()\n");
	parm1 = IT_PM | IT_KNIFE | IT_TOZ | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 25;
        parm8 = WP_SHOTGUN;
	parm9 = 0;
        parm10 = WP_ONE | WP_PISTOL | WP_SHOTGUN | WP_GRENADE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() SetNewParmsEngineer =
{
	//bprint("debug SetNewParmsEngineer()\n");
	parm1 = IT_PM | IT_KNIFE | IT_HAMMER | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 80;
	parm5 = 0;
    parm6 = 1;
	parm7 = 25;
	parm18 = 4;
        parm8 = WP_PISTOL;
	parm9 = 0;
        parm10 = WP_ONE | WP_PISTOL | WP_HAMMER | WP_GRENADE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};


void() SetNewParmsMarksman =
{
	//bprint("debug SetNewParmsMarksman()\n");
	parm1 = IT_PM | IT_KNIFE | IT_HAMMER | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
    parm6 = 2;
	parm7 = 0;
	parm3 = 30;
    parm8 = WP_SNIPER;
	parm9 = 0;
        parm10 = WP_ONE | WP_PISTOL | WP_SNIPER | WP_GRENADE;
        parm11 = CLIP_PISTOL;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = CLIP_SNIPER;
        parm16 = 0;
};

void() SetNewParmsAssassin =
{
	//bprint("debug SetNewParmsAssassin()\n");
	parm1 = IT_KNIFE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 0;
	parm5 = 0;
    parm6 = 0;
	parm7 = 0;
        parm8 = WP_ONE;
	parm9 = 0;
        parm10 = WP_ONE;
        parm11 = 0;
        parm12 = 0;
        parm13 = 0;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() PrintLevelParms =
{
	bprint("Items: ");
	bprint(ftos(parm1));
	bprint("\n");
	bprint("Health: ");
	bprint(ftos(parm2));
	bprint("\n");
	bprint("armor: ");
	bprint(ftos(parm3));
	bprint("\n");
	bprint("Pistol: ");
	bprint(ftos(parm4));
	bprint("\n");
	bprint("Rifle: ");
	bprint(ftos(parm5));
	bprint("\n");
	bprint("Grenades: ");
	bprint(ftos(parm6));
	bprint("\n");
	bprint("Shells: ");
	bprint(ftos(parm7));
	bprint("\n");
	bprint("Weapon: ");
	bprint(ftos(parm8));
	bprint("\n");
	bprint("ArmorType: ");
	bprint(ftos(parm9));
	bprint("\n");
	bprint("Weapops: ");
	bprint(ftos(parm10));
	bprint("\n");
};

void() DecodeLevelParms =
{
	//bprint("debug DecodeLevelParms()\n");
	if (serverflags)
	{
		if (world.model == "maps/start.bsp" || world.model == "maps/e1m1.bsp") SetNewParms();		// take away all stuff on starting new episode
	}
	if (deathmatch == MODE_KZ || (strstrofs(world.model,"kz_",0) != -1)) { SetNewParmsKZ(); self.weaponmodel = ""; self.health = 1000; } //strstrofs(world.model,"kz_",0)
	if (deathmatch == MODE_HNS) 
	{ 
		if(self.team == TEAM_USSR)
		{
			SetNewParmsKZ();
			self.weaponmodel = "";
		}
		else 
		{
			SetNewParmsSeeker();
		}
	}
	if(!parm2 || parm2 > 600) SetNewParms();
	self.items = parm1;
	self.health = parm2;
	//self.armorvalue = parm3;
	self.ammoPistol = parm4;
	self.ammoRifle = parm5;
	self.ammoGrenades = parm6;
	self.ammoShells = parm7;
	self.ammoSniper = parm3;
	self.ammoBarricades = parm18;
	self.weapon = parm8;
	self.armortype = parm9 * 0.01;
	self.weapons = parm10;
	self.pistolClip = parm11;
	self.shotgunClip = parm12;
	self.rifleClip = parm13;
	self.sniperClip = parm15;
	self.m60clip = parm16;
};

/*
============
FindIntermission

Returns the entity to view from
============
*/
entity() FindIntermission =
{
	//bprint("debug FindIntermission()\n");
	local	entity spot;
	local	float cyc;

	// look for info_intermission first
	spot = find (world, classname, "info_intermission");
	if (spot)
	{	// pick a random one
		cyc = random() * 4;
		while (cyc > 1)
		{
			spot = find (spot, classname, "info_intermission");
			if (!spot)
				spot = find (spot, classname, "info_intermission");
			cyc = cyc - 1;
		}
		return spot;
	}

	// then look for the start position
	spot = find (world, classname, "info_player_start");
	if (spot) return spot;
	
	// testinfo_player_start is only found in regioned levels
	spot = find (world, classname, "testplayerstart");
	if (spot) return spot;
	
	objerror ("FindIntermission: no spot");
	
	return world;
};


string nextmap;
void() GotoNextMap =
{
	//bprint("debug GotoNextMap()\n");
	if (cvar("samelevel")) changelevel (mapname); // if samelevel is set, stay on same level
	else changelevel (nextmap);
};

void() ExitIntermission =
{
	//bprint("debug ExitIntermission()\n");
// skip any text in deathmatch
	if (deathmatch)
	{
		GotoNextMap ();
		return;
	}
	
	intermission_exittime = time + 1;
	intermission_running = intermission_running + 1;

//
// run some text if at the end of an episode //message example
//
	if (intermission_running == 2)
	{
		if (world.model == "maps/e1m8.bsp")
		{
			WriteByte (MSG_ALL, SVC_CDTRACK);
			WriteByte (MSG_ALL, 2);
			WriteByte (MSG_ALL, 3);
			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "You have passed all 8 levels and escaped.\nI hope you enjoyed the game.\nYou have no idea how dreary it was to make this product.\nGame seems short and a little bit unfinished,\nbut I am still working on it.\nYou can support me by joining my discord or just texting me.\nDon't forget to try bonus levels and multiplayer.\nLeave a review! Feedback welcome!");
			return;
		}

		GotoNextMap();
	}

	GotoNextMap();
};

/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
	//bprint("debug IntermissionThink()\n");
	if (time < intermission_exittime) return;
	if (!self.button0 && !self.button1 && !self.button2) return;
	
	ExitIntermission ();
};

void() execute_changelevel =
{
	//bprint("debug execute_changelevel()\n");
	local entity	pos;
	intermission_running = 1;
	
// enforce a wait time before allowing changelevel
	// if (deathmatch) intermission_exittime = time + 5;
	// else intermission_exittime = time + 2;
	intermission_exittime = time + 2;

	WriteByte (MSG_ALL, SVC_CDTRACK);
	WriteByte (MSG_ALL, 3);
	WriteByte (MSG_ALL, 3);
	
	pos = FindIntermission ();

	other = find (world, classname, "player");
	while (other != world)
	{
		other.view_ofs = '0 0 0';
		other.angles = other.v_angle = pos.mangle;
		other.fixangle = TRUE;		// turn this way immediately
		other.nextthink = time + 0.5;
		other.takedamage = DAMAGE_NO;
		other.solid = SOLID_NOT;
		other.movetype = MOVETYPE_NONE;
		other.modelindex = 0;
		setorigin (other, pos.origin);
		other = find (other, classname, "player");
	}	

	WriteByte (MSG_ALL, SVC_INTERMISSION);
};


void() changelevel_touch =
{
	//bprint("debug changelevel_touch()\n");
	if (other.classname != "player") return;

	if ((cvar("noexit") == 1) || ((cvar("noexit") == 2) && (mapname != "start")))
	{
		T_Damage (other, self, self, 50000);
		return;
	}

	if (coop || deathmatch)
	{
		bprint (other.netname);
		bprint (" exited the level\n");
	}
	
	nextmap = self.map;

	SUB_UseTargets ();

	if (self.spawnflags & 1 && deathmatch == 0) // NO_INTERMISSION
	{	
		GotoNextMap();
		return;
	}
	
	self.touch = SUB_Null;

// we can't move people right now, because touch functions are called
// in the middle of C movement code, so set a think time to do it
	self.think = execute_changelevel;
	self.nextthink = time + 0.1;
};

/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
*/
void() trigger_changelevel =
{
	//bprint("debug trigger_changelevel()\n");
	if (!self.map) objerror ("changelevel trigger doesn't have map");
	InitTrigger ();
	self.touch = changelevel_touch;
};


/*
=============================================================================

				PLAYER GAME EDGE FUNCTIONS

=============================================================================
*/

void() set_suicide_frame;
void() PutObserverInServer;
void() respawn = // called by ClientKill and DeadThink
{
	//bprint("debug respawn()\n");
	if (coop)
	{
		CopyToBodyQue (self);	// make a copy of the dead body for appearances sake
		//setspawnparms (self);	// get the spawn parms as they were at level start
		//PutClientInServer ();	// respawn	
		
		local entity e;
		local float players;
		for (e = findchain(classname, "player"); e; e = e.chain) if(e.deadflag != DEAD_DEAD && e.deadflag != DEAD_DYING && e.deadflag != DEAD_RESPAWNABLE) players = players + 1;
		if(players) PutObserverInServer();
		else localcmd ("restart\n");
	}
	else if (deathmatch)
	{
		CopyToBodyQue (self);	// make a copy of the dead body for appearances sake

		// if(deathmatch == MODE_DE) 
		// {
			// SetNewParmsObserver();
			// PutObserverInServer();
		// }
		// else 
		{
			if (deathmatch == MODE_KZ || (strstrofs(world.model,"kz_",0) != -1)) SetNewParmsKZ();
			else		// set default spawn parms
			{
				if(self.class == CLASS_SHTORMTROOPER) SetNewParmsStormtrooper();
				else if(self.class == CLASS_BREACHER) SetNewParmsBreacher();
				else if(self.class == CLASS_MARKSMAN) SetNewParmsMarksman();
				else if(self.class == CLASS_ENGINEER) SetNewParmsEngineer();
				else if(self.class == CLASS_ASSASSIN) SetNewParmsAssassin();
				else SetNewParms();
			}
			PutClientInServer (); // respawn	
		}
	}
	else
	{	// restart the entire server
		localcmd ("restart\n");
	}
};


/*
============
ClientKill

Player entered the suicide command
============
*/
void() ClientKill =
{
	T_Damage(self, world, world, 200);
	// if(deathmatch == MODE_HNS) return;
	// if ((intermission_running)&&((coop)||(deathmatch)))  // not allowed during intermission
		// return;
	// bprint (self.netname);
	// bprint (" suicides\n");
	// set_suicide_frame ();
	// self.modelindex = modelindex_ussr_aps;
	// self.frags = self.frags - 2;	// extra penalty
	// respawn ();
};

float(vector v) CheckSpawnPoint =
{
	return FALSE;
};

/*
============
SelectSpawnPoint

Returns the entity to spawn at
============
*/
entity() SelectSpawnPoint =
{
	local	entity spot;
	local	entity thing;
	local	float  pcount;
	
	spot = find (world, classname, "testplayerstart");
	if (spot) return spot;
		
	if (coop)
	{
		lastspawn = find(lastspawn, classname, "info_player_coop");
		if (lastspawn == world) lastspawn = find (lastspawn, classname, "info_player_start");
		if (lastspawn != world) return lastspawn;
	}
	else if (deathmatch)
	{
		spot = lastspawn;	
		while (1)
		{
			if(teamplay) 
			{
				if(self.team == TEAM_USSR) spot = find(spot, classname, "info_player_ussr"); 
				else if(self.team == TEAM_USA) spot = find(spot, classname, "info_player_usa"); 
				else spot = find(spot, classname, "info_player_deathmatch");
			}
			else spot = find(spot, classname, "info_player_deathmatch");
			if (spot != world)
			{
				if (spot == lastspawn) return lastspawn;
				pcount = 0;
				thing = findradius(spot.origin, 32);
				while(thing)
				{
					if (thing.classname == "player") pcount = pcount + 1;
					thing = thing.chain;
				}
				if (pcount == 0)
				{
					lastspawn = spot;
					return spot;
				}
			}
		}
	}

	if (serverflags) // return with a rune to start
	{	
		spot = find (world, classname, "info_player_start2");
		if (spot) return spot;
	}
	
	spot = find (world, classname, "info_player_start");
	if (!spot) error ("PutClientInServer: no info_player_start on level");
	
	return spot;
};






/*
===========
PutClientInServer

called each time a player is spawned
============
*/
void() DecodeLevelParms;
void() PlayerDie;
void() PutObserverInServer;

void() DemoCameraThink =
{
	local entity	pos;
	self.velocity = '0 0 0';
	pos = FindIntermission ();
	self.angles = pos.mangle;
	self.v_angle = pos.mangle;
	setorigin (self, pos.origin);
}
void() PutClientInServer =
{
	//PrintLevelParms();
	//bprint("PutClientInServer\n");
	stuffcmd (self, "r_ambient 1\n");
	stuffcmd (self, strcat("teamplay ", ftos(teamplay), "\n"));
	if(world.model == "maps/demo.bsp")
	{
		local entity	pos;
		pos = FindIntermission ();
		self.health = 666;
		self.view_ofs = '0 0 0';
		self.angles = self.v_angle = pos.mangle;
		self.fixangle = TRUE;		// turn this way immediately
		self.nextthink = time + 0.5;
		self.think = DemoCameraThink;
		self.takedamage = DAMAGE_NO;
		self.solid = SOLID_NOT;
		self.movetype = MOVETYPE_NONE;
		self.modelindex = 0;
		setorigin (self, pos.origin);
		self.weapon = WP_SNIPER;
		stuffcmd (self, "crosshair 5\n");
		stuffcmd (self, "togglemenu\n");
		return;
	}
	
	 
	if(deathmatch)
	{
		if (self.team == NO_TEAM && self.class == NO_TEAM) // if you don't have a team selected 
		{ 
			PutObserverInServer(); // Run the observer func 
			return; // and forget the rest 
		}
	}
	local entity spot;

	spot = SelectSpawnPoint ();

	self.classname = "player";
	self.health = 100;
	self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_WALK;
	self.show_hostile = 0;
	self.max_health = 100;
	self.flags = FL_CLIENT;
	self.air_finished = time + 12;
	self.dmg = 2;   		// initial water damage
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
	self.invincible_time = 0;
	//if(coop) self.team = 1;

	if(coop && parm8 == 0) SetNewParms();
	DecodeLevelParms();
	
	W_SetCurrentAmmo();

	self.attack_finished = time;
	self.th_pain = player_pain;
	self.th_die = PlayerDie;
	self.deadflag = DEAD_NO;
	self.pausetime = 0; // paustime is set by teleporters to keep the player from moving a while
	
	self.origin = self.oldorigin = spot.origin + '0 0 1';	// 1998-07-21 Respawning where player died fix by Robert Field
	self.angles = spot.angles;
	self.fixangle = TRUE;		// turn this way immediately

	if(self.weapon == WP_PISTOL) 
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_pistol.md3");
		else setmodel (self, "models/ussr_pistol.md3");
		playerPistolSwitch();
	}
	else if(self.weapon == WP_ONE) 
	{
		if (deathmatch == MODE_HNS) setmodel (self, "models/runner_blue.md3");
		else
		{
			if(self.team == TEAM_USA) setmodel (self, "models/usa_knife.md3");
			else setmodel (self, "models/ussr_knife.md3");
			playerKnifeSwitch();
		}
	}
	else if(self.weapon == WP_SHOTGUN)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_shot.md3");
		else setmodel (self, "models/ussr_shot.md3");
		player_TozSwitch();
	}
	else if(self.weapon == WP_RIFLE)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_rifle.md3");
		else setmodel (self, "models/ussr_rifle.md3");
		playerRifleSwitch();
	}
	else if(self.weapon == WP_SNIPER)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_sniper.md3");
		else setmodel (self, "models/ussr_sniper.md3");
		playerSniperSwitch();
	}
	else if(self.weapon == WP_GRENADE) player_HESwitch();
	else setmodel (self, "models/runner_red.md3");
	
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	self.view_ofs = '0 0 24';
	self.velocity = '0 0 0';
	
	player_stand1 ();
	
	if (deathmatch || coop)
	{
		makevectors(self.angles);
		spawn_tfog (self.origin + v_forward*20);
	}
	if(deathmatch) spawn_tdeath (self.origin, self);
};







/*
=============================================================================

				QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() global_think =
{
	local entity e;
	local float players;
	if(deathmatch && AUTOBOTS)
	{
		for (e = findchain(classname, "player"); e; e = e.chain) players = players + 1;
		for (e = findchain(classname, "observer"); e; e = e.chain) players = players + 1;
		if(players < AUTOBOTS) SpawnBot();
		if(players && players > AUTOBOTS)
		{
			e = find(world, classname, "player");
			if(e)
			{
				while (e)
				{
					if (e && clienttype(e) == CLIENTTYPE_BOT) 
					{
						dropclient(e);
						return;
					}
				}
			}
		}
	}
	if(coop && time > 600)
	{
		for (e = findchain(classname, "player"); e; e = e.chain) players = players + 1;
		for (e = findchain(classname, "observer"); e; e = e.chain) players = players + 1;
		if(!players) 
		{
			bprint("restarting\n");
			localcmd("coop 1; maxplayers 4; deathmatch 0; map e1m1\n");
		}
	}
	if(coop)
	{
		local float allive;
		for (e = findchain(classname, "player"); e; e = e.chain) players = players + 1;
		for (e = findchain(classname, "observer"); e; e = e.chain) players = players + 1;
		if(players)
		{
			
			for (e = findchain(classname, "player"); e; e = e.chain) 
			{
				
				//antiafk
				if(e.lastAngles == e.v_angle) e.afkWarnings = e.afkWarnings + 1;
				else e.afkWarnings = 0;
				if(e.afkWarnings > rint(ANTIAFK * 0.5))
				{
					centerprint(e, "MOVE OR YOU WILL BE KICKED FOR BEING AFK");
					sound (e, CHAN_BODY, "misc/talk.wav", 1, ATTN_IDLE);
				}
				if(e.afkWarnings > ANTIAFK) 
				{
					bprint(e.netname);
					bprint(" was kicked for being afk\n");
					dropclient (e);
				}
				e.lastAngles = e.v_angle;
				
				if(e.deadflag != DEAD_DEAD && e.deadflag != DEAD_DYING && e.deadflag != DEAD_RESPAWNABLE) allive = allive + 1;
			}
			if(!allive) localcmd ("restart\n");
		}
	}
		
	self.nextthink = time + 5;
}

void() info_player_start =
{
	self.think = global_think;
	self.nextthink = time + 5;
};


/*QUAKED info_player_start2 (1 0 0) (-16 -16 -24) (16 16 24)
Only used on start map for the return point from an episode.
*/
void() info_player_start2 =
{
};


/*
saved out by quaked in region mode
*/
void() testplayerstart =
{
};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for deathmatch games
*/
void() info_player_deathmatch =
{
};

void() info_player_usa =
{
};

void() info_player_ussr =
{
};

void() info_player_coop =
{
};

/*
===============================================================================

RULES

===============================================================================
*/

/*
go to the next level for deathmatch
only called if a time or frag limit has expired
*/
void() NextLevel =
{
	local entity o;
	local float r;
	if(deathmatch == 1)
	{
		r = rint(random() * 6);
		if(r == 1) nextmap = "dusty";
		else if(r == 2) nextmap = "snowy";
		else if(r == 3) nextmap = "factory";
		else if(r == 4) nextmap = "terrain";
		else if(r == 5) nextmap = "trains";
		else nextmap = "dusty";
		
		if(mapname == nextmap)
		//while(mapname == nextmap)
		{
			r = rint(random() * 6);
			if(r == 1) nextmap = "dusty";
			else if(r == 2) nextmap = "snowy";
			else if(r == 3) nextmap = "factory";
			else if(r == 4) nextmap = "terrain";
			else if(r == 5) nextmap = "trains";
			else nextmap = "dusty";
		}
		
		//o = find(world, classname, "trigger_changelevel");
		if (!o)
		{
			mapname = nextmap;
			o = spawn();
			o.map = mapname;
		}
		
		nextmap = o.map;
		gameover = TRUE;
		
		if (o.nextthink < time)
		{
			o.think = execute_changelevel;
			o.nextthink = time + 0.1;
		}
	}
	else
	{
		if (mapname == "start")
		{
			if (!cvar("registered"))
			{
				mapname = "e1m1";
			}
			else if (!(serverflags & 1))
			{
				mapname = "e1m1";
				serverflags = serverflags | 1;
			}
			else if (!(serverflags & 2))
			{
				mapname = "e2m1";
				serverflags = serverflags | 2;
			}
			else if (!(serverflags & 4))
			{
				mapname = "e3m1";
				serverflags = serverflags | 4;
			}
			else if (!(serverflags & 8))
			{
				mapname = "e4m1";
				serverflags = serverflags - 7;
			}

			o = spawn();
			o.map = mapname;
		}
		else
		{
			// find a trigger changelevel
			o = find(world, classname, "trigger_changelevel");

			// go back to start if no trigger_changelevel
			if (!o)
			{
				mapname = "start";
				o = spawn();
				o.map = mapname;
			}
		}

		nextmap = o.map;
		gameover = TRUE;
		
		if (o.nextthink < time)
		{
			o.think = execute_changelevel;
			o.nextthink = time + 0.1;
		}
	}
};

/*
============
CheckRules

Exit deathmatch games upon conditions
============
*/
void() CheckRules =
{
	local	float		timelimit;
	local	float		fraglimit;
	
	if (gameover)	// someone else quit the game already
		return;
		
	timelimit = cvar("timelimit") * 60;
	fraglimit = cvar("fraglimit");
	
//	if (timelimit && time >= timelimit)
	if (deathmatch && timelimit && time >= timelimit)	// 1998-07-27 Timelimit/Fraglimit fix by Maddes
	{
		NextLevel ();
		return;
	}
	
//	if (fraglimit && self.frags >= fraglimit)
	if (deathmatch && fraglimit && self.frags >= fraglimit)	// 1998-07-27 Timelimit/Fraglimit fix by Maddes
	{
		NextLevel ();
		return;
	}	
};

//============================================================================

void() PlayerDeathThink =
{
	local float		forward;
	local entity nearest;
	local entity e;
	if(deathmatch == MODE_HNS)
	{
		if(self.team == TEAM_USSR)
		{
			self.team = TEAM_USA;
			setcolor(self, 1);
			for (e = findchain(classname, "player"); e; e = e.chain) 
			{
				if(e != self && e.team != TEAM_USSR)
				{
					//bprint(e.netname);
					//bprint("\n");
					if (!nearest) nearest = e;
					else if(vlen(e.origin - self.origin) < vlen(nearest.origin - self.origin)) 
					{
						nearest = e;
					}
				}
			}
			if(nearest)
			{
				setcolor(nearest, 0);
				nearest.team = TEAM_USSR;
				nearest.weapons = 0;
				nearest.weapon = 0;
				nearest.weaponmodel = "";
				nearest.model = "models/runner_red.md3";
				setmodel(nearest, "models/runner_red.md3");
				nearest.health = 100;
			}
		}
		else for (e = findchain(classname, "player"); e; e = e.chain) 
		{
			if(e != self && e.team == TEAM_USSR)
			{
				e.health = 100;
			}
		}
	}

	if (self.flags & FL_ONGROUND)
	{
		forward = vlen (self.velocity);
		forward = forward - 20;
		if (forward <= 0) self.velocity = '0 0 0';
		else self.velocity = forward * normalize(self.velocity);
	}

// wait for all buttons released
	if (self.deadflag == DEAD_DEAD)
	{
		if (self.button2 || self.button1 || self.button0) return;
		self.deadflag = DEAD_RESPAWNABLE;
		return;
	}
	if(deathmatch == MODE_DE) return;
// wait for any button down
	if (clienttype(self) == CLIENTTYPE_BOT) respawn();
	if (!self.button2 && !self.button1 && !self.button0) return;

	self.button0 = 0;
	self.button1 = 0;
	self.button2 = 0;
	respawn();
};


void() PlayerJump =
{	
	if (self.flags & FL_WATERJUMP) return;
	if((!deathmatch && (strstrofs(world.model,"kz_",0) == -1)) && (self.lastTouch + 0.72 > time)) return;
	if (self.waterlevel >= 2)
	{
		if (self.watertype == CONTENT_WATER) self.velocity_z = 100;
		else if (self.watertype == CONTENT_SLIME) self.velocity_z = 80;
		else self.velocity_z = 50;

// play swiming sound
		if (self.swim_flag < time)
		{
			self.swim_flag = time + 1;
			//if (random() < 0.5) sound (self, CHAN_BODY, "misc/water1.wav", 1, ATTN_NORM);
			//else sound (self, CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
		}

		return;
	}

	if (!(self.flags & FL_ONGROUND)) return;
	//if (!(self.flags & FL_JUMPRELEASED)) return;	// prevent autobhop

	self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
	self.flags = self.flags - FL_ONGROUND;	// don't stairwalk
	
	self.button2 = 0;
// player jumping sound
	self.lastTouch = time;
	local float rand;
	rand = random();
	sound (self, CHAN_BODY, "player/jump1.wav", 1, ATTN_NORM);
	self.velocity_z = self.velocity_z + 270;
	if(self.class == CLASS_ASSASSIN && deathmatch < 3) self.velocity_z = self.velocity_z + 100;
};


/*
===========
WaterMove

============
*/
.float	dmgtime;

void() WaterMove =
{
//dprint (ftos(self.waterlevel));
	if (self.movetype == MOVETYPE_NOCLIP) return;
	if (self.health < 0) return;

	if (self.waterlevel != 3)
	{
		//if (self.air_finished < time) sound (self, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
		//else if (self.air_finished < time + 9) sound (self, CHAN_VOICE, "player/gasp1.wav", 1, ATTN_NORM);
		self.air_finished = time + 12;
		self.dmg = 2;
	}
	else if (self.air_finished < time)
	{	// drown!
		if (self.pain_finished < time)
		{
			self.dmg = self.dmg + 2;
			if (self.dmg > 15)
				self.dmg = 10;
			T_Damage (self, world, world, self.dmg);
			self.pain_finished = time + 1;
		}
	}
	
	if (!self.waterlevel)
	{
		if (self.flags & FL_INWATER)
		{	
			// play leave water sound
			//sound (self, CHAN_BODY, "misc/outwater.wav", 1, ATTN_NORM);
			self.flags = self.flags - FL_INWATER;
		}
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{	// do damage
		if (self.dmgtime < time)
		{
			if (self.radsuit_finished > time) self.dmgtime = time + 1;
			else self.dmgtime = time + 0.2;

			T_Damage (self, world, world, 10*self.waterlevel);
		}
	}
	else if (self.watertype == CONTENT_SLIME)
	{	// do damage
		if (self.dmgtime < time && self.radsuit_finished < time)
		{
			self.dmgtime = time + 1;
			T_Damage (self, world, world, 4*self.waterlevel);
		}
	}
	
	if ( !(self.flags & FL_INWATER) )
	{	

// player enter water sound

		// if (self.watertype == CONTENT_LAVA)
			// sound (self, CHAN_BODY, "player/inlava.wav", 1, ATTN_NORM);
		// if (self.watertype == CONTENT_WATER)
			// sound (self, CHAN_BODY, "player/inh2o.wav", 1, ATTN_NORM);
		// if (self.watertype == CONTENT_SLIME)
			// sound (self, CHAN_BODY, "player/slimbrn2.wav", 1, ATTN_NORM);

		self.flags = self.flags + FL_INWATER;
		self.dmgtime = 0;
	}
	
	if (! (self.flags & FL_WATERJUMP) )
		self.velocity = self.velocity - 0.8*self.waterlevel*frametime*self.velocity;
};

void() CheckWaterJump =
{
	local vector start, end;

// check for a jump-out-of-water
	makevectors (self.angles);
	start = self.origin;
	start_z = start_z + 8; 
	v_forward_z = 0;
	normalize(v_forward);
	end = start + v_forward*24;
	traceline (start, end, TRUE, self);
	if (trace_fraction < 1)
	{	// solid at waist
		start_z = start_z + self.maxs_z - 8;
		end = start + v_forward*24;
		self.movedir = trace_plane_normal * -50;
		traceline (start, end, TRUE, self);
		if (trace_fraction == 1)
		{	// open at eye level
			self.flags = self.flags | FL_WATERJUMP;
			self.velocity_z = 225;
			self.flags = self.flags - (self.flags & FL_JUMPRELEASED);
			self.teleport_time = time + 2;	// safety net
			return;
		}
	}
};


/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() UseTouch =
{
	if (other.classname != "worldspawn" && (strstrofs(other.classname,"trigger", 0) == -1) && other.message)
	{
		centerprint(self.owner, other.message);
		sound (other, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM);
	}
}

void() UseSmth =
{
	local	entity missile;
	if(self.classname == "player")
	{
		missile = spawn ();
		missile.owner = self;
		missile.movetype = MOVETYPE_BOUNCE;
		missile.solid = SOLID_TRIGGER;
		missile.classname = "useprefab";
		missile.touch = UseTouch;

		makevectors (self.v_angle);
		if (self.v_angle_x) missile.velocity = v_forward*1000;
		else
		{
			missile.velocity = aim(self, 10000);
			missile.velocity = missile.velocity * 200 + '0 0 -300';
			missile.velocity_z = 30;
		}
		
		missile.nextthink = time + 0.07;
		missile.think = SUB_Remove;
		
		missile.angles = vectoangles(missile.velocity);
		setsize (missile, '-1 -1 -1', '1 1 1');
		setorigin (missile, self.origin + (v_up * 20));
	}
}

void() Nametags =
{
	local vector src;
	makevectors (self.v_angle);
	src = (self.origin + self.view_ofs + (v_forward * TE_LAVASPLASH)); 
	src_y = (self.absmin_y + (self.size_y * 0.500));
	traceline (src, (src + v_forward * 1024) - (v_right) - (v_up), FALSE, self);
	if (trace_ent.classname != "player") return;
	centerprint(self, trace_ent.netname);
}
void() BotPreThink;
void() PlayerPreThink =
{
	if (clienttype(self) == CLIENTTYPE_BOT) 
	{
		BotPreThink();
	}
	// bprint(ftos(self.origin_x));
	// bprint(" | ");
	// bprint(ftos(self.origin_y));
	// bprint(" | ");
	// bprint(ftos(self.origin_z));
	// bprint("\n");
		
	// bprint(ftos(self.angles_x));
	// bprint(" | ");
	// bprint(ftos(self.angles_y));
	// bprint(" | ");
	// bprint(ftos(self.angles_z));
	// bprint("\n");
	// if(self.flags & FL_JUMPRELEASED) bprint("1 ");
	// else bprint("0 ");
	// if(self.flags & FL_ONGROUND) bprint("1 ");
	// else bprint("0 ");
	// if(self.flags & FL_LADDERJUMP) bprint("1 ");
	// else bprint("0 ");
	// bprint("\n");
	//bprint(ftos(self.zoomlevel));
	//bprint("\n");

	if (intermission_running)
	{
		IntermissionThink ();	// otherwise a button could be missed between
		return;					// the think tics
	}
	
	if(deathmatch)
	{
		if (self.team == NO_TEAM && self.class == NO_TEAM && self.classname != "observer") PutObserverInServer(); //Make me an observer
		if (self.team != NO_TEAM && self.class != NO_TEAM && self.classname != "player") PutClientInServer();
	}
	if (self.view_ofs == '0 0 0') // intermission or finale
	{
		self.zoomlevel = 0;
		return;		
	}

	SelectClass();

	makevectors (self.v_angle);		// is this still used

	CheckRules ();
	WaterMove ();

	if (self.waterlevel == 2) CheckWaterJump ();

	if (self.deadflag >= DEAD_DEAD)
	{
		PlayerDeathThink ();
		return;
	}
	
	if (self.deadflag == DEAD_DYING) return;	// dying, so do nothing

	if(self.flags & FL_ONGROUND) self.flags = self.flags - (self.flags & FL_LADDERJUMP);
	if (self.button2) PlayerJump ();
	else self.flags = self.flags | FL_JUMPRELEASED;
	// if(self.weapon == WP_RIFLE) stuffcmd (self, "cl_forwardspeed 185;cl_backspeed 185;cl_sidespeed 185;\n");
	// else if(self.weapon == WP_SHOTGUN) stuffcmd (self, "cl_forwardspeed 175;cl_backspeed 175;cl_sidespeed 175;\n");
	// else stuffcmd (self, "cl_forwardspeed 200;cl_backspeed 200;cl_sidespeed 200;\n");

	if(self.buttonuse && self.class == CLASS_ASSASSIN && deathmatch < 3)
	{		
		if(!self.hooking) FireHook ();
	}
	else BreakHook();
	
	if(self.buttonuse) UseSmth();
	if(deathmatch || coop) Nametags();

	if (self.impulse == 14) //flashlight
	{
		flash_toggle ();
		self.impulse = 0;
	}
	if (clienttype(self) != CLIENTTYPE_BOT)
	{
		if(self.button3)
		{
			if(!self.duck)
			{
				self.duck = 1;
				setsize (self, '-16 -16 -24', '16 16 18');
				self.view_ofs = '0 0 11';
			}
		}
		else
		{
			if(self.duck)
			{
				self.duck = 0;
				setsize (self, '-16 -16 -24', '16 16 35');
				self.view_ofs = '0 0 23';
			}
		}
	}
	



	if(self.movetype == MOVETYPE_NOCLIP && !self.button2 && !self.button3)
	{
		local float sv_accelerate;
		local float sv_friction;
		local float sv_maxspeed;
		local vector wishvel, wishdir;
		local float wishspeed, f;
		
		sv_maxspeed = cvar("sv_maxspeed");
		sv_friction = cvar("sv_friction");
		sv_accelerate = cvar("sv_accelerate");
		
		self.velocity = self.velocity * (1 - frametime * sv_friction);
		makevectors(self.v_angle);
		wishvel = v_forward * self.movement_x + v_right * (self.movement_z * 30);
		
		// acceleration
		wishdir = normalize(wishvel);
		wishspeed = vlen(wishvel);
		//if (wishspeed > sv_maxspeed) wishspeed = sv_maxspeed;
		
		if (time >= self.teleport_time)
		{
			f = wishspeed - (self.velocity * wishdir);
			if (f > 0) self.velocity = self.velocity + wishdir * min(f, sv_accelerate * frametime * wishspeed);
			self.velocity_z =  self.velocity_z * 6;
			if(self.button4) self.velocity = self.velocity * 4;
		}
	}
	
	if (time < self.pausetime) self.velocity = '0 0 0'; // teleporters can force a non-moving pause time
	
	if(time > self.attack_finished && self.currentammo == 0 && self.weapon != IT_KNIFE)
	{
		//if(self.weapon == WP_GRENADE && self.attack_finished == 0) CycleWeaponReverseCommand();
		if(self.weapon == WP_RIFLE && self.rifleClip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_SHOTGUN && self.shotgunClip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_PISTOL && self.pistolClip < 1) CycleWeaponReverseCommand();
		//self.weapon = W_BestWeapon ();
		//W_SetCurrentAmmo ();
	}
};


/*
================
PlayerPostThink

Called every frame after physics are run
================
*/


void() PlayerPostThink =
{
	if (self.view_ofs == '0 0 0') return;		// intermission or finale
	if (self.deadflag) return;
	if(fabs(self.velocity_x + self.velocity_y + self.velocity_z) > 60) footsteps();
	
// do weapon stuff
	W_WeaponFrame();
// check to see if player landed and play landing sound	
	if ((self.jump_flag < -300) && (self.flags & FL_ONGROUND) && (self.health > 0))
	{
		//if (self.watertype == CONTENT_WATER) sound (self, CHAN_BODY, "player/h2ojump.wav", 1, ATTN_NORM);
		//else 
		if (self.jump_flag < -500)
		{
			if(self.class != CLASS_ASSASSIN) T_Damage (self, world, world, -self.jump_flag *0.05); 
			sound (self, CHAN_VOICE, "player/land2.wav", 0.6, ATTN_NORM);
			self.deathtype = "falling";
		}
		else sound (self, CHAN_VOICE, "player/land1.wav", 0.6, ATTN_NORM);

		self.jump_flag = 0;
		self.punchangle_x = 3;
	}

	if (!(self.flags & FL_ONGROUND)) self.jump_flag = self.velocity_z;
};


/*
===========
ClientConnect

called when a player connects to a server
============
*/
void() ClientConnect =
{
	bprint (self.netname);
	bprint (" entered the game\n");
	self.team = NO_TEAM; //Koolio, you're teamless on connecting
	if (intermission_running) ExitIntermission (); // a client connecting during an intermission can cause problems
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	if (gameover) return;
	// if the level end trigger has been activated, just return
	// since they aren't *really* leaving

	// let everyone else know
	bprint (self.netname);
	bprint (" left the game with ");
	bprint (ftos(self.frags));
	bprint (" frags\n");
	//sound (self, CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE);
	set_suicide_frame ();
};

/*
===========
ClientObituary

called when a player dies 
KILLTAB
============
*/
void(entity targ, entity attacker) ClientObituary =
{
	local	float rnum;
	local	string deathstring;
	rnum = random();

	if (targ.classname == "player")
	{
		if (attacker.classname == "teledeath")
		{
			bprint (targ.netname);
			bprint (" was telefragged by ");
			bprint (attacker.owner.netname);
			bprint ("\n");

			attacker.owner.frags = attacker.owner.frags + 1;
			return;
		}

		if (attacker.classname == "teledeath2")
		{
			bprint ("Satan's power deflects ");
			bprint (targ.netname);
			bprint ("'s telefrag\n");

			targ.frags = targ.frags - 1;
			return;
		}

		if (attacker.classname == "player")
		{
			if (targ == attacker)
			{
				// killed self
				attacker.frags = attacker.frags - 1;
				bprint (targ.netname);
				
				if (targ.weapon == 64 && targ.waterlevel > 1)
				{
					bprint (" discharges into the water.\n");
					return;
				}
				if (targ.weapon == IT_GRENADE) bprint (" tries to put the pin back in\n");
				else bprint (" becomes bored with life\n");
				return;
			}
			else if ((teamplay == 2) /*&& (targ.team > 0)*/ &&(targ.team == attacker.team) )
			{
				if (rnum < 0.25) deathstring = " mows down a teammate\n";
				else if (rnum < 0.50) deathstring = " checks his glasses\n";
				else if (rnum < 0.75) deathstring = " gets a frag for the other team\n";
				else deathstring = " loses another friend\n";
				
				bprint (attacker.netname);
				bprint (deathstring);
				attacker.frags = attacker.frags - 1;
				return;
			}
			else
			{
				attacker.frags = attacker.frags + 1;
				bprint(attacker.netname);
				deathstring = " >";
				bprint(deathstring);
				if(targ.headshot == 1) bprint("");
				bprint(" ");
				bprint(targ.netname);
				bprint("\n");
			}
			return;
		}
		else
		{
			targ.frags = targ.frags - 1;
			bprint (targ.netname);

			// killed by a montser?
			if (attacker.flags & FL_MONSTER)
			{
				bprint (" was killed\n");
				return;
			}

			// tricks and traps
			if (attacker.classname == "explo_box")
			{
				bprint (" blew up\n");
				return;
			}
			if (attacker.solid == SOLID_BSP && attacker != world)
			{	
				bprint (" was squished\n");
				return;
			}
			if (attacker.classname == "fireball")
			{
				bprint (" ate a lavaball\n");
				return;
			}
			if (attacker.classname == "trigger_changelevel")
			{
				bprint (" tried to leave\n");
				return;
			}

			// in-water deaths
			rnum = targ.watertype;
			if (rnum == -3)
			{
				if (random() < 0.5) bprint (" sleeps with the fishes\n");
				else bprint (" sucks it down\n");
				return;
			}
			else if (rnum == -4)
			{
				if (random() < 0.5) bprint (" gulped a load of slime\n");
				else bprint (" can't exist on slime alone\n");
				return;
			}
			else if (rnum == -5)
			{
				if (targ.health < -15)
				{
					bprint (" burst into flames\n");
					return;
				}
				if (random() < 0.5) bprint (" turned into hot slag\n");
				else bprint (" visits the Volcano God\n");
				return;
			}

			// fell to their death?
			if (targ.deathtype == "falling")
			{
				targ.deathtype = "";
				bprint (" fell to his death\n");
				return;
			}

			// hell if I know; he's just dead!!!
			bprint (" died\n");
		}
	}
};
