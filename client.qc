
// prototypes
void () W_WeaponFrame;
void() W_SetCurrentAmmo;
void() player_pain;
void() player_stand1;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;

float	modelindex_ussr_knife, modelindex_ussr_aps, modelindex_ussr_toz, modelindex_ussr_ak74,modelindex_ussr_mosin;

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
	parm3 = self.armorvalue;
	parm4 = self.ammo_9x18;
	parm5 = self.ammo545x39;
	parm6 = self.ammo_rockets;
	parm7 = self.ammo_shells;
	parm8 = self.weapon;
	parm9 = self.armortype * 100;
	parm10 = self.weapons;
	parm11 = self.PMclip;
    parm12 = self.mossclip;
    parm13 = self.AKMclip;
	parm15 = self.psg1clip;
	parm16 = self.m60clip;
};

void() SetNewParms =
{
	parm1 = IT_PM | IT_KNIFE | IT_GRENADE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 0;
        parm8 = WP_PM;
	parm9 = 0;
        parm10 = WP_ONE | WP_PM | WP_GRENADE;
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 5;
        parm16 = 0;
};

void() SetNewParmsObserver =
{
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
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 5;
        parm16 = 0;
};

void() SetNewParmsSeeker =
{
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
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 5;
        parm16 = 0;
};


