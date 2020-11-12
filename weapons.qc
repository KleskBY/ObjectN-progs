void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void(vector org, vector vel, float damage) SpawnBlood;
void (float shotcount,vector dir,vector spread) FireMossberg;

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
void (float damage, vector dir) TraceAttack = 
{
	local vector vel;
	local vector org;
	
	vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	vel = (vel + (FL_SWIM * trace_plane_normal));
	vel = (vel * 200.000);
	org = (trace_endpos - (dir * MOVETYPE_STEP));
	if (trace_ent.takedamage) 
	{
		SpawnBlood (org,(vel * 0.200),(damage * 100.000));
		AddMultiDamage (trace_ent,damage);
	} 
	else 
	{
		WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST,TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST,org_x);
		WriteCoord (MSG_BROADCAST,org_y);
		WriteCoord (MSG_BROADCAST,org_z);
		particle (org,'3.000 2.000 7.000',192.000,TE_WIZSPIKE);
		particle (org,'7.000 6.000 8.000',192.000,TE_WIZSPIKE);
		//sound (self.enemy,CHAN_AUTO,"sound/weapons/ak47/ak47-1.wav",TRUE,ATTN_NORM);         
		pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -8 + v_forward*20, self.velocity*50, 1);
	}
};

/*
	================
	FireBullets
	
	Used by shotgun, super shotgun, and enemy soldier firing
	Go to the trouble of combining multiple pellets into a single damage call.
	================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);
	
	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	
	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0) TraceAttack (4, direction);
		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
};


// void() Muzzle_Think =
// {
// makevectors (self.owner.v_angle);
// self.velocity = aim(self.owner, 1000);
// self.angles = vectoangles(self.velocity);
// self.angles = self.angles + '0 -90 0';			
// setorigin (self, self.owner.origin + (v_forward * 30.000) - (v_right * -0.5) + (v_up * 19.000));

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
    local vector src;
	player_run ();		// get out of any weapon firing states
	self.zoomlevel = 0;
	stuffcmd(self,"fov 90 \n");
	
	self.items = self.items - ( self.items & (IT_SHELLS | IT_545x39 | IT_ROCKETS | IT_762x54 | IT_9x18));
    // Remove_Laser_Sights();  // remove any active laser sights
	
    if (self.weapon == WP_ONE)
	{
		self.currentammo = 0;
		self.weaponmodel = "models/v_knife.md3";
		self.weaponframe = 0;
	}
    else if (self.weapon == WP_PM)
	{
		self.currentammo = self.ammo_9x18;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_glock.md3";
		else self.weaponmodel = "models/v_pm.md3";
		self.weaponframe = 0;
		self.items = self.items | IT_9x18;
	}
	else if (self.weapon == WP_TOZ)
	{
		self.currentammo = self.ammo_shells;
        if(self.team == TEAM_USA) self.weaponmodel = "models/v_xm.md3";
		else self.weaponmodel = "models/v_toz.md3";
		self.weaponframe = 0;
        self.items = self.items | IT_SHELLS;
	}
    else if (self.weapon == WP_AKM)
    {
		self.currentammo = self.ammo545x39;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_m4.md3";
		else self.weaponmodel = "models/v_ak74.md3";
		self.weaponframe = FALSE;
        self.items = (self.items | IT_545x39);
	}
    else if (self.weapon == WP_GRENADE)
	{	   
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "models/v_grenade.md3";
		self.items = self.items | IT_ROCKETS;
	}
    else if (self.weapon == WP_MOSIN)
	{
		self.currentammo = self.ammo_762x54;
		if(self.team == TEAM_USA) self.weaponmodel = "models/v_awp.md3";
		else self.weaponmodel = "models/v_mosin.md3";
		self.weaponframe = 0;
        self.items = self.items | IT_762x54;
	}
	else if (self.weapon == WP_HAMMER)
	{	   
		self.currentammo = self.ammo_barricades;
		self.weaponmodel = "models/v_hammer.md3";
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
	
	if ((self.psg1clip >= 1) && (wp & WP_MOSIN)) return WP_MOSIN; // Barrett
	if ((self.AKMclip >= 1) && (wp & WP_AKM)) return WP_AKM; // AKM
	if ((self.mossclip >= 1) && (wp & WP_TOZ)) return WP_TOZ; // mossberg
	if ((self.PMclip >= 1) && (wp & WP_PM)) return WP_PM; // PM
	
	return WP_ONE;
};


/*
	============
	W_Attack
	
	An attack impulse can be triggered now
	============
*/

