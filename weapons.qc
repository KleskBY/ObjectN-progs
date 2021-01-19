void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void() player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void(vector org, vector vel, float damage) SpawnBlood;
void() SpawnBot;
void() KickBot;
float() crandom =
{
	return 2*(random() - 0.5);
};

//============================================================================


vector() wall_velocity =
{
	local vector	vel;
	
	vel = normalize (self.velocity);
	vel = normalize(vel + v_up*(random()- 0.5) + v_right*(random()- 0.5));
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;
	
	return vel;
};

/*
	================
	SpawnBlood
	================
*/
void(vector org, vector vel, float damage) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
};

/*
	================
	spawn_touchblood
	================
*/
void(float damage) spawn_touchblood =
{
	local vector	vel;
	
	vel = wall_velocity () * 0.2;
	SpawnBlood (self.origin + vel*0.01, vel, damage);
};


/*
	================
	SpawnChunk
	================
*/
void(vector org, vector vel) SpawnChunk =
{
	particle (org, vel*0.02, 0, 10);
};

/*
	==============================================================================
	
	MULTI-DAMAGE
	
	Collects multiple small damages into a single damage
	
	==============================================================================
*/

entity	multi_ent;
float	multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
};

void() ApplyMultiDamage =
{
	if (!multi_ent) return;
	T_Damage (multi_ent, self, self, multi_damage);
};

void(entity hit, float damage) AddMultiDamage =
{
	if (!hit) return;
	if (hit != multi_ent)
	{
		ApplyMultiDamage ();
		multi_damage = damage;
		multi_ent = hit;
	}
	else multi_damage = multi_damage + damage;
};

/*
	==============================================================================
	
	BULLETS
	
	==============================================================================
*/

/*
	================
	TraceAttack
	================
*/

void (vector position, vector direction, float type) shootGib = 
{
	if(!type) return;
	local entity blood;
	local float r;
	
	blood = spawn ();
	blood.owner = self;
	blood.movetype = MOVETYPE_BOUNCE;
	blood.solid = SOLID_NOT;
	makevectors (self.angles);
	blood.velocity = direction;
	blood.avelocity = '300 300 300';
	blood.angles = vectoangles(blood.velocity);
	blood.nextthink = time + random(2,4);
	blood.think = SUB_Remove;
	blood.touch = SUB_Remove;
	
	if(type == 1) 
	{
		blood.scale = random(0.6,1.6);
		r = rint(random() * 4);
		if(r == 1) setmodel (blood, "models/wood1.bsp");
		else if(r == 2) setmodel (blood, "models/wood2.bsp");
		else if(r == 3) setmodel (blood, "models/wood3.bsp");
		else if(r == 4) setmodel (blood, "models/wood4.bsp");
	}
	else if(type == 2) 
	{
		blood.alpha = 0.5;
		blood.scale = random(1,3);
		setmodel (blood,"models/gib.md3");
	}
	else 
	{
		blood.scale = random(0.6,1.6);
		r = rint(random() * 4);
		if(r == 1) setmodel (blood, "models/metal1.bsp");
		else if(r == 2) setmodel (blood, "models/metal2.bsp");
		else if(r == 3) setmodel (blood, "models/metal3.bsp");
		else if(r == 4) setmodel (blood, "models/metal4.bsp");
	}
	setsize (blood,VEC_ORIGIN,VEC_ORIGIN);
	setorigin (blood,position);
	//pointparticles(particleeffectnum("smoke"), position, direction, 1);
};
	

float (float damage) DetectHitbox =
{
	if (trace_ent.absmax_z - trace_endpos_z <= 13 && !trace_ent.duck) //headshot
	{
		//sound (trace_ent, CHAN_WEAPON, "weapons/hitsound.wav", 1, ATTN_NORM);
		damage = rint(damage * 1.7);
		trace_ent.headshot = 1;
	}
	else if(trace_ent.duck && trace_ent.absmax_z - trace_endpos_z <= 6)
	{
		damage = rint(damage * 1.7);
		trace_ent.headshot = 1;
	}
	else if (((trace_ent.absmax_z - trace_endpos_z) > 26) && ((trace_ent.absmax_z - trace_endpos_z) < 35))	//legshot
	{
		trace_ent.headshot = 0;
		damage = rint(damage * 0.7);
	}
	else trace_ent.headshot = -1;
	return damage;
}

