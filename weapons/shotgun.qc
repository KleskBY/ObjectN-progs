
float(entity hit, float damage) shotgunAddMultiDamage =
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

void (float damage, vector dir) shotgunTraceAttack = 
{
	local vector vel;
	local vector org;
	local vector meatdir;
	local float rand;

	vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	vel = (vel + (FL_SWIM * trace_plane_normal));
	vel = (vel * 200);
	org = (trace_endpos - (dir * MOVETYPE_STEP));
	meatdir_x = ((random () * 300) + dir_x);
	meatdir_y = ((random () * 300) + dir_y);
	meatdir_z = ((random () * 300) + dir_z);
	makevectors(self.v_angle);
	if (trace_ent.takedamage) 
	{
		if(DetectObject(damage, org, dir)) return;
		damage = DetectHitbox(damage);
		if (rand < 0.5) Shoot_Blood (org,meatdir);
		rand=shotgunAddMultiDamage (trace_ent,damage);
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

void(float shotcount, vector dir, vector spread) FireShotgun =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);


	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800)); //0.800
	if(self.duck) src_z = (self.absmin_z + self.size_z);
	src_y = (self.absmin_y + (self.size_y * 0.5)); //0.400
    ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		traceline (src, src + direction * 2048 + (v_up * 50), FALSE, self);
		//particle(src + (v_forward * 100),src + direction * 2048,192,random() * 10);
		if (trace_fraction != 1.0) shotgunTraceAttack (8, direction);
		shotcount = shotcount - 1;
	}
    ApplyMultiDamage ();
};

void() W_FireShotgun =
{
	local vector dir;
	self.punchangle_x = -2;
	self.shotgunClip = self.shotgunClip - 1;
    dir = aim (self, 100000);
    FireShotgun (16, dir, '0.08 0.06 0.0');
	
	local float temp;
	temp = random (2,6);
	self.punchangle_x = temp;
	self.punchangle_z = -2;
};

void() playerShotgunAttack = [1, playerShotgunAttack2] 
{
	local vector dir;
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.weaponframe = 46;
	self.nextthink = time + 0.03;
	self.punchangle_x = -2;
	self.punchangle_z = 2;
	sound(self,CHAN_WEAPON,"weapons/shotgun/shot.wav", 1,ATTN_NORM);
	W_FireShotgun ();
	makevectors(self.v_angle);     
	eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*22 - v_right * -8, dir);
};

void() playerShotgunAttack2 = [2, playerShotgunAttack2] 
{
	playerAnim();
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.03;
	if(self.weaponframe == 60) sound(self,CHAN_AUTO,"weapons/shotgun/pump.wav",0.5,ATTN_NORM);
	if (self.weaponframe >= 73)
	{
		self.think = player_run;
	}
};


void() playerShotgunReload = [73, playerShotgunReload2]
{
	playerAnim();
	self.weaponframe = 73;
	self.nextthink = time + 0.025;
	self.reload = 1;
}
void() playerShotgunReload2 = [73, playerShotgunReload2]
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	if(self.weaponframe == 91 && (self.ammoShells == 1 || self.shotgunClip == 6)) self.weaponframe = 133;
	if(self.weaponframe == 112 || self.weaponframe == 152)
	{
		self.ammoShells = self.ammoShells - 1;
		self.shotgunClip = self.shotgunClip + 1;
		sound(self,CHAN_AUTO,"weapons/shotgun/insertshell.wav",0.6,ATTN_NORM);
		self.currentammo = self.ammoShells;
	}
	if(self.weaponframe == 132 && self.shotgunClip < CLIP_SHOTGUN && self.ammoShells > 1) self.weaponframe = 90;
	if(self.weaponframe == 188) sound(self,CHAN_AUTO, "weapons/shotgun/pump.wav", 0.6, ATTN_NORM);
	if (self.weaponframe == 207) 
	{
		self.think = player_run;
		W_SetCurrentAmmo();
	}
	if(self.button0 && (self.weaponframe < 133 && self.weaponframe> 91)) self.weaponframe = self.weaponframe + 43;
}



// void() player_TozReload_back;
// void() player_TozReload = [10, player_TozReload2]
// {
    // self.weaponframe = 73;
	// self.nextthink = time + 0.025;
    // self.reload = 1;
// };
// void() player_TozReload2 = [10, player_TozReload2]
// {
	// playerAnim();
	
	// self.weaponframe = self.weaponframe + 1;
	// self.nextthink = time + 0.025;
	
	// if(self.weaponframe == 107)
	// {
		// if(self.ammoShells > 0) 
		// {
			// self.ammoShells = self.ammoShells - 1;
			// self.shotgunClip = self.shotgunClip +1;
			// sound(self,CHAN_AUTO,"weapons/shotgun/insertshell.wav",0.6,ATTN_NORM);
		// }
		// else self.think = player_TozReload_back;//self.weaponframe = 76;			
	// }
	// if(self.weaponframe == 130)
	// {
		// if (self.shotgunClip < 6 && self.ammoShells != 0) self.think = player_TozReload_back;
	// }
	// if(self.weaponframe == 188) sound(self,CHAN_AUTO,"weapons/shotgun/pump.wav",0.6,ATTN_NORM);
	// if (self.weaponframe == 207) 
	// {
		// self.think = player_run;
		// W_SetCurrentAmmo();
	// }
	// if(self.button0 && self.weaponframe < 131) self.weaponframe = 131;
// };

// void() player_TozReload_back = [10, player_TozReload_back2]
// {
	// playerAnim();
	// self.weaponframe = 134;
	// self.nextthink = time + 0.025;
// };

// void() player_TozReload_back2 = [10, player_TozReload_back2]
// {
	// playerAnim();
	// self.weaponframe = self.weaponframe + 1;
	// self.nextthink = time + 0.025;
	// if(self.weaponframe == 148) 
	// {
		// self.ammoShells = self.ammoShells - 1;
		// self.shotgunClip = self.shotgunClip + 1;
		// sound(self,CHAN_AUTO,"weapons/shotgun/insertshell.wav", 0.6, ATTN_NORM);
	// }
	// if(self.weaponframe == 188) sound(self,CHAN_AUTO,"weapons/shotgun/pump.wav",0.6,ATTN_NORM);
	// if(self.button0 && self.weaponframe < 131) self.weaponframe = 131;

	// if (self.weaponframe == 207) 
	// {
		// self.think = player_run;
		// W_SetCurrentAmmo();
	// }
// };


///////////////// TOZ WEAPON CHANGE ///////////////////

void() player_toz_hide = [ 1, player_toz_hide2 ]
 {
	self.weaponframe = 35;
	sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
	self.nextthink = time + 0.05;
	self.reload = 1;
 };

void() player_toz_hide2 = [ 1, player_toz_hide2 ]
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


void() player_TozSwitch = [ 1, player_TozSwitch2 ]
{
	self.weaponframe = 1;
	self.nextthink = time + 0.02;
	self.reload = 1;
	
};

void() player_TozSwitch2 = [ 1, player_TozSwitch2 ]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.02;
	
	self.currentammo =  self.ammoShells;
	//if(self.weaponframe == 12 && self.weaponmodel == "models/v_shot.md3")  sound(self,CHAN_AUTO,"weapons/shotgun/pump.wav",TRUE,ATTN_NORM);
	if(self.weaponframe == 45)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};


