void() W_SetCurrentAmmo;
/* ALL LIGHTS SHOULD BE 0 1 0 IN COLOR ALL OTHER ITEMS SHOULD
BE .8 .3 .4 IN COLOR */


void() SUB_regen =
{
	self.model = self.mdl;		// restore original model
	self.solid = SOLID_TRIGGER;	// allow it to be touched again
	sound (self, CHAN_VOICE, "misc/item_respawn.wav", 1, ATTN_NORM);	// play respawn sound
	setorigin (self, self.origin);
};



/*QUAKED noclass (0 0 0) (-8 -8 -8) (8 8 8)
prints a warning message when spawned
*/
void() noclass =
{
	dprint ("noclass spawned at");
	dprint (vtos(self.origin));
	dprint ("\n");
	remove (self);
};



/*
============
PlaceItem

plants the object on the floor
============
*/
void() PlaceItem =
{
	local float	oldz;

	self.mdl = self.model;		// so it can be restored on respawn
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;	
	self.velocity = '0 0 0';
	oldz = self.origin_z;
	// if (!droptofloor())
	// {
		// dprint ("Bonus item fell out of level at ");
		// dprint (vtos(self.origin));
		// dprint ("\n");
		// remove(self);
		// return;
	// }
};

/*
============
StartItem

Sets the clipping size and plants the object on the floor
============
*/
void() StartItem =
{
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = PlaceItem;
};

/*
=========================================================================

HEALTH BOX

=========================================================================
*/
//
// T_Heal: add health to an entity, limiting health to max_health
// "ignore" will ignore max_health limit
//
float (entity e, float healamount, float ignore) T_Heal =
{
	if (e.health <= 0)
		return 0;
	if ((!ignore) && (e.health >= other.max_health))
		return 0;
	healamount = ceil(healamount);

	e.health = e.health + healamount;
	if ((!ignore) && (e.health >= other.max_health))
		e.health = other.max_health;
		
		if (e.health > 250)
		e.health = 250;
	return 1;
};

/*QUAKED item_health (.3 .3 1) (0 0 0) (32 32 32) rotten megahealth
Health box. Normally gives 25 points.
Rotten box heals 5-10 points,
megahealth will add 100 health, then 
rot you down to your maximum health limit, 
one point per second.
*/

void() health_touch;
void() item_health =
{	
	self.touch = health_touch;	
	precache_model2("models/items/medkit.bsp");
	setmodel(self, "models/items/medkit.bsp");
	precache_sound("player/heal.wav");
	self.noise = "player/heal.wav";
	
	setsize (self, '-18 -18 0', '18 18 56');
	StartItem ();
};


void() health_touch =
{
	if (other.classname != "player") return;
	if (!T_Heal(other, 25, 0)) return;
	
	sprint(other, "You receive 25 health\n");
	
// health touch sound
	sound(other, CHAN_ITEM, self.noise, 1, ATTN_NORM);

	stuffcmd (other, "bf\n");
	
	self.model = string_null;
	self.solid = SOLID_NOT;

	if (deathmatch != 2)
	{
		if (deathmatch) self.nextthink = time + 20;
		self.think = SUB_regen;
	}
	
	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};	

void() item_megahealth_rot =
{
	other = self.owner;
	
	if (other.health > other.max_health)
	{
		other.health = other.health - 1;
		self.nextthink = time + 1;
		return;
	}

// it is possible for a player to die and respawn between rots, so don't
// just blindly subtract the flag off
	other.items = other.items - (other.items & IT_SUPERHEALTH);
	
	if (deathmatch == 1)	// deathmatch 2 is silly old rules
	{
		self.nextthink = time + 20;
		self.think = SUB_regen;
	}
};


void() prop_brush =
{
	precache_model(self.weaponmodel);
	setmodel (self, self.weaponmodel);
};

/*
===============================================================================

WEAPONS

===============================================================================
*/