float (float damage, vector org, vector dir) DetectObject =
{
	if(trace_ent.classname == "button")
	{
		AddMultiDamage (trace_ent,damage);
		return TRUE;
	}
	else if(trace_ent.classname == "breakable")
	{
		local vector meatdir;
		pointparticles(particleeffectnum("nailgun_muzzleflash"), org, '500 500 500', 1);
		WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST,TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST,org_x);
		WriteCoord (MSG_BROADCAST,org_y);
		WriteCoord (MSG_BROADCAST,org_z);
		
		if(self.weapon == WP_SHOTGUN) 
		{
			AddMultiDamage (trace_ent, damage);
			return TRUE;
		}

		meatdir_x = ((random () * 100) + dir_x);
		meatdir_y = ((random () * 100) + dir_y);
		meatdir_z = ((random () * 100) + dir_z);
		shootGib (org,meatdir,trace_ent.sounds);
		meatdir_x = ((random () * 100) + dir_x);
		meatdir_y = ((random () * 100) + dir_y);
		meatdir_z = ((random () * 100) + dir_z);
		shootGib (org,meatdir,trace_ent.sounds);
		meatdir_x = ((random () * 100) + dir_x);
		meatdir_y = ((random () * 100) + dir_y);
		meatdir_z = ((random () * 100) + dir_z);
		shootGib (org,meatdir,trace_ent.sounds);
		
		AddMultiDamage (trace_ent, damage);
		return TRUE;
	}
	return FALSE;
}


void (float damage, vector dir) TraceAttack = 
{
	local vector vel, org, meatdir;
	local float particle_color;

	vel = normalize (dir + v_up * crandom() + v_right * crandom());
	vel = vel + trace_plane_normal * 2;
	vel = vel * 200;
	org = trace_endpos - dir * 4;
	
	if(self.weapon == WP_ONE)
	{
		if (!trace_ent.takedamage || trace_ent.classname == "worldspawn")
		{
			sound(self, CHAN_WEAPON,"weapons/knife/miss.wav", 1, ATTN_NORM);
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST, org_x);
			WriteCoord (MSG_BROADCAST, org_y);
			WriteCoord (MSG_BROADCAST, org_z);
			return;
		}
	}
	
	if(trace_ent.takedamage) 
	{
		if(DetectObject(damage, org, dir)) return;
		damage = DetectHitbox(damage);
		
		if(self.weapon == WP_ONE)
		{
			trace_ent.axhitme = 1;
			sound(self, CHAN_WEAPON,"weapons/knife/hit.wav", 1, ATTN_NORM);
		}
		
		particle_color = random ();
		meatdir_x = ((random () * 300) );
		meatdir_y = ((random () * 300) );
		meatdir_z = ((random () * 300) );
		makevectors (self.v_angle);
		
		if (particle_color < 0.7 && damage >= 6) 
		{
			//SpawnBlood (org, meatdir, 10); 
			SpawnBlood (org, vel * 0.2, damage * 100); 
		}
		
		if (damage >= 20)
		{
			SpawnBlood (org + '10 10 0', v_forward * 200, 10); 
			SpawnBlood (org, v_forward * 200, 10); 
		}
		if (damage <= 20 && damage > 0)
		{
			if ( (trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) &&
			(trace_ent.duck != 1) && (trace_ent.classname != "misc_explobox") ) 
			{
				trace_ent.flags = trace_ent.flags - FL_ONGROUND;
				trace_ent.velocity = (v_forward * 140);
				trace_ent.velocity_z = 200 + (random() * 100);
			}
		}
		if (damage > 20)
		{
			if((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) && (trace_ent.duck != 1)) 
			{
				trace_ent.flags = trace_ent.flags - FL_ONGROUND;
				trace_ent.velocity = (v_forward * 200);
				trace_ent.velocity_z = 200 + (random() * 100);
			}
		}
		
		AddMultiDamage (trace_ent,damage);
	} 
	else 
	{
		WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST,TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST,org_x);
		WriteCoord (MSG_BROADCAST,org_y);
		WriteCoord (MSG_BROADCAST,org_z);
		particle_color = random();
	}
};

