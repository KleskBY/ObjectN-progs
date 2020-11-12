
/******************************************/
/*   TOZ SHOTGUN                    	  */
/******************************************/



float(entity hit, float damage) MossbergAddMultiDamage =
{
	if (!hit) return 0;
	if (hit != multi_ent)
	{
		ApplyMultiDamage ();
		multi_damage = damage;
		multi_ent = hit;
	}
	else multi_damage = multi_damage + damage;                     
    return multi_damage;
};

void (float damage, vector dir) MossbergTraceAttack = 
{
	local vector vel;
	local vector org;
	local vector meatdir;
	local float rand;

	vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	vel = (vel + (FL_SWIM * trace_plane_normal));
	vel = (vel * 200.000);
	org = (trace_endpos - (dir * MOVETYPE_STEP));
	meatdir_x = ((random () * 300.000) + dir_x);
	meatdir_y = ((random () * 300.000) + dir_y);
	meatdir_z = ((random () * 300.000) + dir_z);
	makevectors(self.v_angle);
	if (trace_ent.takedamage) 
	{
		if(trace_ent.classname == "button")
		{
			AddMultiDamage (trace_ent,damage);
			return;
		}
		if(trace_ent.classname == "breakable")
		{
			pointparticles(particleeffectnum("nailgun_muzzleflash"), org, self.velocity*50, 1);
			WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST,TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST,org_x);
			WriteCoord (MSG_BROADCAST,org_y);
			WriteCoord (MSG_BROADCAST,org_z);

			meatdir_x = ((random () * 300.000) + dir_x);
			meatdir_y = ((random () * 300.000) + dir_y);
			meatdir_z = ((random () * 300.000) + dir_z);
			ShootGlass (org,meatdir);
			meatdir_x = ((random () * 300.000) + dir_x);
			meatdir_y = ((random () * 300.000) + dir_y);
			meatdir_z = ((random () * 300.000) + dir_z);
			ShootGlass (org,meatdir);
			meatdir_x = ((random () * 300.000) + dir_x);
			meatdir_y = ((random () * 300.000) + dir_y);
			meatdir_z = ((random () * 300.000) + dir_z);
			ShootGlass (org,meatdir);
			
			AddMultiDamage (trace_ent,damage);
			return;
		}
		
		DetectHitbox(damage);
		
		if (rand < 0.5) Shoot_Blood (org,meatdir);
		rand=MossbergAddMultiDamage (trace_ent,damage);

	} 
	else 
	{
		WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST,TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST,org_x);
		WriteCoord (MSG_BROADCAST,org_y);
		WriteCoord (MSG_BROADCAST,org_z);
	}
};

void(float shotcount, vector dir, vector spread) FireMossberg =
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
		traceline (src, src + direction*2048 + (v_up * 50), FALSE, self);
		//particle(src + (v_forward * 100),src + direction * 2048,192,random() * 10);
		if (trace_fraction != 1.0) MossbergTraceAttack (8, direction);
		shotcount = shotcount - 1;
	}
    ApplyMultiDamage ();
};

void() W_FireMossberg =
{
	local vector dir;
	self.punchangle_x = -2;
	self.mossclip = self.mossclip - 1;
    dir = aim (self, 100000);
    FireMossberg (16, dir, '0.08 0.06 0.0');
	
	local float temp;
	temp = random (2,6);
	self.punchangle_x = temp;
	self.punchangle_z = -2;
};

void() player_TozAttack = [1, player_TozAttack2] 
{
	local vector dir;
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.weaponframe = 36;
	self.nextthink = time + 0.025;
	self.punchangle_x = -2;
	self.punchangle_z = 2;
	sound(self,CHAN_WEAPON,"weapons/toz/toz-1.wav",TRUE,ATTN_NORM);
	W_FireMossberg ();
	makevectors(self.v_angle);     
	eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*22 - v_right * -8, dir);
};

void() player_TozAttack2 = [2, player_TozAttack2] 
{
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.15;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	if (self.weaponframe >= 50)
	{
		self.think = player_run;
	}
};