void() bound_other_ammo =
{
	if (other.ammoPistol > 100) other.ammoPistol = 100;
	if (other.ammoShells > 100) other.ammoShells = 100;
	if (other.ammoRifle > 200) other.ammoRifle = 200;
	if (other.ammoGrenades > 100) other.ammoGrenades = 100;		
	if (other.ammoSniper > 100) other.ammoSniper = 100;		
};


float(float w) RankForWeapon =
{
	if (w == IT_HAMMER) return 2;
	if (w == IT_GRENADE) return 3;
	if (w == IT_MOSIN) return 4;
	if (w == IT_TOZ) return 5;
	if (w == IT_AKM) return 6;
	return 7;
};

/*
=============
Deathmatch_Weapon

Deathmatch weapon change rules for picking up a weapon

.float		ammoShells, ammoRifle, ammoGrenades, ammoSniper;
=============
*/
void(float old, float new) Deathmatch_Weapon =
{
	local float or, nr;

// change self.weapon if desired
	or = RankForWeapon (self.weapon);
	nr = RankForWeapon (new);
	if (nr < or) self.weapon = new;
};

/*
=============
weapon_touch
=============
*/
float() W_BestWeapon;

void() weapon_touch =
{
	local	float	hadammo, new, old;
	local	entity	stemp;
	local	float	leave;
	if (self.classname == "weapon_bomb" && other.team != TEAM_USSR && world.model != "maps/e1m8.bsp") return;
	if(other.classname == "useprefab") other = other.owner;
	if (!(other.flags & FL_CLIENT)) return;

// if the player was using his best weapon, change up to the new one if better		
	stemp = self;
	self = other;
	self = stemp;

	if (coop) leave = 1;
	else leave = 0;
	
	if (self.classname == "weapon_rifle")
	{
		if (leave && (other.items & IT_AKM) ) return;
		hadammo = other.ammoRifle;			
		new = IT_AKM;
		other.ammoRifle = other.ammoRifle + 30;
	}
	else if (self.classname == "weapon_grenade")
	{
		leave = 0;
		hadammo = other.ammoGrenades;			
		new = IT_GRENADE;
		other.ammoGrenades = other.ammoGrenades + 1;
	}
	else if (self.classname == "weapon_shotgun")
	{
		if (leave && (other.items & IT_TOZ)) return;
		hadammo = other.ammoGrenades;			
		new = IT_TOZ;
		other.ammoShells = other.ammoShells + 5;
	}
	else if (self.classname == "weapon_sniper")
	{
		if (leave && (other.items & IT_MOSIN) ) return;
		hadammo = other.ammoSniper;			
		new = IT_MOSIN;
		other.ammoSniper = other.ammoSniper + 10;
	}
	else if (self.classname == "weapon_bomb")
	{
		if (leave && (other.items & IT_BOMB)) return;
		//hadammo = other.ammoGrenades;			
		new = IT_BOMB;
		//other.ammoSniper = other.ammoSniper + 15;
	}
	else
		objerror ("weapon_touch: unknown classname");

	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, "\n");
	sound (other, CHAN_ITEM, "player/pickup.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

	bound_other_ammo ();

// change to the weapon
	old = other.items;
	other.items = other.items | new;
	other.weapons = other.weapons | new;

	stemp = self;
	self = other;
	
	if(!self.reload)
	{
		if(!self.hgrenade)
		{
			//if (!deathmatch) self.weapon = new;
			//else Deathmatch_Weapon (old, new);
			if(new == WP_RIFLE) self.impulse =4;
			else if(new == WP_SHOTGUN) self.impulse = 3;
			else if(new == WP_SNIPER) self.impulse = 5;
			W_SetCurrentAmmo();
		}
		else
		{
			self.currentammo = self.ammoGrenades;
		}
	}

	self = stemp;

	if (leave) return;

// remove it in single player, or setup for respawning in deathmatch
	self.model = string_null;
	self.solid = SOLID_NOT;
	if (deathmatch == 1) self.nextthink = time + 30;
	else if (deathmatch == 2) self.nextthink = time + 180;
	self.think = SUB_regen;
	
	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};


/*QUAKED weapon_supershotgun (0 .5 .8) (-16 -16 0) (16 16 32)
*/