/*
	================
	FireBullet
	================
*/
void(vector spread, float dist, float dmg) fireBullet =
{
	local vector src, dir;
	local float len;
	
	makevectors(self.angles);
	dir = aim(self, 1000);
	makevectors(self.v_angle);
	
	src = self.origin + v_forward * 10;
	if(self.duck) src_z = self.absmin_z + self.size_z;
	else src_z = self.absmin_z + self.size_z * 0.8;
	
	ClearMultiDamage ();
	traceline (src, (src + v_forward * dist) - (v_right * crandom() * spread_x) - (v_up * crandom() * spread_y), FALSE, self);
	
	if (trace_fraction != 1.0)
	{
		len = vlen(trace_endpos - self.origin);
		if (len < 250) TraceAttack(dmg, dir);
		else if (len < 350 && len >= 250) TraceAttack (dmg * 0.9, dir);
		else TraceAttack (dmg * 0.8, dir);
	}
	
	//if (trace_fraction != 1.0) TraceAttack (4, direction);
	ApplyMultiDamage ();
};


// void() Muzzle_Think =
// {
// makevectors (self.owner.v_angle);
// self.velocity = aim(self.owner, 1000);
// self.angles = vectoangles(self.velocity);
// self.angles = self.angles + '0 -90 0';			
// setorigin (self, self.owner.origin + (v_forward * 30) - (v_right * -0.5) + (v_up * 19));

// self.nextthink = time;
// self.think = Muzzle_Think;
// };

// void (vector org) DrawMuzzle =
// {
// local entity muzzle;

// muzzle = spawn ();
// muzzle.owner = self;
// //muzzle.movetype = MOVETYPE_NOCLIP;
// //muzzle.solid = SOLID_NOT;
// //muzzle.effects = EF_BRIGHTLIGHT;
// setmodel (muzzle, "models/muzzle.md3");
// //setorigin( muzzle, org );
// muzzle.think = Muzzle_Think;
// muzzle.nextthink = time;
// };



/*
	===============================================================================
	
	PLAYER WEAPON USE 
	FX Weapon ammo
	===============================================================================
*/

void() W_SetCurrentAmmo =
{
	player_run ();		// get out of any weapon firing states
	self.items = self.items - ( self.items & (IT_SHELLS | IT_545x39 | IT_ROCKETS | IT_762x54 | IT_9x18));
    // Remove_Laser_Sights();  // remove any active laser sights
	
    if (self.weapon == WP_ONE)
	{
		self.currentammo = 0;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_knife_usa.md3";
		else self.weaponmodel = "models/v_knife.md3";
		self.weaponframe = 0;
	}
    else if (self.weapon == WP_PISTOL)
	{
		self.currentammo = self.ammoPistol;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_colt.md3";
		else self.weaponmodel = "models/v_pm.md3";
		self.weaponframe = 0;
		self.items = self.items | IT_9x18;
	}
	else if (self.weapon == WP_SHOTGUN)
	{
		self.currentammo = self.ammoShells;
        if(self.team == TEAM_USA) self.weaponmodel = "models/v_shot_usa.md3";
		else self.weaponmodel = "models/v_shot.md3";
		self.weaponframe = 0;
        self.items = self.items | IT_SHELLS;
	}
    else if (self.weapon == WP_RIFLE)
    {
		self.currentammo = self.ammoRifle;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_m4.md3";
		else self.weaponmodel = "models/v_ak.md3";
		self.weaponframe = 0;
        self.items = (self.items | IT_545x39);
	}
    else if (self.weapon == WP_GRENADE)
	{	   
		self.currentammo = self.ammoGrenades;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_grenade_usa.md3";
		else self.weaponmodel = "models/v_grenade.md3";
		self.items = self.items | IT_ROCKETS;
	}
    else if (self.weapon == WP_SNIPER)
	{
		self.currentammo = self.ammoSniper;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_sniper.md3";
		else self.weaponmodel = "models/v_svd.md3";
		self.weaponframe = 0;
        self.items = self.items | IT_762x54;
	}
	else if (self.weapon == WP_HAMMER)
	{	   
		self.currentammo = self.ammoBarricades;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_hammer_usa.md3";
		else self.weaponmodel = "models/v_hammer.md3";
		self.weaponframe = 0;
		self.items = self.items | IT_BARRICADES;
	}
	// else
	// {
	// self.currentammo = 0;
	// self.weaponmodel = "";
	// self.weaponframe = 0;
	// }
};

float() W_BestWeapon =
{
	local float	wp;
	wp = self.items;
	
	if ((self.sniperClip >= 1) && (wp & WP_SNIPER)) return WP_SNIPER; // Barrett
	if ((self.rifleClip >= 1) && (wp & WP_RIFLE)) return WP_RIFLE; // AKM
	if ((self.shotgunClip >= 1) && (wp & WP_SHOTGUN)) return WP_SHOTGUN; // mossberg
	if ((self.pistolClip >= 1) && (wp & WP_PISTOL)) return WP_PISTOL; // PM
	
	return WP_ONE;
};


