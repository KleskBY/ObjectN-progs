/********************** APS ************************/

void (float damage, vector dir) PM_TraceAttack = 
{
	local vector vel;
	local vector org;
	local vector meatdir;
	local float particle_color;
	
	if(self.duck) vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	else vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
	vel = (vel + (FL_SWIM * trace_plane_normal));
	vel = (vel * 200.000);
	org = (trace_endpos - (dir * MOVETYPE_STEP));
	
	if(trace_ent.takedamage) 
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
		
		particle_color = random ();
		meatdir_x = ((random () * 300.000) );
		meatdir_y = ((random () * 300.000) );
		meatdir_z = ((random () * 300.000) );
		makevectors (self.v_angle);
		//trace_ent.flags = (trace_ent.flags - FL_ONGROUND);    
		
		if ( (particle_color < 0.8) && (damage >= 12) ) 
		{
			Shoot_Blood (org,meatdir);
			SpawnBlood (org,(vel * 0.200),(damage * 100.000)); 
		}
		
		if (damage >= 20)
		{
			Shoot_Blood (org + '10 10 0',v_forward * 200);
			Shoot_Blood (org,v_forward * 200);
		}
		
		if ((damage <= 20) && (damage > 0))
		{
			if ( (trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) &&
			(trace_ent.duck != 1) && (trace_ent.classname != "misc_explobox") ) 
			{
				trace_ent.flags = trace_ent.flags - FL_ONGROUND;
				trace_ent.velocity = (v_forward * 140.000);
				trace_ent.velocity_z = 200 + (random() * 100);
			}
		}
		if (damage > 20)
		{
			if((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) &&
			(trace_ent.duck != 1)) 
			{
				trace_ent.flags = trace_ent.flags - FL_ONGROUND;
				trace_ent.velocity = (v_forward * 200.000);
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
		
		if (particle_color <= 0.2) 
		{
			sound(self,CHAN_AUTO,"weapons/ric1.wav",1.0,ATTN_NORM);
		}
		if ( (particle_color <= 0.4) && (particle_color > 0.2) )
		{   
			sound(self,CHAN_AUTO,"weapons/ric2.wav",TRUE,ATTN_NORM);
		}   
	}
};

void () W_FirePM = 
{
	local vector dir;
	local vector src;
	local float r;
	local float SpreadX, SpreadY, temp;
	
	self.PMclip = self.PMclip - 1;
	makevectors (self.angles);
	dir = aim (self,1000.000);
	makevectors (self.v_angle);
	src = (self.origin + self.view_ofs + (v_forward * TE_LAVASPLASH)); //src = (self.origin + (v_forward * TE_LAVASPLASH));
	//src_z = (self.absmin_z + (self.size_z * 0.800)); //0.800
	//if(self.duck) src_z = (self.absmin_z + (self.size_z * 1.4)); //0.800
	src_y = (self.absmin_y + (self.size_y * 0.550)); //0.400
	ClearMultiDamage ();
	r = random ();
	
	SpreadX = random (-30,30);
	SpreadY = random (-30,30);
	
	{
		if (self.ShootsFired == 0) traceline (src, (src + (v_forward * IT_9x18)) - (v_right * (SpreadX * 0.15)) - (v_up * (SpreadY*0.15)), FALSE, self);
		else if (self.ShootsFired == 1) traceline (src, (src + (v_forward * IT_9x18)) - (v_right * (SpreadX * 0.333)) - (v_up * (SpreadY*0.333)), FALSE, self);
		else if (self.ShootsFired == 2) traceline (src, (src + (v_forward * IT_9x18)) - (v_right * (SpreadX * 0.666)) - (v_up * (SpreadY * 0.666)), FALSE, self);
		else traceline (src, (src + (v_forward * IT_9x18)) - (v_right * SpreadX) - (v_up * SpreadY), FALSE, self);
	}
	
	temp = vlen(trace_endpos - self.origin);
	// sprint(self, ftos(temp));
	// sprint(self, "\n");
	if(temp < 1034) 
	{
		if (temp < 250) PM_TraceAttack(25.000,dir);
		else if ((temp < 350) && (temp >= 250)) PM_TraceAttack (22.000,dir);
		//else if ((temp < 450) && (temp >= 350)) PM_TraceAttack (15,dir);
		else PM_TraceAttack (20,dir);
	}

	ApplyMultiDamage ();
	
	self.punchangle_x = -2;
	temp = random (2);
	self.punchangle_z = -temp;
	
	if(self.weaponmodel == "models/v_glock.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/pm/glock.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*36 + v_right*5, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*35 - v_right * (-11), dir);
	}
	else 
	{
		sound (self,CHAN_WEAPON,"weapons/pm/pm.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*25 + v_right*10, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -9 + v_forward*22 - v_right * (-11), dir);
	}
};





/************************ REALOADING PM ПЕРЕЗАРЯДКА ПМ *************************/

void () player_ApsReload = [ 1.000, player_ApsReload2 ]
{
	self.weaponframe = 50;
	sound(self,CHAN_WEAPON,"weapons/pm/pm_noammo.wav",TRUE,ATTN_NORM);
	self.nextthink = time + 0.035;
	self.reload = 1;
	self.ShootsFired =  self.ShootsFired+1;
};

void () player_ApsReload2 = [ 1.000, player_ApsReload2 ]
{
	
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.1;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.035;
	
	
	if(self.weaponframe == 70) sound(self,CHAN_WEAPON,"weapons/pm/pm_clipout.wav",1,ATTN_NORM);
	if(self.weaponframe == 87) sound(self,CHAN_WEAPON,"weapons/pm/pm_clipin.wav",1,ATTN_NORM);
	if(self.weaponframe == 101) sound(self,CHAN_WEAPON,"weapons/pm/pm_slideback.wav",1,ATTN_NORM);
	if(self.weaponframe == 118)
	{
		if(self.ammo_9x18 >= 20)
		{
			self.ammo_9x18 = (self.ammo_9x18 - (20 -self.PMclip));
			self.PMclip = 20;
		}
		else 
		{
			self.PMclip = self.ammo_9x18;
			self.ammo_9x18 = 0;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};

/************************** FIRE PM ***********************************************/

void () player_ApsAttack = [ 1.000, player_ApsAttack2 ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.weaponframe = 24;
	self.nextthink = time + 0.01;
	W_FirePM ();
	self.ShootsFired = self.ShootsFired + 1;
};

void () player_ApsAttack2 = [ 1.000, player_ApsAttack2 ]
{
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.2;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.01;
	if(self.weaponframe >= 50)
	{
		//self.ShootsFired = 0;
		self.think = player_run;
		self.reload = 0;
	}
};
	
	
	/************************** SWITCH PM ***********************************************/
	
void () player_ApsSwitch = [ 1.000, player_ApsSwitch2 ]
{
	self.weaponframe = 11;
	self.nextthink = time + 0.05;
	self.reload = 1;
};
	
void () player_ApsSwitch2 = [ 1.000, player_ApsSwitch2 ]
{
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.4;
	}
	
	self.weaponframe = self.weaponframe - 1;
	self.nextthink = time + 0.05;
	if(self.weaponframe == 1)
	{
		W_SetCurrentAmmo ();
		self.think = player_run;	//player_change_gun;
		self.reload = 0;
	}
};
	
 	