void() weapon_shotgun =
{
	precache_model ("models/w_shot.md3");
	setmodel (self, "models/w_shot.md3");
	self.weapon = IT_TOZ;
	self.netname = "shotgun";
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};

void() weapon_bomb =
{
	if(deathmatch != MODE_DE && world.model != "maps/e1m8.bsp") return;
	precache_model ("models/w_bomb.md3");
	setmodel (self, "models/w_bomb.md3");
	self.weapon = IT_BOMB;
	self.netname = "explosive charge";
	self.light_lev = 1000;
	self.color_x = 0;
  	self.color_y = 1;
   	self.color_z = 0;
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};

/*QUAKED weapon_rifle (0 .5 .8) (-16 -16 0) (16 16 32)
*/

void() weapon_rifle =
{
	precache_model ("models/w_ak.md3");
	setmodel (self, "models/w_ak.md3");
	self.weapon = IT_AKM;
	self.netname = "AK-74";
	self.touch = weapon_touch;
	setsize (self, '-8 -8 0', '8 8 56');
	StartItem ();
};

/*QUAKED weapon_supernailgun (0 .5 .8) (-16 -16 0) (16 16 32)
*/

void() weapon_grenade =
{
	precache_model ("models/w_grenade.md3");
	setmodel (self, "models/w_grenade.md3");
	self.weapon = IT_GRENADE;
	self.netname = "Grenade";
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};


/*QUAKED weapon_rocketlauncher (0 .5 .8) (-16 -16 0) (16 16 32)
*/

void() weapon_sniper =
{
	precache_model ("models/w_svd.md3");
	setmodel (self, "models/w_svd.md3");
	self.weapon = 3;
	self.netname = "SVD";
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};


/*QUAKED weapon_lightning (0 .5 .8) (-16 -16 0) (16 16 32)
*/

void() weapon_lightning =
{
	precache_model ("progs/g_light.mdl");
	setmodel (self, "progs/g_light.mdl");
	self.weapon = 3;
	self.netname = "Thunderbolt";
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	StartItem ();
};


/*
===============================================================================

AMMO

===============================================================================
*/

void() ammo_touch =
{
	local entity	stemp;
	local float		best;

	if(other.classname == "useprefab") other = other.owner;
	if (other.classname != "player" ) return;
	if (other.health <= 0) return;

// if the player was using his best weapon, change up to the new one if better		
	stemp = self;
	self = other;
	best = W_BestWeapon();
	self = stemp;

	
	if (self.weapon == 1) // Makarov
	{
		if (other.ammoPistol >= 100) return;
		other.ammoPistol = other.ammoPistol + self.aflag;
	}
	if (self.weapon == 2) // TOZ
	{
		if (other.ammoShells >= 100) return;
		other.ammoShells = other.ammoShells + self.aflag;
	}
	if (self.weapon == 3) // Ak
	{
		if (other.ammoRifle >= 200) return;
		other.ammoRifle = other.ammoRifle + self.aflag;
	}
	if (self.weapon == 4) //	Mosin
	{
		if (other.ammoSniper >= 100) return;
		other.ammoSniper = other.ammoSniper + self.aflag;
	}

	bound_other_ammo ();
	
	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, " ammo\n");
	
// ammo touch sound
	sound (other, CHAN_ITEM, "player/pickup.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

// change to a better weapon if appropriate
	//if (self.hgrenade) return;

	if(!other.reload && !other.hgrenade)
	{
	// if changed current ammo, update it
		stemp = self;
		self = other;
		W_SetCurrentAmmo();
		self = stemp;
	}

// remove it in single player, or setup for respawning in deathmatch
	self.model = string_null;
	self.solid = SOLID_NOT;
	if (deathmatch == 1) self.nextthink = time + 30;
	self.think = SUB_regen;

	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};




float WEAPON_BIG2 = 1;
void() item_9x18 =
{
	self.touch = ammo_touch;

	precache_model2("models/w_pmammo.md3");
	setmodel (self,"models/w_pmammo.md3");
	self.aflag = 20;
	
	self.weapon = 1;
	self.netname = "9x18";
	setsize (self, '0 0 0', '16 16 16');
	StartItem ();
};

