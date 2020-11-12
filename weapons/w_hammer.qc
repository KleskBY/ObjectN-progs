/******************************************/
/*         		HAMMER                    */
/******************************************/
void() Barricade_Think =
{
	self.nextthink = time + 0.07;
	if(self.owner == world) return;
	if (self.owner.reload)
	{
		self.owner.barricade_flag = FALSE;
		remove(self);
		return;
	}
	
    makevectors (self.owner.v_angle);
    v_forward_z = 0;
    v_forward = normalize (v_forward) * 64;
    self.origin = self.owner.origin + v_forward;
	self.angles_y = self.owner.angles_y - 3 ;
	
	// makevectors (self.owner.v_angle);
	// src = (self.owner.origin + (v_forward * TE_LAVASPLASH));
	// src_z = (self.owner.absmin_z + (self.owner.size_z * 0.800));
	// src_y = (self.owner.absmin_y + (self.owner.size_y * 0.500));
	// traceline (src, src + (v_forward * 128), FALSE, self.owner);
	// self.origin = (trace_endpos - (v_forward*10) );
	
	droptofloor();
	if(self.owner.attack_finished < time && self.owner.button0)
	{
		self.owner.currentammo = self.owner.ammo_barricades = self.owner.ammo_barricades - 1;
		sound(self, CHAN_VOICE, "weapons/build.wav", 1, ATTN_NORM);
		self.alpha = 1;
		self.movetype = MOVETYPE_NONE;
		self.owner.barricade_flag = FALSE;
		self.owner.attack_finished = self.owner.attack_finished  + 1.5;
		self.owner = world;
	}
	else
	{
		self.nextthink = time + 0.03;
		self.think = Barricade_Think;
	}
};

void() Barricade_Die =
{
	sound(self, CHAN_VOICE, "func/metal1.wav", 0.6, ATTN_NORM);
	self.think = SUB_Remove;
	self.nextthink = self.ltime + 0.01;
};

void() DrawBarricade =
{
	local entity sight;
	//local vector src;
	//local float	oldz;
	
    sight = spawn ();
	sight.owner = self;
	
	
	sight.solid = SOLID_BSP;
	sight.movetype = MOVETYPE_NOCLIP;
	setmodel(sight, "models/barricade.bsp");
	sight.health = 200;
	sight.takedamage = DAMAGE_AIM;
	sight.th_die = Barricade_Die;
	sight.classname = "breakable";
	sight.alpha = 0.5;
	// makevectors (self.v_angle);
	// src = (self.origin + (v_forward * TE_LAVASPLASH));
	// src_z = (self.absmin_z + (self.size_z * 0.800));
	// src_y = (self.absmin_y + (self.size_y * 0.500));
	// traceline (src, src + (v_forward * 128), FALSE, self);
	// sight.origin = (trace_endpos - (v_forward*10) );
	// setorigin (sight, sight.origin);
	
	makevectors (self.v_angle);
    v_forward_z = 0;
    v_forward = normalize (v_forward) * 70;
    sight.origin = self.origin + v_forward;
	
	sight.nextthink = time;
	sight.think = Barricade_Think;	
};

void () player_HammerAttack = [$knifeattack1, HammerA2]
{
	self.weaponframe = 47;
	self.nextthink = time + 0.02;
	if(!self.barricade_flag && self.owner.attack_finished < time && self.ammo_barricades > 0)
	{
		DrawBarricade(); 
		self.barricade_flag = TRUE;
		self.attack_finished = time + 0.5;
		self.think = player_run;
	}
	if(self.ammo_barricades == 0) self.think = player_run;
};

void () HammerA2 = [$knifeattack2, HammerA2]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	self.attack_finished = self.attack_finished + 0.005;
	
	if(self.weaponframe >= 112) self.think = player_run;
};

void () player_HammerSwitch = [ 1.000, player_HammerSwitch2 ]
{
	self.weaponmodel = "models/v_hammer.md3";
	self.weaponframe = 1;
	self.nextthink = time + 0.05;
	self.reload = 1;
	
};


void () player_HammerSwitch2 = [ 1.000, player_HammerSwitch2 ]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	
	if(self.weaponframe == 46)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};