void()	player_ApsAttack;
void()  player_ApsReload;
void()  player_ApsSwitch;

void()  player_KnifeAttack; 
void()  player_KnifeAttackb; 
void()  player_KnifeSwitch;

void()  player_HEAttack;
void() 	player_HESwitch;

void()  player_TozAttack;
void()  player_TozReload;
void()  player_TozSwitch;
void()  player_XmReload;

void()	player_AK74Attack;
void()  player_AK74Reload;
void() 	player_AK74Switch;

void()  player_MosinAttack;
void()  player_MosinAttackb;
void()  player_MosinReload;

void()  player_AwpAttack;
void()  player_AwpAttackb;
void()  player_AwpReload;

void () player_MosinZoomOut;
void () player_MosinZoom;

void () player_AwpZoomOut;
void () player_AwpZoom;

void () player_HammerAttack;
void () player_HammerSwitch;

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
		if(r <0.55) player_KnifeAttack();
		else player_KnifeAttackb();
	}
    else if (self.weapon == WP_GRENADE)
	{
		if (self.ammo_rockets > 0) 
		{
			self.grenadetime = 0;
			self.attack_finished = time + 9999; //ugly hack, but lets you hold the grenade almost indefinately
			
			player_HEAttack();
			self.ammo_rockets = self.ammo_rockets - 1;
			self.currentammo = self.ammo_rockets;
		}
		else
		{
			self.hgrenade = 0;
			self.impulse = 1;
			return;
		}
	}
    else if (self.weapon == WP_PM)
	{
		if (self.PMclip > 0)
		{
			player_ApsAttack();
			self.attack_finished = time + 0.18;
		}
        else
		{
			sound(self,CHAN_WEAPON,"weapons/pm/pm_noammo.wav",TRUE,ATTN_NORM);
			self.attack_finished = time + 0.5;
		}
	}
    else if (self.weapon == WP_TOZ)
	{
        if (self.mossclip > 0)
        {       
			player_TozAttack();
			pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -2.6 + v_forward*26 + v_right*3.7, self.velocity*50, 1);
			self.attack_finished = time + 0.850;
		}
        else 
        {
            sound(self,CHAN_WEAPON,"weapons/pm/pm_noammo.wav",TRUE,ATTN_NORM);
            self.attack_finished = (time + 0.400);
		}
	}
    else if (self.weapon == WP_AKM)
    {
		if (self.AKMclip > 0) 
		{            
			player_AK74Attack ();   
			self.attack_finished = time + 0.11; //DELAY BETWEEN SHOOTS
		}                           
		else 
		{
			sound (self,CHAN_WEAPON,"weapons/ak47/ak47_click.wav",TRUE,ATTN_NORM);
			self.attack_finished = (time + 0.400);
		}
	} 
	else if (self.weapon == WP_MOSIN)
	{
		if (self.psg1clip > 0)
		{
			if(self.zoomlevel == 0)
			{
				if(self.weaponmodel == "models/v_awp.md3") player_AwpAttack();
				else player_MosinAttack();
				self.attack_finished = time + 2.3; //DELAY BETWEEN SHOOTS
			}
			else 
			{
				if(self.weaponmodel == "models/v_awp.md3") player_AwpAttackb();
				else player_MosinAttackb();
				self.attack_finished = time + 3;
			}
		}
		else
		{
			sound (self,CHAN_WEAPON,"weapons/ak47/ak47_click.wav",TRUE,ATTN_NORM);
			self.attack_finished = time + 0.7;
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
		fl = WP_PM;
		if (self.PMclip < 1 && self.ammo_9x18 < 1) am = 1;
	}
	else if (self.impulse == 3)
	{
		if(deathmatch)
		{
			if(self.class == CLASS_BREACHER)
			{
				fl = WP_TOZ;
				if (self.mossclip < 1 && self.ammo_shells < 1) am = 1;
			}
			else if(self.class == CLASS_MARKSMAN)
			{
				fl = WP_MOSIN;
				if (self.psg1clip < 1 && self.ammo_762x54 < 1) am = 1;
			}
			else if(self.class == CLASS_ENGINEER)
			{
				fl = WP_HAMMER;
				if (self.ammo_barricades < 1) am = 1;
			}
			else
			{
				fl = WP_AKM;
				if (self.AKMclip < 1 && self.ammo545x39 < 1) am = 1;
			}
		}
		else
		{
			fl = WP_TOZ;
			if (self.mossclip < 1 && self.ammo_shells < 1) am = 1;
		}
	}
	else if (self.impulse == 4) 
	{
		fl = WP_AKM;
		if (self.AKMclip < 1 && self.ammo545x39 < 1) am = 1;
	}
	else if (self.impulse == 5)
	{
		fl = WP_MOSIN;
		if (self.psg1clip < 1 && self.ammo_762x54 < 1) am = 1;
	}
    else if (self.impulse == 6)
	{
		fl = WP_GRENADE;
		self.hgrenade = 1;
		if (self.ammo_rockets < 1) am = 1;
	}
	else if (self.impulse == 7)
	{
		fl = WP_HAMMER;
		if (self.ammo_barricades < 1) am = 1;
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
	if(r <0.3) r =0.3;
	if(r >0.8) r =0.8;
	sound(self,CHAN_AUTO,"weapons/pm/pm_cloth.wav",r,ATTN_NORM);
	
	if(fl == WP_PM) 
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_glock.md3");
		else setmodel (self, "models/ussr_aps.md3");
		modelindex_ussr_aps = self.modelindex;
		player_ApsSwitch();
	}
	else if(fl == WP_ONE) 
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
	else if(fl == WP_TOZ)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_xm.md3");
		else setmodel (self, "models/ussr_toz.md3");
		modelindex_ussr_toz = self.modelindex;
		player_TozSwitch();
	}
	else if(fl == WP_AKM)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_m4.md3");
		else setmodel (self, "models/ussr_ak74.md3");
		modelindex_ussr_ak74 = self.modelindex;
		player_AK74Switch();
	}
	else if(fl == WP_MOSIN)
	{
		if(self.team == TEAM_USA) setmodel (self, "models/usa_awp.md3");
		else setmodel (self, "models/ussr_mosin.md3");
		modelindex_ussr_mosin = self.modelindex;
	}
	else if(fl == WP_GRENADE) player_HESwitch();
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
	
	self.ammo_9x18 = 100;
	self.ammo_rockets = 100;
	self.ammo545x39 = 200;
	self.ammo_shells = 100;
	self.ammo_barricades = 5;
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
	WP_PM |
	WP_TOZ |
	WP_AKM |
	WP_GRENADE |
	WP_HAMMER |
	WP_MOSIN;
	self.ammo_762x54 = 200;
	self.PMclip = 20;
	self.mossclip = 7;
	self.AKMclip = 30;
	self.psg1clip = 5;
	self.m60clip = 200;
	self.items = self.items | IT_BOMB;
	
    self.weapon = WP_MOSIN;
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
		if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_PM)
	{
		if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_TOZ)
	{
		if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
	}
	if(self.weapon == WP_AKM)
	{
		if((self.weapons & WP_MOSIN) && self.psg1clip > 0 && self.ammo_762x54 > 0) self.impulse = 5;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
	}
	if(self.weapon == WP_MOSIN)
	{
		if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
	}
	if(self.weapon == WP_GRENADE)
	{
		if(self.weapons & WP_ONE) self.impulse = 1;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
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
	if(self.weapon == WP_MOSIN)
	{
		if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
	}
	if(self.weapon == WP_AKM)
	{
		if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
	}
	if(self.weapon == WP_TOZ)
	{
		if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
		else if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
	}
	if(self.weapon == WP_PM)
	{
		if(self.weapons & WP_ONE) self.impulse = 1;
		else if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_MOSIN) && (self.psg1clip > 0 || self.ammo_762x54 > 0)) self.impulse = 5;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
	}
	if(self.weapon == WP_ONE)
	{
		if(self.weapons & WP_GRENADE) self.impulse = 6;
		else if((self.weapons & WP_MOSIN) && self.ammo_rockets > 0) self.impulse = 5;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
	}
	if(self.weapon == WP_GRENADE)
	{
		if((self.weapons & WP_MOSIN) && self.ammo_rockets > 0) self.impulse = 5;
		else if((self.weapons & WP_AKM) && (self.AKMclip > 0 || self.ammo545x39 > 0)) self.impulse = 4;
		else if((self.weapons & WP_TOZ) && (self.mossclip > 0 && self.ammo_shells > 0)) self.impulse = 3;
		else if((self.weapons & WP_PM) && (self.PMclip > 0 || self.ammo_9x18 > 0)) self.impulse = 2;
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
	
	// if (self.impulse == 13) 
	// {
		// DrawBarricade ();
		// self.impulse = 0;
	// }
	if (self.impulse == 14) 
	{
		flash_toggle ();
		self.impulse = 0;
	}
	
	if((self.impulse == 100) && (self.model == "models/runner_red.md3" || self.model == "models/runner_blue.md3"))  /*&& (strstrofs(world.model,"kz_",0) != -1)*/
	{
		if(self.lastcheckpoint_x != 0)
		{
			setorigin (self, self.lastcheckpoint);
			self.impulse = 0;
			return;
		}
		else self.impulse = 0;
	}
	
	/******************** Mossberg reload sequence ***************************/
	
	if ((self.impulse == 100) && (self.weaponmodel == "models/v_toz.md3" || self.weaponmodel == "models/v_xm.md3"))
	{
		if (self.mossclip == 7 || self.ammo_shells == 0 || self.reload || self.button0)
		{
			self.impulse = 0;
			return;
		}
		else
		{
			if(self.weaponmodel == "models/v_xm.md3") player_XmReload();
			else player_TozReload();
		}
	}
    
	/******************** AKM reload sequence*********************************/
	
	if (self.impulse == 100 && (self.weaponmodel == "models/v_ak74.md3" || self.weaponmodel == "models/v_m4.md3" ))                        
	{
		if (self.AKMclip == 30 || self.ammo545x39 == 0 || self.reload || self.button0)
		{
			self.impulse = 0;
			return;
		}
		else player_AK74Reload ();
	}
	
	/****************** Sniper reload sequence*********************************/
	
	if (self.impulse == 100 && (self.weaponmodel == "models/v_mosin.md3" || self.weaponmodel == "models/v_awp.md3"))
	{
		if (self.psg1clip == 5 || self.ammo_762x54 == 0 || self.reload || self.button0)
		{
			self.impulse = 0;
			return;
		}
		else  
		{
			if(self.weaponmodel == "models/v_awp.md3") player_AwpReload();
			else player_MosinReload();		
		}
	}
	
	/******************* Pistol reload sequence *********************************/
	if (self.impulse == 100 && (self.weaponmodel == "models/v_pm.md3" || self.weaponmodel == "models/v_glock.md3" ))
	{
		if (self.PMclip == 20 || self.ammo_9x18 == 0 || self.reload || self.button0)
		{
			self.impulse = 0;
			return;
		}
		player_ApsReload();
	} 
	
	/******************* Barrett Zoom Feature ************************/
	if ((self.impulse == 102) && (self.weapon == WP_MOSIN) && (self.psg1clip > 0))
	{
		if (self.zoomlevel == 0)
		{
			self.zoomlevel = 1;
			if(self.weaponmodel == "models/v_awp.md3") player_AwpZoom();
			else player_MosinZoom();
		}
		else
		{
			self.zoomlevel = 0;
			if(self.weaponmodel == "models/v_awp.md3") player_AwpZoomOut();
			else player_MosinZoomOut();
		}
		self.impulse = 0;
	}
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


