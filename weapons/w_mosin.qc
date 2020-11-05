
/******************************************/
/*       Barrett Sniper Rifle             */
/******************************************/

void(vector org, vector dir) Shoot_BARRETT =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_NOT;

	newmis.angles = vectoangles(dir);
	
	newmis.touch = SUB_Remove;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 0.5;
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	setorigin (newmis, org + '0 0 10');

	newmis.velocity = dir;
};

void (float damage, vector dir) BARRETT_TraceAttack = 
{
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

		particle_color = random ();
		meatdir_x = ((random () * 300.000) + dir_x);
		meatdir_y = ((random () * 300.000) + dir_y);
		meatdir_z = ((random () * 300.000) + dir_z);
		makevectors (self.v_angle);
		Shoot_BARRETT (trace_ent.origin,v_forward*3000);
		
		//      trace_ent.flags = (trace_ent.flags - FL_ONGROUND);
		if (trace_ent.flags < 0) trace_ent.flags = trace_ent.flags + FL_ONGROUND; 
		if (particle_color <= 0.8) 
		{
			//     Shoot_Blood (org,meatdir);
			meatdir_y = meatdir_y * (-1.3);
			meatdir_z = meatdir_z * (0.8);
			SpawnBlood (org,(vel * 0.200),(damage * 10.000));
			//       Shoot_Blood (org,meatdir);
		}
		
		if ((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) && (trace_ent.duck != 1))
		{
			trace_ent.flags = trace_ent.flags - FL_ONGROUND;
			trace_ent.velocity = (v_forward * 230.000);
			trace_ent.velocity_z = 270 + (random() * 80);
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
		particle_color = random ();
		
		if (particle_color <= 0.5) sound (self,CHAN_AUTO,"weapons/ric1.wav",TRUE,ATTN_NORM);
		if (particle_color > 0.5) sound (self,CHAN_AUTO,"weapons/ric2.wav",TRUE,ATTN_NORM);
	}
	if(self.zoomlevel > 0) pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_forward*20, self.velocity*50, 1);
	else pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_right * 5 + v_forward*50, self.velocity*50, 1);
};

void () W_FireBarrett = 
{
	local float SpreadX,SpreadY;
	local vector dir;
	local vector src;
	local float r;

	r = random ();
	self.psg1clip = self.psg1clip - 1;
	makevectors (self.angles);
	self.punchangle_x = random(0.5, 1) * -6;
	self.punchangle_z = random(0.5, 1) * -5;
	dir = aim (self,1000.000);
	makevectors (self.v_angle);
	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800));
	src_y = (self.absmin_y + (self.size_y * 0.500));
	ClearMultiDamage ();
	
	SpreadX = random (300);
	SpreadY = random (300);
	
	if (self.zoomlevel != 0) traceline (src, (src + (v_forward * IT_762x54)) - (v_right * (SpreadX * 0.05)) - (v_up * (SpreadY * 0.05)), FALSE, self);
	else traceline (src, (src + (v_forward * IT_762x54)) - (v_right * (SpreadX)) - (v_up * (SpreadY)), FALSE, self);

	if (vlen(trace_endpos - self.origin) < 250) BARRETT_TraceAttack(200.000,dir);
	else BARRETT_TraceAttack (120.000,dir);
	ApplyMultiDamage ();
};

void () player_MosinAttack = [1, player_MosinAttack2]
{
	self.weaponframe = 1;
	
	self.nextthink = time + 0.05;
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound(self,CHAN_WEAPON,"weapons/mosin/mosin-1.wav",1,ATTN_NORM);
	W_FireBarrett ();
};
void () player_MosinAttack2 = [2, player_MosinAttack2]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	local vector dir;
	self.weaponframe = self.weaponframe + 1;
	//if (self.weaponframe == 22) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_put.wav",0.4,ATTN_NORM);
	if (self.weaponframe == 28) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltback.wav",0.4,ATTN_NORM); 
	else if (self.weaponframe == 31) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward*28 - v_right * (-6), dir);
	else if (self.weaponframe == 35) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltrelease.wav",0.4,ATTN_NORM);
	else if (self.weaponframe == 57)
	{
		self.zoomlevel = 0;
		self.think = player_run;
	}
	self.nextthink = time + 0.04;
};

void () player_MosinAttackb = [1, player_MosinAttackb2]
{
	self.weaponframe = 216;
	
	self.nextthink = time + 0.05;
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound(self,CHAN_WEAPON,"weapons/mosin/mosin-1.wav",1,ATTN_NORM);
	W_FireBarrett ();
};
void () player_MosinAttackb3;
void () player_MosinAttackb2 = [2, player_MosinAttackb2]
{
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe >= 224)
	{
		self.think = player_MosinAttackb3;
	}
	self.nextthink = time + 0.01;
};
void () player_MosinAttackb4;
void () player_MosinAttackb3 = [2, player_MosinAttackb3]
{
	self.weaponframe = self.weaponframe - 1;
	if (self.weaponframe <= 216)
	{
		self.think = player_MosinAttackb4;
	}
	self.nextthink = time + 0.04;
};