/*
	============
	W_Attack
	
	An attack impulse can be triggered now
	============
*/

void()	playerPistolAttack;
void()  playerPistolReload;
void()  playerPistolSwitch;

void()  playerKnifeAttack; 
void()  playerKnifeAttackB; 
void()  playerKnifeSwitch;

void()  player_HEAttack;
void() 	player_HESwitch;

void()  playerShotgunAttack;
void()  playerShotgunReload;
void()  player_TozSwitch;

void()	playerRifleAttack;
void()  playerRifleReload;
void() 	playerRifleSwitch;

void()  playerSniperAttack;
void()  playerSniperReload;
void() 	playerSniperSwitch;

void() player_HammerAttack;
void() player_HammerSwitch;

void() W_Attack =
{
	local float	r;
	if (deathmatch && !self.team && !self.class) return;
	if (self.reload == 1) return;
    self.weaponfired = self.weapon;
	
	makevectors	(self.v_angle);		// calculate forward angle for velocity
	self.show_hostile = time + 1;	// wake monsters up
	
	r = random ();
    if (self.weapon == WP_ONE)
	{
		self.attack_finished = time + 0.5;
		if(r < 0.55) playerKnifeAttack();
		else playerKnifeAttackB();
	}
    else if (self.weapon == WP_GRENADE)
	{
		if (self.ammoGrenades > 0) 
		{
			self.grenadetime = 0;
			self.attack_finished = time + 9999; //ugly hack, but lets you hold the grenade almost indefinately
			
			player_HEAttack();
			self.ammoGrenades = self.ammoGrenades - 1;
			self.currentammo = self.ammoGrenades;
		}
		else
		{
			self.hgrenade = 0;
			self.impulse = 1;
			return;
		}
	}
    else if (self.weapon == WP_PISTOL)
	{
		if (self.pistolClip > 0)
		{
			playerPistolAttack();
			self.attack_finished = time + 0.2;
		}
        else
		{
			sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
			self.attack_finished = time + 0.5;
			if (AUTORELOAD) self.impulse = 100;
		}
	}
    else if (self.weapon == WP_SHOTGUN)
	{
        if (self.shotgunClip > 0)
        {       
			playerShotgunAttack();
			self.attack_finished = time + 1;
		}
        else 
        {
            sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
            self.attack_finished = time + 0.5;
			if (AUTORELOAD) self.impulse = 100;
		}
	}
    else if (self.weapon == WP_RIFLE)
    {
		if (self.rifleClip > 0) 
		{            
			playerRifleAttack ();   
			self.attack_finished = time + 0.11; //DELAY BETWEEN SHOOTS
		}                           
		else 
		{
			sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
			self.attack_finished = time + 0.5;
			if (AUTORELOAD) self.impulse = 100;
		}
	} 
	else if (self.weapon == WP_SNIPER)
	{
		if (self.sniperClip > 0)
		{
			playerSniperAttack();
			self.attack_finished = time + 1.1; //DELAY BETWEEN SHOOTS
		}
		else
		{
			sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
			self.attack_finished = time + 0.7;
			if (AUTORELOAD) self.impulse = 100;
		}
	}
	else if (self.weapon == WP_HAMMER)
	{
		player_HammerAttack();
	}
};

