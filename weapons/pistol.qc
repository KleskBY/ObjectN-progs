/********************** APS ************************/

void (float damage, vector dir) pistolTraceAttack = 
{
	local vector vel;
	local vector org;
	local vector meatdir;
	local float particle_color;

	if(self.duck) vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	else vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	vel = (vel + (FL_SWIM * trace_plane_normal));
	vel = (vel * 200);
	org = (trace_endpos - (dir * MOVETYPE_STEP));
	
	if(trace_ent.takedamage) 
	{
		if(DetectObject(damage, org, dir)) return;
		damage = DetectHitbox(damage);
		
		particle_color = random ();
		meatdir_x = ((random () * 300) );
		meatdir_y = ((random () * 300) );
		meatdir_z = ((random () * 300) );
		makevectors (self.v_angle);
		
		if (particle_color < 0.8 && damage >= 12) 
		{
			Shoot_Blood (org,meatdir);
			SpawnBlood (org,(vel * 0.200),(damage * 100)); 
		}
		
		if (damage >= 20)
		{
			Shoot_Blood (org + '10 10 0',v_forward * 200);
			Shoot_Blood (org,v_forward * 200);
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

void() W_FirePM = 
{
	local vector dir;
	local vector src;
	local float r;
	local float SpreadX, SpreadY, temp;
	
	self.pistolClip = self.pistolClip - 1;
	makevectors (self.angles);
	dir = aim (self,1000);
	makevectors (self.v_angle);
	//src = (self.origin + self.view_ofs + (v_forward * TE_LAVASPLASH));
	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800)); //0.800
	if(self.duck) src_z = (self.absmin_z + self.size_z);
	src_y = (self.absmin_y + (self.size_y * 0.5)); //0.400
	ClearMultiDamage ();
	r = random ();
	
	SpreadX = random (-30,30);
	SpreadY = random (-30,30);
	
	// if (self.ShootsFired == 0) traceline (src, (src + (v_forward * IT_9x18 * 2)) - (v_right * (SpreadX * 0.15)) - (v_up * (SpreadY*0.15)), FALSE, self);
	// else if (self.ShootsFired == 1) traceline (src, (src + (v_forward * IT_9x18 * 2)) - (v_right * (SpreadX * 0.333)) - (v_up * (SpreadY*0.333)), FALSE, self);
	// else if (self.ShootsFired == 2) traceline (src, (src + (v_forward * IT_9x18 * 2)) - (v_right * (SpreadX * 0.666)) - (v_up * (SpreadY * 0.666)), FALSE, self);
	// else 
	traceline (src, (src + (v_forward * IT_9x18 * 2)) - (v_right * SpreadX) - (v_up * SpreadY), FALSE, self);

	
	temp = vlen(trace_endpos - self.origin);
	if (temp < 250) pistolTraceAttack(25,dir);
	else if ((temp < 350) && (temp >= 250)) pistolTraceAttack (22,dir);
	else pistolTraceAttack (21,dir);


	ApplyMultiDamage ();
	
	self.punchangle_x = -2;
	temp = random (2);
	self.punchangle_z = -temp;
	
	if(self.weaponmodel == "models/v_colt.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/pistol/glock.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*36 + v_right*5, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*35 - v_right * (-11), dir);
	}
	else 
	{
		sound (self,CHAN_WEAPON,"weapons/pistol/pm.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*25 + v_right*10, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -9 + v_forward*22 - v_right * (-11), dir);
	}
};





/************************ REALOADING PM ПЕРЕЗАРЯДКА ПМ *************************/

void() playerPistolReload = [ 0, playerPistolReload2 ]
{
	playerAnim();
	self.nextthink = time + 0.03;
	self.reload = 1;
	sound(self,CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
	if(self.team == TEAM_USA) self.weaponframe = 45;
	else self.weaponframe = 36;
};

void() playerPistolReload3 = [ 0, playerPistolReload3 ]
{
	playerAnim();
	self.weaponframe = self.weaponframe - 1;
	self.nextthink = time + 0.02;
	if(self.weaponframe == 59) sound(self, CHAN_WEAPON,"weapons/pistol/clipin.wav", 0.5, ATTN_NORM);
	if(self.weaponframe <= 37)
	{
		if(self.ammoPistol >= CLIP_PISTOL)
		{
			self.ammoPistol = (self.ammoPistol - (CLIP_PISTOL -self.pistolClip));
			self.pistolClip = CLIP_PISTOL;
		}
		else 
		{
			self.pistolClip = self.ammoPistol;
			self.ammoPistol = 0;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
}

void() playerPistolReload2 = [ 0, playerPistolReload2 ]
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	if(!deathmatch && self.weaponframe > 85 && self.pistolClip > 0)
	{
		self.think = playerPistolReload3;
		return;
	}
	
	if(self.team == TEAM_USA)
	{
		self.nextthink = time + 0.061;
		if(self.weaponframe == 60) sound(self, CHAN_WEAPON, "weapons/pistol/clipout.wav", 0.5, ATTN_NORM);
		if(self.weaponframe == 70) sound(self, CHAN_WEAPON, "weapons/pistol/clipin.wav", 0.5, ATTN_NORM);
		if(self.weaponframe == 78) sound(self, CHAN_WEAPON,"weapons/pistol/slideback.wav", 0.5, ATTN_NORM);
	}
	else
	{
		self.nextthink = time + 0.02;
		if(self.weaponframe == 56) sound(self, CHAN_WEAPON,"weapons/pistol/clipout.wav", 0.5, ATTN_NORM);
		if(self.weaponframe == 104) sound(self, CHAN_WEAPON,"weapons/pistol/clipin.wav", 0.5, ATTN_NORM);
		if(self.weaponframe == 132) sound(self, CHAN_WEAPON,"weapons/pistol/slideback.wav", 0.5, ATTN_NORM);
	}
	
	if(self.weaponframe == 156 || (self.team == TEAM_USA && self.weaponframe == 85))
	{
		if(self.ammoPistol >= CLIP_PISTOL)
		{
			self.ammoPistol = (self.ammoPistol - (CLIP_PISTOL -self.pistolClip));
			self.pistolClip = CLIP_PISTOL;
		}
		else 
		{
			self.pistolClip = self.ammoPistol;
			self.ammoPistol = 0;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};

/************************** FIRE PM ***********************************************/

void() playerPistolAttack = [ 0, playerPistolAttack2 ]
{
	playerAnim();
	self.effects = self.effects | EF_MUZZLEFLASH;
	if(self.team == TEAM_USA) self.weaponframe = 34;
	else self.weaponframe = 26;
	self.nextthink = time + 0.01;
	W_FirePM ();
	self.ShootsFired = self.ShootsFired + 1;
};

void() playerPistolAttack2 = [ 0, playerPistolAttack2 ]
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.01;
	if(self.team == TEAM_USA)
	{
		if(self.weaponframe >= 43)
		{
			self.think = player_run;
			self.reload = 0;
		}
	}
	else
	{
		if(self.weaponframe >= 35)
		{
			self.think = player_run;
			self.reload = 0;
		}
	}
};
	
	
	/************************** SWITCH PM ***********************************************/
	
void() playerPistolSwitch = [ 1, playerPistolSwitch2 ]
{
	playerAnim();
	self.weaponframe = 1;
	self.nextthink = time + 0.025;
	self.reload = 1;
};
	
void() playerPistolSwitch2 = [ 1, playerPistolSwitch2 ]
{
	playerAnim();
	if(self.team == TEAM_USA)
	{
		self.weaponframe = self.weaponframe + 1;
		self.nextthink = time + 0.015;
		if(self.weaponframe >= 33)
		{
			W_SetCurrentAmmo ();
			self.think = player_run;
			self.reload = 0;
		}
	}
	else
	{
		self.weaponframe = self.weaponframe + 1;
		self.nextthink = time + 0.025;
		if(self.weaponframe >= 25)
		{
			W_SetCurrentAmmo ();
			self.think = player_run;	//player_change_gun;
			self.reload = 0;
		}
	}
};
	