void () player_MosinAttackb4 = [2, player_MosinAttackb4]
{
	self.nextthink = time + 0.025;  
	if(self.weaponframe == 200)
	{
		//self.zoomlevel = 0;
		self.weaponframe = 14;
		self.think = player_MosinAttack2;
		stuffcmd(self,"fov 90 \n");
	}
	else 
	{
		self.FOV = self.FOV + 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe - 1;
	}
}

void () player_MosinZoom = [1, player_MosinZoom2]
{
	self.FOV = 90;
	self.weaponframe = 200;
	self.attack_finished = time + 0.11;
	self.nextthink = time + 0.025;
	self.reload = 1;
};

void () player_MosinZoom2 = [2, player_MosinZoom2]
{ 
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.15;
	}

	self.nextthink = time + 0.025;  
	if(self.weaponframe == 216)
	{
		self.zoomlevel = 1;
		self.reload = 0;
	}
	else 
	{
		self.FOV = self.FOV - 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe + 1;
		self.reload = 1;
	}
};


void () player_MosinZoomOut = [2, player_MosinZoomOut2]
{
	self.weaponframe = 216;
	self.nextthink = time + 0.1;
	self.reload = 1;
};

void () player_MosinZoomOut2 = [2, player_MosinZoomOut2]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.15;
	}
	
	self.nextthink = time + 0.025;  
	if(self.weaponframe <= 200)
	{
		self.zoomlevel = 0;
		stuffcmd(self,"fov 90 \n");
		self.reload = 0;
		self.think = player_run;
	}
	else 
	{
		self.FOV = self.FOV + 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe - 1;
		self.reload = 1;
	}
};

void () player_MosinReload2;
void () player_MosinReload = [1, player_MosinReload]
{
	if(self.zoomlevel == 1) 
	{
		self.nextthink = time + 0.025;  
		if(self.weaponframe == 200)
		{
			self.zoomlevel = 0;
			stuffcmd(self,"fov 90 \n");
			self.weaponframe = 59;
			self.nextthink = time + 0.05;
			self.reload = 1;
			self.think = player_MosinReload2;
		}
		else 
		{
			self.FOV = self.FOV + 1;
			stuffcmd(self,"fov ");
			stuffcmd(self,ftos(self.FOV));
			stuffcmd(self,"\n");
			self.weaponframe = self.weaponframe - 1;
			self.reload = 1;
		}
	}
	else
	{
		self.weaponframe = 59;
		self.nextthink = time + 0.05;
		self.reload = 1;
		self.think = player_MosinReload2;
	}
};

void () player_MosinReload2 = [1, player_MosinReload2]
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
	//if (self.weaponframe == 71) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_put.wav",0.4,ATTN_NORM);
	if (self.weaponframe == 80) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltback.wav",0.4,ATTN_NORM); 
	if (self.weaponframe == 102) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_put.wav",0.4,ATTN_NORM);
	if (self.weaponframe == 116) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_clipin.wav",0.4,ATTN_NORM); 
	if (self.weaponframe == 155) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltrelease.wav",0.4,ATTN_NORM); 

	if(self.weaponframe >=175)
	{
		if ((self.ammo_762x54 >= 1) && (self.ammo_762x54 <= 5))
		{
			self.psg1clip = self.ammo_762x54; 
			self.ammo_762x54 = 0;
		}
		else
		{
			self.ammo_762x54 = (self.ammo_762x54 - (5 - self.psg1clip));
			self.psg1clip = 5;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};

//============================================================================

void () player_AwpAttack = [1, player_AwpAttack2]
{
	self.weaponframe = 1;
	
	self.nextthink = time + 0.05;
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound(self,CHAN_WEAPON,"weapons/mosin/awp.wav",1,ATTN_NORM);
	W_FireBarrett ();
};
void () player_AwpAttack2 = [2, player_AwpAttack2]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.5;
	}
	
	local vector dir;
	self.weaponframe = self.weaponframe + 1;
	//if (self.weaponframe == 22) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_put.wav",0.4,ATTN_NORM);
	if (self.weaponframe == 21) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltback.wav",0.4,ATTN_NORM); 
	else if (self.weaponframe == 28) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward*28 - v_right * (-6), dir);
	else if (self.weaponframe == 29) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_boltrelease.wav",0.4,ATTN_NORM);
	else if (self.weaponframe >= 42)
	{
		self.zoomlevel = 0;
		self.think = player_run;
	}
	self.nextthink = time + 0.055;
};