void() player_TozReload_back;
void() player_TozReload = [10, player_TozReload2]
{
    self.weaponframe = 50;
	self.nextthink = time + 0.05;
    self.reload = 1;
};
void() player_TozReload2 = [10, player_TozReload2]
{
	
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.05;
	
	if(self.weaponframe == 63)
	{
		if(self.ammo_shells > 0) 
		{
			self.ammo_shells = self.ammo_shells - 1;
			self.mossclip = self.mossclip +1;
			sound(self,CHAN_AUTO,"weapons/toz/toz-insertshell.wav",TRUE,ATTN_NORM);
		}
		else self.think = player_TozReload_back;//self.weaponframe = 76;			
	}
	if(self.weaponframe == 66)
	{
		if (self.mossclip < 7 && self.ammo_shells != 0) self.think = player_TozReload_back;
	}
	if(self.weaponframe == 79) sound(self,CHAN_AUTO,"weapons/toz/toz-pump.wav",TRUE,ATTN_NORM);
	if (self.weaponframe == 99) 
	{
		self.think = player_run;
		W_SetCurrentAmmo();
	}
	if(self.button0 && self.weaponframe <69) self.weaponframe = 69;
};

void() player_TozReload_back = [10, player_TozReload_back]
{
	self.weaponframe = self.weaponframe - 1;
	self.nextthink = time + 0.05;
	if(self.weaponframe == 59) self.think = player_TozReload2;

	if(self.button0 && self.weaponframe <69)
	{
		self.weaponframe = 69;
		self.think = player_TozReload2;
	}
};


///////////////// TOZ WEAPON CHANGE ///////////////////

void () player_toz_hide = [ 1.000, player_toz_hide2 ]
 {
	self.weaponframe = 35;
	sound(self,CHAN_WEAPON,"weapons/pm/pm_noammo.wav",TRUE,ATTN_NORM);
	self.nextthink = time + 0.05;
	self.reload = 1;
 };

void () player_toz_hide2 = [ 1.000, player_toz_hide2 ]
{
	self.weaponframe = self.weaponframe - 1;
	self.nextthink = time + 0.05;
	
	if(self.weaponframe == 2)
	{
		W_SetCurrentAmmo ();
		self.think = player_run;
		self.reload = 0;
	}
};


void () player_TozSwitch = [ 1.000, player_TozSwitch2 ]
{
	self.weaponframe = 2;
	self.nextthink = time + 0.05;
	self.reload = 1;
	
};

void () player_TozSwitch2 = [ 1.000, player_TozSwitch2 ]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.05;
	
	self.currentammo =  self.ammo_shells;
	if(self.weaponframe == 12 && self.weaponmodel == "models/v_toz.md3")  sound(self,CHAN_AUTO,"weapons/toz/toz-pump.wav",TRUE,ATTN_NORM);
	if(self.weaponframe == 34)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};



void() player_XmReload_back;
void() player_XmReload = [10, player_XmReload2]
{
    self.weaponframe = 50;
	self.nextthink = time + 0.04;
    self.reload = 1;
};
void() player_XmReload2 = [10, player_XmReload2]
{
	
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.035;
	
	if(self.weaponframe == 80)
	{
		if(self.ammo_shells > 0) 
		{
			self.ammo_shells = self.ammo_shells - 1;
			self.mossclip = self.mossclip +1;
			sound(self,CHAN_AUTO,"weapons/toz/toz-insertshell.wav",TRUE,ATTN_NORM);
		}
		else self.think = player_XmReload_back;//self.weaponframe = 76;			
	}
	if(self.weaponframe == 83)
	{
		if (self.mossclip < 7 && self.ammo_shells != 0) self.think = player_XmReload_back;
	}
	if (self.weaponframe == 99) 
	{
		self.think = player_run;
		W_SetCurrentAmmo();
	}
	if(self.button0 && self.weaponframe <87) self.weaponframe = 87;
};

void() player_XmReload_back = [10, player_XmReload_back]
{
	self.weaponframe = self.weaponframe - 1;
	self.nextthink = time + 0.035;
	if(self.weaponframe == 66) self.think = player_XmReload2;

	if(self.button0 && self.weaponframe <87)
	{
		self.weaponframe = 87;
		self.think = player_XmReload2;
	}
};