/*
	============
	W_ChangeWeapon
	============
*/
void() W_ChangeWeapon =
{
    local float wp, am, fl, r;
	
    wp = self.weapons;
	am = 0;
	
    if (self.reload)
	{
		self.impulse =0;
		return;
	}
	self.hgrenade = 0;
	
	
	if (self.impulse == 1) fl = WP_ONE;
	else if (self.impulse == 2)
	{
		fl = WP_PISTOL;
		if (self.pistolClip < 1 && self.ammoPistol < 1) am = 1;
	}
	else if (self.impulse == 3)
	{
		if(deathmatch)
		{
			if(self.class == CLASS_BREACHER)
			{
				fl = WP_SHOTGUN;
				if (self.shotgunClip < 1 && self.ammoShells < 1) am = 1;
			}
			else if(self.class == CLASS_MARKSMAN)
			{
				fl = WP_SNIPER;
				if (self.sniperClip < 1 && self.ammoSniper < 1) am = 1;
			}
			else if(self.class == CLASS_ENGINEER)
			{
				fl = WP_HAMMER;
				if (self.ammoBarricades < 1) am = 1;
			}
			else
			{
				fl = WP_RIFLE;
				if (self.rifleClip < 1 && self.ammoRifle < 1) am = 1;
			}
		}
		else
		{
			fl = WP_SHOTGUN;
			if (self.shotgunClip < 1 && self.ammoShells < 1) am = 1;
		}
	}
	else if (self.impulse == 4) 
	{
		fl = WP_RIFLE;
		if (self.rifleClip < 1 && self.ammoRifle < 1) am = 1;
	}
	else if (self.impulse == 5)
	{
		fl = WP_SNIPER;
		if (self.sniperClip < 1 && self.ammoSniper < 1) am = 1;
	}
    else if (self.impulse == 6)
	{
		fl = WP_GRENADE;
		self.hgrenade = 1;
		if (self.ammoGrenades < 1) am = 1;
	}
	else if (self.impulse == 7)
	{
		fl = WP_HAMMER;
		if (self.ammoBarricades < 1) am = 1;
	}
	
	self.impulse = 0;
	
	if (!(wp & fl)) // don't have the weapon or the ammo
	{	
		sprint (self, "No weapon\n");
		return;
	}
	if (am) // don't have the ammo
	{	
		self.hgrenade = 0;
		sprint (self, "Not enough ammo.\n");
		return;
	}
	if (self.weapon == fl)
	{
		//sprint (self, "ALREADY SELECTED\n");
		return;	
	}
	
	self.weapon = fl;	
	W_SetCurrentAmmo ();
	
	r = random();
	if(r < 0.3) r = 0.3;
	if(r > 0.8) r = 0.8;
	sound(self,CHAN_AUTO,"player/switch.wav",r,ATTN_NORM);
	
	if(fl == WP_PISTOL) 
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_pistol.md3");
		else setmodel (self, "models/ussr_pistol.md3");
		playerPistolSwitch();
	}
	else if(fl == WP_ONE) 
	{
		if (deathmatch == MODE_HNS) setmodel (self, "models/runner_blue.md3");
		else
		{
			if(self.team == TEAM_USA) setmodel (self, "models/usa_knife.md3");
			else setmodel (self, "models/ussr_knife.md3");
			playerKnifeSwitch();
		}
	}
	else if(fl == WP_SHOTGUN)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_shot.md3");
		else setmodel (self, "models/ussr_shot.md3");
		player_TozSwitch();
	}
	else if(fl == WP_RIFLE)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_rifle.md3");
		else setmodel (self, "models/ussr_rifle.md3");
		playerRifleSwitch();
	}
	else if(fl == WP_SNIPER)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_sniper.md3");
		else setmodel (self, "models/ussr_sniper.md3");
		playerSniperSwitch();
	}
	else if(fl == WP_GRENADE) 
	{
		//if(self.team == TEAM_USA) setmodel (self, "models/v_grenade_usa.md3");
		//else setmodel (self, "models/v_grenade.md3");
		player_HESwitch();
	}
	else if(fl == WP_HAMMER) player_HammerSwitch();
	
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
};

/*
	============
	CheatCommand
	============
*/
void() CheatCommand =
{
	if (deathmatch /*|| coop*/) return;
	
	self.ammoPistol = 100;
	self.ammoGrenades = 100;
	self.ammoRifle = 200;
	self.ammoShells = 100;
	self.ammoBarricades = 5;
	self.items = self.items | 
	IT_KNIFE |
	IT_PM |
	IT_TOZ |
	IT_AKM |
	IT_GRENADE |
	IT_MOSIN |
	IT_HAMMER |
	IT_KEY1 | IT_KEY2;
	self.weapons = self.weapons |
	WP_ONE |
	WP_PISTOL |
	WP_SHOTGUN |
	WP_RIFLE |
	WP_GRENADE |
	WP_HAMMER |
	WP_SNIPER;
	self.ammoSniper = 200;
	self.pistolClip = CLIP_PISTOL;
	self.shotgunClip = CLIP_SHOTGUN;
	self.rifleClip = CLIP_RIFLE;
	self.sniperClip = CLIP_SNIPER;
	self.m60clip = 200;
	self.items = self.items | IT_BOMB;
	
    self.weapon = WP_SNIPER;
	self.impulse = 0;
	W_SetCurrentAmmo ();
};