void() SetNewParmsStormtrooper =
{
	parm1 = IT_PM | IT_KNIFE | IT_AKM | IT_GRENADE;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 90;
        parm6 = 1;
	parm7 = 0;
        parm8 = WP_AKM;
	parm9 = 0;
        parm10 = WP_ONE | WP_PM | WP_AKM | WP_GRENADE;
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() SetNewParmsBreacher =
{
	parm1 = IT_PM | IT_KNIFE | IT_TOZ | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
        parm6 = 3;
	parm7 = 25;
        parm8 = WP_TOZ;
	parm9 = 0;
        parm10 = WP_ONE | WP_PM | WP_TOZ | WP_GRENADE;
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};

void() SetNewParmsEngineer =
{
	parm1 = IT_PM | IT_KNIFE | IT_HAMMER | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 60;
	parm5 = 0;
    parm6 = 1;
	parm7 = 25;
	parm18 = 3;
        parm8 = WP_PM;
	parm9 = 0;
        parm10 = WP_ONE | WP_PM | WP_HAMMER | WP_GRENADE;
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 0;
        parm16 = 0;
};


void() SetNewParmsMarksman =
{
	parm1 = IT_PM | IT_KNIFE | IT_HAMMER | IT_GRENADE ;
	parm2 = 100;
	parm3 = 0;
	parm4 = 40;
	parm5 = 0;
    parm6 = 2;
	parm7 = 0;
	parm17 = 25;
    parm8 = WP_MOSIN;
	parm9 = 0;
        parm10 = WP_ONE | WP_PM | WP_MOSIN | WP_GRENADE;
        parm11 = 20;
        parm12 = 7;
        parm13 = 30;
        parm14 = 0;
        parm15 = 5;
        parm16 = 0;
};

void() SetNewParmsAssassin =
{
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

void() DecodeLevelParms =
{
	if (serverflags)
	{
		if (world.model == "maps/start.bsp" || world.model == "maps/e1m1.bsp") SetNewParms();		// take away all stuff on starting new episode
	}
	if (deathmatch == MODE_KZ) { SetNewParmsKZ(); self.weaponmodel = ""; self.health = 1000; } //strstrofs(world.model,"kz_",0)
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
	self.items = parm1;
	self.health = parm2;
	self.armorvalue = parm3;
	self.ammo_9x18 = parm4;
	self.ammo545x39 = parm5;
	self.ammo_rockets = parm6;
	self.ammo_shells = parm7;
	self.ammo_762x54 = parm17;
	self.ammo_barricades = parm18;
	self.weapon = parm8;
	self.armortype = parm9 * 0.01;
        self.weapons = parm10;
        self.PMclip = parm11;
        self.mossclip = parm12;
        self.AKMclip = parm13;
        self.psg1clip = parm15;
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
	if (spot)
		return spot;
	
// testinfo_player_start is only found in regioned levels
	spot = find (world, classname, "testplayerstart");
	if (spot)
		return spot;
	
	objerror ("FindIntermission: no spot");
	
	return world;
};


string nextmap;
void() GotoNextMap =
{
	if (cvar("samelevel"))	// if samelevel is set, stay on same level
		changelevel (mapname);
	else
		changelevel (nextmap);
};


void() ExitIntermission =
{
// skip any text in deathmatch
	if (deathmatch)
	{
		GotoNextMap ();
		return;
	}
	
	intermission_exittime = time + 1;
	intermission_running = intermission_running + 1;

//
// run some text if at the end of an episode
//
	if (intermission_running == 2)
	{
		// if (world.model == "maps/e1m7.bsp")
		// {
			// WriteByte (MSG_ALL, SVC_CDTRACK);
			// WriteByte (MSG_ALL, 2);
			// WriteByte (MSG_ALL, 3);
			// if (!cvar("registered"))
			// {
				// WriteByte (MSG_ALL, SVC_FINALE);
				// WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task in the other three\nhaunted lands of Quake. Or are you? If\nyou don't register Quake, you'll never\nknow what awaits you in the Realm of\nBlack Magic, the Netherworld, and the\nElder World!");
			// }
			// else
			// {
				// WriteByte (MSG_ALL, SVC_FINALE);
				// WriteString (MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task. A Rune of magic\npower lies at the end of each haunted\nland of Quake. Go forth, seek the\ntotality of the four Runes!");
			// }
			// return;
		// }
		// else if (world.model == "maps/e2m6.bsp")
		// {
			// WriteByte (MSG_ALL, SVC_CDTRACK);
			// WriteByte (MSG_ALL, 2);
			// WriteByte (MSG_ALL, 3);

			// WriteByte (MSG_ALL, SVC_FINALE);
			// WriteString (MSG_ALL, "The Rune of Black Magic throbs evilly in\nyour hand and whispers dark thoughts\ninto your brain. You learn the inmost\nlore of the Hell-Mother; Shub-Niggurath!\nYou now know that she is behind all the\nterrible plotting which has led to so\nmuch death and horror. But she is not\ninviolate! Armed with this Rune, you\nrealize that once all four Runes are\ncombined, the gate to Shub-Niggurath's\nPit will open, and you can face the\nWitch-Goddess herself in her frightful\notherworld cathedral.");
			// return;
		// }
		// else if (world.model == "maps/e3m6.bsp")
		// {
			// WriteByte (MSG_ALL, SVC_CDTRACK);
			// WriteByte (MSG_ALL, 2);
			// WriteByte (MSG_ALL, 3);

			// WriteByte (MSG_ALL, SVC_FINALE);
			// WriteString (MSG_ALL, "The charred viscera of diabolic horrors\nbubble viscously as you seize the Rune\nof Hell Magic. Its heat scorches your\nhand, and its terrible secrets blight\nyour mind. Gathering the shreds of your\ncourage, you shake the devil's shackles\nfrom your soul, and become ever more\nhard and determined to destroy the\nhideous creatures whose mere existence\nthreatens the souls and psyches of all\nthe population of Earth.");
			// return;
		// }
		// else if (world.model == "maps/e4m7.bsp")
		// {
			// WriteByte (MSG_ALL, SVC_CDTRACK);
			// WriteByte (MSG_ALL, 2);
			// WriteByte (MSG_ALL, 3);

			// WriteByte (MSG_ALL, SVC_FINALE);
			// WriteString (MSG_ALL, "Despite the awful might of the Elder\nWorld, you have achieved the Rune of\nElder Magic, capstone of all types of\narcane wisdom. Beyond good and evil,\nbeyond life and death, the Rune\npulsates, heavy with import. Patient and\npotent, the Elder Being Shub-Niggurath\nweaves her dire plans to clear off all\nlife from the Earth, and bring her own\nfoul offspring to our world! For all the\ndwellers in these nightmare dimensions\nare her descendants! Once all Runes of\nmagic power are united, the energy\nbehind them will blast open the Gateway\nto Shub-Niggurath, and you can travel\nthere to foil the Hell-Mother's plots\nin person.");
			// return;
		// }

		GotoNextMap();
	}
	
	if (intermission_running == 3)
	{
		if (!cvar("registered"))
		{	// shareware episode has been completed, go to sell screen
			WriteByte (MSG_ALL, SVC_SELLSCREEN);
			return;
		}
		
		if ( (serverflags&15) == 15)
		{
			WriteByte (MSG_ALL, SVC_FINALE);
			WriteString (MSG_ALL, "Now, you have all four Runes. You sense\ntremendous invisible forces moving to\nunseal ancient barriers. Shub-Niggurath\nhad hoped to use the Runes Herself to\nclear off the Earth, but now instead,\nyou will use them to enter her home and\nconfront her as an avatar of avenging\nEarth-life. If you defeat her, you will\nbe remembered forever as the savior of\nthe planet. If she conquers, it will be\nas if you had never been born.");
			return;
		}
		
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
	if (time < intermission_exittime) return;
	if (!self.button0 && !self.button1 && !self.button2) return;
	
	ExitIntermission ();
};

void() execute_changelevel =
{
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

	if ( (self.spawnflags & 1) && (deathmatch == 0) )
	{	// NO_INTERMISSION
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
// called by ClientKill and DeadThink
void() respawn =
{
	if (coop)
	{
		CopyToBodyQue (self);	// make a copy of the dead body for appearances sake
		setspawnparms (self);	// get the spawn parms as they were at level start
		//PutClientInServer ();	// respawn	
		PutObserverInServer();
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
			if (deathmatch == MODE_KZ) SetNewParmsKZ();
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
	
// testinfo_player_start is only found in regioned levels
	spot = find (world, classname, "testplayerstart");
	if (spot)
		return spot;
		
// choose a info_player_deathmatch point
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

	if (serverflags)
	{	// return with a rune to start
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

void() PutClientInServer =
{
	cvar_set ("r_ambient", "1");
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

	DecodeLevelParms ();
	W_SetCurrentAmmo ();

	self.attack_finished = time;
	self.th_pain = player_pain;
	self.th_die = PlayerDie;
	self.deadflag = DEAD_NO;
// paustime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	
//	spot = SelectSpawnPoint ();

//	self.origin = spot.origin + '0 0 1';
	self.origin = self.oldorigin = spot.origin + '0 0 1';	// 1998-07-21 Respawning where player died fix by Robert Field
	self.angles = spot.angles;
	self.fixangle = TRUE;		// turn this way immediately

// oh, this is a hack!
	// setmodel (self, "progs/eyes.mdl");
	// modelindex_eyes = self.modelindex;
	// if(deathmatch)
	// {
		// if(self.team == TEAM_USA) setmodel (self, "models/usa_m4.md3");
		// else setmodel (self, "models/ussr_ak74.md3");
	// }
	// else setmodel (self, "models/ussr_ak74.md3");

	if(self.weapon == WP_PM) 
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_glock.md3");
		else setmodel (self, "models/ussr_aps.md3");
		modelindex_ussr_aps = self.modelindex;
		player_ApsSwitch();
	}
	else if(self.weapon == WP_ONE) 
	{
		if (deathmatch == MODE_HNS) setmodel (self, "models/runner_blue.md3");
		else
		{
			if(self.team == TEAM_USA) setmodel (self, "models/usa_knife.md3");
			else setmodel (self, "models/ussr_knife.md3");
			modelindex_ussr_knife = self.modelindex;
			player_KnifeSwitch();
		}
	}
	else if(self.weapon == WP_TOZ)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_xm.md3");
		else setmodel (self, "models/ussr_toz.md3");
		modelindex_ussr_toz = self.modelindex;
		player_TozSwitch();
	}
	else if(self.weapon == WP_AKM)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_m4.md3");
		else setmodel (self, "models/ussr_ak74.md3");
		modelindex_ussr_ak74 = self.modelindex;
		player_AK74Switch();
	}
	else if(self.weapon == WP_MOSIN)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_awp.md3");
		else setmodel (self, "models/ussr_mosin.md3");
		modelindex_ussr_mosin = self.modelindex;
	}
	else if(self.weapon == WP_GRENADE) player_HESwitch();
	else setmodel (self, "models/runner_red.md3");
	
	// if(strstrofs(world.model,"hns_",0) != -1)
	// {
		// if(self.team == TEAM_USA) setmodel (self, "models/runner_blue.md3");
		// else setmodel (self, "models/runner_red.md3");
	// }
	modelindex_ussr_aps = self.modelindex;

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	self.view_ofs = '0 0 22';
	
	self.velocity = '0 0 0';	// 1998-07-21 Player moves after respawn fix by Xian

	player_stand1 ();
	
	if (deathmatch || coop)
	{
		makevectors(self.angles);
		spawn_tfog (self.origin + v_forward*20);
	}
	spawn_tdeath (self.origin, self);
	
	DrawLaser();
};







/*
=============================================================================

				QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() info_player_start =
{
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
		r = rint(random() * 7);
		if(r == 1) nextmap = "hns_multiply";
		else if(r == 2) nextmap = "fy_snow";
		else if(r == 3) nextmap = "e1m4";
		else if(r == 4) nextmap = "e1m5";
		else if(r == 5) nextmap = "e1m6";
		else if(r == 6) nextmap = "terrain";
		else if(r == 7) nextmap = "de_train";
		else nextmap = "dusty";
		
		if(mapname == nextmap)
		{
			r = rint(random() * 7);
			if(r == 1) nextmap = "hns_multiply";
			else if(r == 2) nextmap = "fy_snow";
			else if(r == 3) nextmap = "e1m4";
			else if(r == 4) nextmap = "e1m5";
			else if(r == 5) nextmap = "e1m6";
			else if(r == 6) nextmap = "terrain";
			else if(r == 7) nextmap = "de_train";
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
					if (!nearest) 
					{
						nearest = e;
					} 
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
	}

	if ((self.flags & FL_ONGROUND))
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
	if (!self.button2 && !self.button1 && !self.button0) return;

	self.button0 = 0;
	self.button1 = 0;
	self.button2 = 0;
	respawn();
};


void() PlayerJump =
{	
	if (self.flags & FL_WATERJUMP) return;
	if((!deathmatch && (strstrofs(world.model,"kz_",0) == -1)) && (self.lasttouch +0.85 > time)) return;
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
	self.lasttouch = time;
	local float rand;
	rand = random();
	if(rand >0.5) sound (self, CHAN_BODY, "player/jump1.wav", 1, ATTN_NORM);
	else sound (self, CHAN_BODY, "player/jump2.wav", 1, ATTN_NORM);
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
	if (other.message)
	{
		centerprint(self.owner, other.message);
		sound (other, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM);
	}
}

void() UseSmth =
{
	local	entity missile;
	if(self.buttonuse && self.classname == "player")
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
		//setmodel (missile, "models/w_grenade.md3");
		setsize (missile, '0 0 0', '1 1 1');
		setorigin (missile, self.origin + (v_up * 20));
	}
}

void() PlayerPreThink =
{
	local float crosshaircvar;
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
	if (self.view_ofs == '0 0 0') return;		// intermission or finale

	if(deathmatch)
	{
		if (self.impulse == 20) 
		{
			self.team = TEAM_USSR;
			self.class = CLASS_SHTORMTROOPER;
			SetNewParmsStormtrooper();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 21)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_BREACHER;
			SetNewParmsBreacher();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 22)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_MARKSMAN;
			SetNewParmsMarksman();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if(self.impulse == 23)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_ENGINEER;
			SetNewParmsEngineer();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if(self.impulse == 24)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_ASSASSIN;
			SetNewParmsAssassin();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 25) 
		{
			self.team = TEAM_USA;
			self.class = CLASS_SHTORMTROOPER;
			SetNewParmsStormtrooper();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if (self.impulse == 26)
		{
			self.team = TEAM_USA;
			self.class = CLASS_BREACHER;
			SetNewParmsBreacher();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if (self.impulse == 27)
		{
			self.team = TEAM_USA;
			self.class = CLASS_MARKSMAN;
			SetNewParmsMarksman();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if(self.impulse == 28)
		{
			self.team = TEAM_USA;
			self.class = CLASS_ENGINEER;
			SetNewParmsEngineer();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if(self.impulse == 29)
		{
			self.team = TEAM_USA;
			self.class = CLASS_ASSASSIN;
			SetNewParmsAssassin();
			SelectTeamUSA();
			self.impulse = 0;
		}
	}

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

	if (self.button2) PlayerJump ();
	else self.flags = self.flags | FL_JUMPRELEASED;
	// if(self.weapon == WP_AKM) stuffcmd (self, "cl_forwardspeed 185;cl_backspeed 185;cl_sidespeed 185;\n");
	// else if(self.weapon == WP_TOZ) stuffcmd (self, "cl_forwardspeed 175;cl_backspeed 175;cl_sidespeed 175;\n");
	// else stuffcmd (self, "cl_forwardspeed 200;cl_backspeed 200;cl_sidespeed 200;\n");

	
	crosshaircvar = cvar("crosshair");
	if(crosshaircvar > 0 && crosshaircvar <= 5 )
	{
		if(self.weapon == WP_MOSIN) stuffcmd (self, "crosshair 5\n");
		else
		{
			if(fabs(self.punchangle_x) > 1) stuffcmd (self, "crosshair 4\n");
			else if(fabs(self.punchangle_x) > 0.666) stuffcmd (self, "crosshair 3\n");
			else if(fabs(self.punchangle_x) > 0.333) stuffcmd (self, "crosshair 2\n");
			else stuffcmd (self, "crosshair 1\n");
		}
	}
	else if(crosshaircvar > 5  )
	{
		if(self.weapon == WP_MOSIN) stuffcmd (self, "crosshair 5\n");
		else
		{
			if(fabs(self.punchangle_x) > 1) stuffcmd (self, "crosshair 9\n");
			else if(fabs(self.punchangle_x) > 0.666) stuffcmd (self, "crosshair 8\n");
			else if(fabs(self.punchangle_x) > 0.333) stuffcmd (self, "crosshair 7\n");
			else stuffcmd (self, "crosshair 6\n");
		}
	}

	if(self.buttonuse && self.class == CLASS_ASSASSIN && deathmatch < 3)
	{
		if(!self.hooking) FireHook ();
	}
	else BreakHook();
	UseSmth();
	
	if(self.button3)
	{
		self.duck = 1;
		setsize (self, '-15 -15 -24', '15 15 20');
		//setsize (self, '0 0 0', '10 10 10');
		self.view_ofs = '0 0 10';
	}
	else
	{
		self.duck = 0;
		setsize (self, '-16 -16 -24', '16 16 35');
		self.view_ofs = '0 0 22';
	}
	
	if (time < self.pausetime) self.velocity = '0 0 0'; // teleporters can force a non-moving pause time	
	if(time > self.attack_finished && self.currentammo == 0 && self.weapon != IT_KNIFE)
	{
		//if(self.weapon == WP_GRENADE && self.attack_finished == 0) CycleWeaponReverseCommand();
		if(self.weapon == WP_AKM && self.AKMclip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_TOZ && self.mossclip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_PM && self.PMclip < 1) CycleWeaponReverseCommand();
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
			sound (self, CHAN_VOICE, "player/land2.wav", 1, ATTN_NORM);
			self.deathtype = "falling";
		}
		else sound (self, CHAN_VOICE, "player/land.wav", 1, ATTN_NORM);

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
	
	self.team = NO_TEAM;//Koolio, you're teamless on connecting


// a client connecting during an intermission can cause problems
	if (intermission_running)
		ExitIntermission ();
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	if (gameover)
		return;
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
				bprint (" was killed by a bot\n");
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
}; 