/*QUAKED item_shells (0 .5 .8) (0 0 0) (32 32 32) big
*/
void() item_shells =
{
	self.touch = ammo_touch;

	precache_model ("models/w_shotgunammo.bsp");
	setmodel (self, "models/w_shotgunammo.bsp");
	self.aflag = 20;
	
	self.weapon = 2;
	self.netname = "shells";
	setsize (self, '-18 -18 0', '18 18 56');
	StartItem ();
};

/*QUAKED item_spikes (0 .5 .8) (0 0 0) (32 32 32) big
*/

void() item_545x39 =
{
	self.touch = ammo_touch;

	precache_model("models/w_akammo.md3");
	setmodel(self, "models/w_akammo.md3");
	self.aflag = 30;
	
	self.weapon = 3;
	self.netname = "5.45x39";
	setsize (self, '-18 -18 0', '18 18 56');
	StartItem ();
};

/*QUAKED item_rockets (0 .5 .8) (0 0 0) (32 32 32) big
*/

// void() item_rockets =
// {
	// self.touch = ammo_touch;

	// if (self.spawnflags & WEAPON_BIG2)
	// {
		// precache_model ("maps/b_rock1.bsp");
		// setmodel (self, "maps/b_rock1.bsp");
		// self.aflag = 10;
	// }
	// else
	// {
		// precache_model ("maps/b_rock0.bsp");
		// setmodel (self, "maps/b_rock0.bsp");
		// self.aflag = 5;
	// }
	// self.weapon = 3;
	// self.netname = "rockets";
	// setsize (self, '-18 -18 0', '18 18 56');
	// StartItem ();
// };


/*QUAKED item_cells (0 .5 .8) (0 0 0) (32 32 32) big
*/

void() item_762x54 =
{
	self.touch = ammo_touch;
	precache_model ("models/w_svdammo.md3");
	setmodel (self, "models/w_svdammo.md3");
	self.aflag = 10;
	self.weapon = 4;
	self.netname = "7.62x54";
	setsize (self, '-18 -18 0', '18 18 56');
	StartItem ();
};


/*QUAKED item_weapon (0 .5 .8) (0 0 0) (32 32 32) shotgun rocket spikes big
DO NOT USE THIS!!!! IT WILL BE REMOVED!
*/

float WEAPON_SHOTGUN = 1;
float WEAPON_ROCKET = 2;
float WEAPON_SPIKES = 4;
float WEAPON_BIG = 8;
void() item_weapon =
{
	self.touch = ammo_touch;

	if (self.spawnflags & WEAPON_SHOTGUN)
	{
		if (self.spawnflags & WEAPON_BIG)
		{
			precache_model ("maps/b_shell1.bsp");
			setmodel (self, "maps/b_shell1.bsp");
			self.aflag = 40;
		}
		else
		{
			precache_model ("maps/b_shell0.bsp");
			setmodel (self, "maps/b_shell0.bsp");
			self.aflag = 20;
		}
		self.weapon = 1;
		self.netname = "shells";
	}

	if (self.spawnflags & WEAPON_SPIKES)
	{
		if (self.spawnflags & WEAPON_BIG)
		{
			precache_model ("maps/b_nail1.bsp");
			setmodel (self, "maps/b_nail1.bsp");
			self.aflag = 40;
		}
		else
		{
			precache_model ("maps/b_nail0.bsp");
			setmodel (self, "maps/b_nail0.bsp");
			self.aflag = 20;
		}
		self.weapon = 2;
		self.netname = "spikes";
	}

	if (self.spawnflags & WEAPON_ROCKET)
	{
		if (self.spawnflags & WEAPON_BIG)
		{
			precache_model ("maps/b_rock1.bsp");
			setmodel (self, "maps/b_rock1.bsp");
			self.aflag = 10;
		}
		else
		{
			precache_model ("maps/b_rock0.bsp");
			setmodel (self, "maps/b_rock0.bsp");
			self.aflag = 5;
		}
		self.weapon = 3;
		self.netname = "rockets";
	}
	
	setsize (self, '-16 -16 -28', '16 16 28');
	StartItem ();
};