void () player_AwpAttackb = [1, player_AwpAttackb2]
{
	self.weaponframe = 178;
	
	self.nextthink = time + 0.05;
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound(self,CHAN_WEAPON,"weapons/mosin/awp.wav",1,ATTN_NORM);
	W_FireBarrett ();
};
void () player_AwpAttackb3;
void () player_AwpAttackb2 = [2, player_AwpAttackb2]
{
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe >= 182)
	{
		self.think = player_AwpAttackb3;
	}
	self.nextthink = time + 0.01;
};
void () player_AwpAttackb4;
void () player_AwpAttackb3 = [2, player_AwpAttackb3]
{
	self.weaponframe = self.weaponframe - 1;
	if (self.weaponframe <= 178) self.think = player_AwpAttackb4;
	self.nextthink = time + 0.04;
};

void () player_AwpAttackb4 = [2, player_AwpAttackb4]
{
	self.nextthink = time + 0.025;  
	if(self.weaponframe == 162)
	{
		self.weaponframe = 6;
		self.think = player_AwpAttack2;
		stuffcmd(self,"fov 90 \n");
	}
	else 
	{
		self.FOV = self.FOV + 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe - 1;
	}
}


void () player_AwpZoom = [1, player_AwpZoom2]
{
	self.FOV = 90;
	self.weaponframe = 161;
	self.attack_finished = time + 0.11;
	self.nextthink = time + 0.025;
	self.reload = 1;
};

void () player_AwpZoom2 = [2, player_AwpZoom2]
{ 
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.15;
	}

	self.nextthink = time + 0.025;  
	if(self.weaponframe == 177)
	{
		self.zoomlevel = 1;
		self.reload = 0;
	}
	else 
	{
		self.FOV = self.FOV - 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe + 1;
		self.reload = 1;
	}
};

void () player_AwpZoomOut = [2, player_AwpZoomOut2]
{
	self.weaponframe = 177;
	self.nextthink = time + 0.1;
	self.reload = 1;
};

void () player_AwpZoomOut2 = [2, player_AwpZoomOut2]
{
	footsteps();
	if (self.velocity_x && self.velocity_y)
	{
		if (self.walkframe >= 11) self.walkframe = 0;
		if(self.duck ==1) self.frame = $crouchrun1 + self.walkframe;
		else self.frame = $run1 + self.walkframe;
		self.walkframe = self.walkframe + 0.15;
	}
	
	self.nextthink = time + 0.025;  
	if(self.weaponframe <= 161)
	{
		self.zoomlevel = 0;
		stuffcmd(self,"fov 90 \n");
		self.reload = 0;
		self.think = player_run;
	}
	else 
	{
		self.FOV = self.FOV + 1;
		stuffcmd(self,"fov ");
		stuffcmd(self,ftos(self.FOV));
		stuffcmd(self,"\n");
		self.weaponframe = self.weaponframe - 1;
		self.reload = 1;
	}
};

void () player_AwpReload2;
void () player_AwpReload = [1, player_AwpReload]
{
	if(self.zoomlevel == 1) 
	{
		self.nextthink = time + 0.025;  
		if(self.weaponframe == 161)
		{
			self.zoomlevel = 0;
			stuffcmd(self,"fov 90 \n");
			self.weaponframe = 43;
			self.nextthink = time + 0.05;
			self.reload = 1;
			self.think = player_AwpReload2;
		}
		else 
		{
			self.FOV = self.FOV + 1;
			stuffcmd(self,"fov ");
			stuffcmd(self,ftos(self.FOV));
			stuffcmd(self,"\n");
			self.weaponframe = self.weaponframe - 1;
			self.reload = 1;
		}
	}
	else
	{
		self.weaponframe = 43;
		self.nextthink = time + 0.05;
		self.reload = 1;
		self.think = player_AwpReload2;
	}
};

void () player_AwpReload2 = [1, player_AwpReload2]
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
	self.nextthink = time + 0.052;
	if (self.weaponframe == 70) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_put.wav",0.4,ATTN_NORM);
	if (self.weaponframe == 100) sound(self,CHAN_WEAPON,"weapons/mosin/mosin_clipin.wav",0.4,ATTN_NORM); 

	if(self.weaponframe >=130)
	{
		if ((self.ammo_762x54 >= 1) && (self.ammo_762x54 <= 5))
		{
			self.psg1clip = self.ammo_762x54; 
			self.ammo_762x54 = 0;
		}
		else
		{
			self.ammo_762x54 = (self.ammo_762x54 - (5 - self.psg1clip));
			self.psg1clip = 5;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};