/*
	============
	CycleWeaponCommand
	
	Go to the next weapon with ammo
	============
*/
void() CycleWeaponCommand =
{
	if(self.weapon == WP_ONE)
	{
		if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_PISTOL)
	{
		if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_SHOTGUN)
	{
		if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
	}
	if(self.weapon == WP_RIFLE)
	{
		if((self.weapons & WP_SNIPER) && self.sniperClip > 0 && self.ammoSniper > 0) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
	}
	if(self.weapon == WP_SNIPER)
	{
		if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
	}
	if(self.weapon == WP_GRENADE)
	{
		if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
	}
	
	W_ChangeWeapon();
	self.impulse = 0;
};

/*
	============
	CycleWeaponReverseCommand
	
	Go to the prev weapon with ammo
	============
*/
void() CycleWeaponReverseCommand =
{
	if(self.weapon == WP_SNIPER)
	{
		if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_RIFLE)
	{
		if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
	}
	if(self.weapon == WP_SHOTGUN)
	{
		if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
	}
	if(self.weapon == WP_PISTOL)
	{
		if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_SNIPER) && (self.sniperClip > 0 || self.ammoSniper > 0)) self.impulse = 5;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
	}
	if(self.weapon == WP_ONE)
	{
		if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_SNIPER) && self.ammoGrenades > 0) self.impulse = 5;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
	}
	if(self.weapon == WP_GRENADE)
	{
		if((self.weapons & WP_SNIPER) && self.ammoGrenades > 0) self.impulse = 5;
		else if((self.weapons & WP_RIFLE) && (self.rifleClip > 0 || self.ammoRifle > 0)) self.impulse = 4;
		else if((self.weapons & WP_SHOTGUN) && (self.shotgunClip > 0 && self.ammoShells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PISTOL) && (self.pistolClip > 0 || self.ammoPistol > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
	}
	
	W_ChangeWeapon();
	self.impulse = 0;
};
/*
	============
	ServerflagsCommand
	
	Just for development
	============
*/
void() ServerflagsCommand =
{
	if (deathmatch) return;
	serverflags = serverflags * 2 + 1;
};


/*
	============
	ImpulseCommands
	RELOADING
	============
*/

void() ImpulseCommands =
{ 
	if (self.impulse >= 1 && self.impulse <= 8 && self.menu == MENU_OFF) W_ChangeWeapon ();
	if (self.impulse == 9) CheatCommand ();
	if (self.impulse == 10) CycleWeaponCommand ();
	if (self.impulse == 11) ServerflagsCommand ();
	if (self.impulse == 12) CycleWeaponReverseCommand ();
	
	if(self.impulse == 100)	//reloading
	{
		switch(self.weapon)
		{
			case 0:
				if(self.lastcheckpoint_x != 0) //(self.model == "models/runner_red.md3" || self.model == "models/runner_blue.md3")
				{
					setorigin (self, self.lastcheckpoint);
					self.impulse = 0;
					return;
				}
				else self.impulse = 0;
			case WP_PISTOL:
				if (self.pistolClip == CLIP_PISTOL || self.ammoPistol == 0 || self.reload || self.button0)
				{
					self.impulse = 0;
					return;
				}
				playerPistolReload();
			case WP_SHOTGUN:
				if (self.shotgunClip == CLIP_SHOTGUN || self.ammoShells == 0 || self.reload || self.button0)
				{
					self.impulse = 0;
					return;
				}
				playerShotgunReload();
			case WP_RIFLE:
				if (self.rifleClip == CLIP_RIFLE || self.ammoRifle == 0 || self.reload || self.button0)
				{
					self.impulse = 0;
					return;
				}
				playerRifleReload ();
			case WP_SNIPER:
				if (self.sniperClip == CLIP_SNIPER || self.ammoSniper == 0 || self.reload || self.button0)
				{
					self.impulse = 0;
					return;
				}
				playerSniperReload();
		}
		self.impulse = 0;
	}
	if (self.impulse == 102) //zoom
	{
		if(self.weapon == WP_SNIPER && self.weaponframe < 90)
		{
			if (self.zoomlevel == 0) self.zoomlevel = 1;
			else self.zoomlevel = 0;
		}
		self.impulse = 0;
	}
	if (self.impulse == 103) 
	{ 
		if(deathmatch) SpawnBot();
		self.impulse = 0;
	}
	if (self.impulse == 104) KickBot();

}

/*
	============
	W_WeaponFrame
	
	Called every frame so impulse events can be handled as well as possible
	============
*/
void() W_WeaponFrame =
{
	if (time < self.attack_finished) return;
	ImpulseCommands ();
	if (self.button0) W_Attack ();	// check for attack
};

