/*
===============================================================================

KEYS

===============================================================================
*/

void() key_touch =
{
	if(other.classname == "useprefab") other = other.owner;
	if (other.classname != "player") return;
	if (other.health <= 0) return;
	if (other.items & self.items) return;

	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other,"\n");

	sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
	stuffcmd (other, "bf\n");
	other.items = other.items | self.items;

	if (!coop)
	{	
		self.solid = SOLID_NOT;
		self.model = string_null;
		self.light_lev = 0;
	}

	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};


/*QUAKED item_key1 (0 .5 .8) (-16 -16 -24) (16 16 32)
SILVER key
In order for keys to work
you MUST set your maps
worldtype to one of the
following:
0: medieval
1: metal
2: base
*/

void() item_key1 =
{
	precache_model ("models/items/keycard.bsp");
	setmodel (self, "models/items/keycard.bsp");
	self.netname = "blue keycard";

	precache_sound ("misc/key.wav");
	self.noise = "misc/key.wav";
	
	self.touch = key_touch;
	self.items = IT_KEY1;
	self.pflags = PFLAGS_FULLDYNAMIC|PFLAGS_NOSHADOW;

	self.light_lev = 100;
	self.color_x = 0;
  	self.color_y = 0;
   	self.color_z = 1;
	setsize (self, '-16 -16 -24', '16 16 32');
	StartItem ();
};

/*QUAKED item_key2 (0 .5 .8) (-16 -16 -24) (16 16 32)
GOLD key
In order for keys to work
you MUST set your maps
worldtype to one of the
following:
0: medieval
1: metal
2: base
*/

void() item_key2 =
{
	if (world.worldtype == 0)
	{
		precache_model ("progs/w_g_key.mdl");
		setmodel (self, "progs/w_g_key.mdl");
		self.netname = "gold key";
	}
	if (world.worldtype == 1)
	{
		precache_model ("progs/m_g_key.mdl");
		setmodel (self, "progs/m_g_key.mdl");
		self.netname = "gold runekey";
	}
	if (world.worldtype == 2)
	{
		precache_model2 ("progs/b_g_key.mdl");
		setmodel (self, "progs/b_g_key.mdl");
		self.netname = "gold keycard";
	}
	self.touch = key_touch;
	self.items = IT_KEY2;
	setsize (self, '-16 -16 -24', '16 16 32');
	StartItem ();
};



/*
===============================================================================

END OF LEVEL RUNES

===============================================================================
*/

void() sigil_touch =
{
	if (other.classname != "player") return;
	if (other.health <= 0) return;

	centerprint (other, "You got the rune!");

	sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
	stuffcmd (other, "bf\n");
	self.solid = SOLID_NOT;
	self.model = string_null;
	serverflags = serverflags | (self.spawnflags & 15);
	self.classname = "";		// so rune doors won't find it
	
	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};


/*QUAKED item_sigil (0 .5 .8) (-16 -16 -24) (16 16 32) E1 E2 E3 E4
End of level sigil, pick up to end episode and return to jrstart.
*/

void() item_sigil =
{
	if (!self.spawnflags)
		objerror ("no spawnflags");

	precache_sound ("misc/runekey.wav");
	self.noise = "misc/runekey.wav";

	if (self.spawnflags & 1)
	{
		precache_model ("progs/end1.mdl");
		setmodel (self, "progs/end1.mdl");
	}
	if (self.spawnflags & 2)
	{
		precache_model2 ("progs/end2.mdl");
		setmodel (self, "progs/end2.mdl");
	}
	if (self.spawnflags & 4)
	{
		precache_model2 ("progs/end3.mdl");
		setmodel (self, "progs/end3.mdl");
	}
	if (self.spawnflags & 8)
	{
		precache_model2 ("progs/end4.mdl");
		setmodel (self, "progs/end4.mdl");
	}
	
	self.touch = sigil_touch;
	setsize (self, '-16 -16 -24', '16 16 32');
	StartItem ();
};


