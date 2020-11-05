/********************AKM SEQUENCE**************/

void (float damage, vector dir) AKM_TraceAttack = {

   local vector vel;
   local vector org;
   local vector meatdir;
   local float particle_color;

   vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
   vel = (vel + (FL_SWIM * trace_plane_normal));
   vel = (vel * 200.000);
   org = (trace_endpos - (dir * MOVETYPE_STEP));
   
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
		
		
		if (trace_ent.absmax_z - trace_endpos_z <= 13) //headshot
		{
			sound (trace_ent, CHAN_WEAPON, "weapons/hitsound.wav", 1, ATTN_NORM);
			damage = rint(damage * 2);
			trace_ent.headshot = 1;
		}
		else if (((trace_ent.absmax_z - trace_endpos_z) > 26) && ((trace_ent.absmax_z - trace_endpos_z) < 35))	//legshot
		{
			trace_ent.headshot = 0;
			damage = rint(damage * 0.5);
		}
		else trace_ent.headshot = -1;
   
		sound(trace_ent,CHAN_BODY,"weapons/hitsound.wav",1,ATTN_NORM);
		particle_color = random ();
		meatdir_x = ((random () * 300.000) + dir_x);
		meatdir_y = ((random () * 300.000) + dir_y);
		meatdir_z = ((random () * 300.000) + dir_z);
		makevectors (self.v_angle);
		trace_ent.flags = (trace_ent.flags - FL_ONGROUND);
		  
		if(trace_ent.health> 1)
		{
			if (damage > 20) Shoot_Blood (org,meatdir);
			else SpawnBlood (org,(vel * 0.200),(damage * 60.000)); 
		}
		if ((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) && (trace_ent.duck != 1))
		{
			trace_ent.flags = trace_ent.flags - FL_ONGROUND;
			trace_ent.velocity = (v_forward * 200.000);
			trace_ent.velocity_z = 200 + (random() * 100);
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
	  
    /*  particle (org,'1.000 2.000 2.000',192.000,TE_WIZSPIKE);
      particle (org,'2.000 3.000 4.000',192.000,TE_WIZSPIKE);
      particle (org,'5.000 7.000 8.000',192.000,TE_WIZSPIKE);
      particle (org,'3.000 2.000 7.000',192.000,TE_WIZSPIKE);
      particle (org,'7.000 6.000 8.000',192.000,TE_WIZSPIKE);*/
	  
      // particle_color = random ();
      // if ((particle_color <= 0.250)) 
	  // {
         // sound (self,CHAN_AUTO,"weapons/ric1.wav",TRUE,ATTN_NORM);
      // }
      // if (((particle_color <= 0.500) && (particle_color > 0.250))) 
	  // {
         // sound (self,CHAN_AUTO,"weapons/ric2.wav",TRUE,ATTN_NORM);
      // }
   }
};

void () W_FireAKM = 
{
	local vector dir;
	local vector src;
	local float SpreadX, SpreadY;

	if (self.AKMclip <= 0)
	{
		self.AKMclip = 0;
		sound(self, CHAN_WEAPON, "weapons/pm/pm/pm_noammo.wav", 1, ATTN_NORM);
		return;
	}

	self.AKMclip = self.AKMclip - 1;
	makevectors (self.angles);
	
	if (self.ShootsFired == 0) self.punchangle_x = (random(2,3));
	else if (self.ShootsFired == 1) self.punchangle_x = (random(3,4));
	else if (self.ShootsFired >= 2) self.punchangle_x = (random(5,6));
	self.punchangle_z = (random(-1,1));
	
	dir = aim (self,1000.000);
	makevectors (self.v_angle);
	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800));
	src_y = (self.absmin_y + (self.size_y * 0.500));
	ClearMultiDamage ();
	
	if (self.duck == 0) 
	{
		SpreadX = random (-100,100);
		SpreadY = random (-100,100);
	}
	else
	{
		SpreadX = random (-50,50);
		SpreadY = random (-50,50);
	}

	if (self.ShootsFired == 0) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.05)) - (v_up * (SpreadY * 0.05)), FALSE, self);
	else if (self.ShootsFired == 1) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.333)) - (v_up * (SpreadY*0.333)), FALSE, self);
	else if (self.ShootsFired == 2) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.666)) - (v_up * (SpreadY * 0.666)), FALSE, self);
	else traceline (src, (src + (v_forward * IT_545x39)) - (v_right * SpreadX) - (v_up * SpreadY), FALSE, self);

	//sprint (self, ftos(self.ShootsFired));
	//sprint (self, "\n");

	if  (vlen(trace_endpos - self.origin) < 400) AKM_TraceAttack (35.000,dir);
	else AKM_TraceAttack (30,dir);

	ApplyMultiDamage ();
	
	if(self.weaponmodel == "models/v_m4.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/ak47/m4.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*20 + v_right*5, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*30 - v_right * -16, dir);
	}
	else
	{
		sound (self,CHAN_WEAPON,"weapons/ak47/ak47-1.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -6 + v_forward*10 + v_right*5, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*30 - v_right * (-6), dir);
	}
};


/************************* AKM RELOADING ПЕРЕЗАРЯДКА АКМ *****************************/
void () player_AK74Reload = [ 103.000, player_AK74Reload2 ] 
{
   self.weaponframe = 44;
   self.nextthink = time + 0.04;
   self.reload = 1;
};

void () player_AK74Reload2 = [ 103.000, player_AK74Reload2 ] 
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.04;
	self.reload = 1;
	if (self.weaponframe == 59)
	sound(self,CHAN_WEAPON,"weapons/ak47/ak47_clipout.wav",1,ATTN_NORM);
	if (self.weaponframe == 86)
	sound(self,CHAN_WEAPON,"weapons/ak47/ak47_clipin.wav",1,ATTN_NORM);
	if (self.weaponframe == 104)
	sound(self,CHAN_WEAPON,"weapons/ak47/ak47_boltpull.wav",1,ATTN_NORM);
	if (self.weaponframe == 120)
	{
		if(self.ammo545x39 >= 30)
		{
			self.ammo545x39 = self.ammo545x39 - (30-self.AKMclip);
			self.AKMclip = 30;
		}
		else
		{
			self.AKMclip = self.ammo545x39;
			self.ammo545x39 = 0;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};


void () player_AK74Attack = [ 103.000, player_AK74Attack2 ] 
{
   self.effects = self.effects | EF_MUZZLEFLASH;
   self.weaponframe = 24;
   self.nextthink = time + 0.04;
   W_FireAKM ();
   self.ShootsFired = self.ShootsFired +1;
};

void () player_AK74Attack2 = [103, player_AK74Attack2 ]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.04;
	if(self.weaponframe >= 35)
	{
		//self.ShootsFired = 0;
		self.think = player_run;//player_change_gun;
	}
};

///////////////// AKM WEAPON CHANGE ///////////////////


void () player_AK74Switch = [ 1.000, player_AK74Switch2 ]
{
	if(self.team == TEAM_USA) self.weaponmodel = "models/v_m4.md3";
	else self.weaponmodel = "models/v_ak74.md3";
	self.weaponframe = 4;
	self.nextthink = time + 0.05;
	self.reload = 1;
};

void () player_AK74Switch2 = [ 1.000, player_AK74Switch2 ]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.05;
	self.currentammo =  self.ammo545x39;
	if(self.weaponframe == 24)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
}; 