/*
===============================================================================

PLAYER BACKPACKS

===============================================================================
*/

void() BackpackTouch =
{
	local string	s;
	local	float	best, old, new;
	local		entity	stemp;
	local	float	acount;
	
	if (other.classname == "useprefab") other = other.owner;
	if (other.classname != "player") return;
	if (other.health <= 0) return;
	if(deathmatch && self.items & IT_BOMB && other.team != TEAM_USSR) return;

	acount = 0;
	sprint (other, "You get ");

	if (self.items)
		if ((other.items & self.items) == 0)
		{
			acount = 1;
			sprint (other, "the ");
			sprint (other, self.netname);
		}

// if the player was using his best weapon, change up to the new one if better		
	stemp = self;
	self = other;
	best = W_BestWeapon();
	self = stemp;

// change weapons
	other.ammoPistol = other.ammoPistol + self.ammoPistol;
	other.ammoShells = other.ammoShells + self.ammoShells;
	other.ammoRifle = other.ammoRifle + self.ammoRifle;
	other.ammoGrenades = other.ammoGrenades + self.ammoGrenades;
	other.ammoSniper = other.ammoSniper + self.ammoSniper;

	new = self.items;
	if (!new)
		new = other.weapon;
	old = other.items;
	other.items = other.items | new;
	
	bound_other_ammo ();

	if (self.ammoPistol)
	{
		if (acount) sprint(other, ", ");
		acount = 1;
		s = ftos(self.ammoPistol);
		sprint (other, s);
		sprint (other, " 9x18 ammo");
	}
	if (self.ammoShells)
	{
		if (acount)
			sprint(other, ", ");
		acount = 1;
		s = ftos(self.ammoShells);
		sprint (other, s);
		sprint (other, " shells");
	}
	if (self.ammoRifle)
	{
		if (acount) sprint(other, ", ");
		acount = 1;
		s = ftos(self.ammoRifle);
		sprint (other, s);
		sprint (other, " AK-74 ammo");
	}
	if (self.ammoGrenades)
	{
		if (acount)
			sprint(other, ", ");
		acount = 1;
		s = ftos(self.ammoGrenades);
		sprint (other, s);
		sprint (other, " rockets");
	}
	if (self.ammoSniper)
	{
		if (acount) sprint(other, ", ");
		acount = 1;
		s = ftos(self.ammoSniper);
		sprint (other, s);
		sprint (other, " sniper ammo");
	}
	
	sprint (other, "\n");
// backpack touch sound
	sound (other, CHAN_ITEM, "player/pickup.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

// remove the backpack, change self to the player
	remove(self);
	self = other;

// change to the weapon
	if(!other.reload && !other.hgrenade)
	{
		//	if (!deathmatch) self.weapon = new;
		//else Deathmatch_Weapon (old, new);
		W_SetCurrentAmmo ();
	}
};

void() DropClip19x18 =
{
	local entity item;

	if (self.ammoPistol < 1) return;

	item = spawn();
	item.origin = self.origin - '0 0 24';
	
	item.ammoPistol = self.ammoPistol;

	item.velocity_z = 300;
	item.velocity_x = -100 + (random() * 200);
	item.velocity_y = -100 + (random() * 200);
	
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	setmodel (item, "models/w_pmammo.md3");
	setsize (item, '-16 -16 0', '16 16 56');
	item.touch = BackpackTouch;
	
	item.nextthink = time + 120;	// remove after 2 minutes
	item.think = SUB_Remove;
};

void() DropShells =
{
	local entity item;

	if (self.ammoShells < 1) return;

	item = spawn();
	item.origin = self.origin - '0 0 24';
	
	item.ammoShells = self.ammoShells;

	item.velocity_z = 300;
	item.velocity_x = -100 + (random() * 200);
	item.velocity_y = -100 + (random() * 200);
	
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	setmodel (item, "models/w_shotgunammo.bsp");
	setsize (item, '-16 -16 0', '16 16 56');
	item.touch = BackpackTouch;
	
	item.nextthink = time + 120;	// remove after 2 minutes
	item.think = SUB_Remove;
};
