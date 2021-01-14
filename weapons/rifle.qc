/********************AKM SEQUENCE**************/

void (float damage, vector dir) rifleTraceAttack = 
{
   local vector vel;
   local vector org;
   local vector meatdir;
   local float particle_color;

   vel = normalize (((dir + (v_up * crandom ())) + (v_right * crandom ())));
   vel = (vel + (FL_SWIM * trace_plane_normal));
   vel = (vel * 200);
   org = (trace_endpos - (dir * MOVETYPE_STEP));
   
	if (trace_ent.takedamage) 
	{
		if(DetectObject(damage, org, dir)) return;
		damage = DetectHitbox(damage);
		
		particle_color = random ();
		meatdir_x = (random() * 300 + dir_x);
		meatdir_y = (random() * 300 + dir_y);
		meatdir_z = (random() * 300 + dir_z);
		makevectors (self.v_angle);
		  
		if(trace_ent.health> 1)
		{
			if (damage > 20) Shoot_Blood (org,meatdir);
			else SpawnBlood (org, vel * 0.2, damage * 60); 
		}
		if ((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) && (trace_ent.duck != 1))
		{
			trace_ent.flags = trace_ent.flags - FL_ONGROUND;
			trace_ent.velocity = (v_forward * 200);
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
	}
};

void() W_FireRifle = 
{
	local vector dir;
	local vector src;
	local float SpreadX, SpreadY;

	if (self.rifleClip <= 0)
	{
		self.rifleClip = 0;
		sound(self, CHAN_WEAPON, "weapons/noammo.wav", 1, ATTN_NORM);
		return;
	}

	self.rifleClip = self.rifleClip - 1;
	makevectors (self.angles);
	
	if (self.ShootsFired == 0) self.punchangle_x = (random(2,3));
	else if (self.ShootsFired == 1) self.punchangle_x = (random(3,4));
	else if (self.ShootsFired >= 2) self.punchangle_x = (random(5,6));
	self.punchangle_z = (random(-1,1));
	
	dir = aim (self, 1000);
	makevectors (self.v_angle);
	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800)); //0.800
	if(self.duck) src_z = (self.absmin_z + self.size_z);
	src_y = (self.absmin_y + (self.size_y * 0.5)); //0.400
	ClearMultiDamage ();
	
	if (self.duck == 0) 
	{
		SpreadX = random (-100,100);
		SpreadY = random (-100,100);
	}
	else
	{
		SpreadX = random (-80,80);
		SpreadY = random (-80,80);
	}

	if (self.ShootsFired == 0) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.05)) - (v_up * (SpreadY * 0.05)), FALSE, self);
	else if (self.ShootsFired == 1) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.333)) - (v_up * (SpreadY*0.333)), FALSE, self);
	else if (self.ShootsFired == 2) traceline (src, (src + (v_forward * IT_545x39)) - (v_right * (SpreadX * 0.666)) - (v_up * (SpreadY * 0.666)), FALSE, self);
	else traceline (src, (src + (v_forward * IT_545x39)) - (v_right * SpreadX) - (v_up * SpreadY), FALSE, self);

	if  (vlen(trace_endpos - self.origin) < 400) rifleTraceAttack (35, dir);
	else rifleTraceAttack (30,dir);

	ApplyMultiDamage ();
	
	if(self.weaponmodel == "models/v_m4.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/rifle/m4.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*20 + v_right*2, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*24 - v_right * -5, dir);
	}
	else
	{
		sound (self,CHAN_WEAPON,"weapons/rifle/shot.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*20 + v_right*2, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*24 - v_right * -5, dir);
	}
};


/************************* AKM RELOADING ПЕРЕЗАРЯДКА АКМ *****************************/
void() playerRifleReload = [ 0, playerRifleReload2 ] 
{
	playerAnim();
	self.weaponframe = 37;
	self.nextthink = time + 0.03;
	self.reload = 1;
};

void() playerRifleReload2 = [ 0, playerRifleReload2 ] 
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.03;
	self.reload = 1;
	if (self.weaponframe == 53) sound(self, CHAN_WEAPON, "weapons/rifle/clipout.wav", 0.7, ATTN_NORM);
	if (self.weaponframe == 97) sound(self, CHAN_WEAPON, "weapons/rifle/clipin.wav", 0.7, ATTN_NORM);
	if (self.weaponframe == 117)
	{
		if(self.ammoRifle >= CLIP_RIFLE)
		{
			self.ammoRifle = self.ammoRifle - (CLIP_RIFLE - self.rifleClip);
			self.rifleClip = CLIP_RIFLE;
		}
		else
		{
			self.rifleClip = self.ammoRifle;
			self.ammoRifle = 0;
		}
		W_SetCurrentAmmo();
		self.think = player_run;
	}
};


void() playerRifleAttack = [ 0, playerRifleAttack2 ] 
{
	playerAnim();
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.weaponframe = 31;
	self.nextthink = time + 0.02;
	W_FireRifle ();
	self.ShootsFired = self.ShootsFired + 1;
};

void() playerRifleAttack2 = [0, playerRifleAttack2 ]
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.02;
	if(self.weaponframe >= 36)
	{
		//self.ShootsFired = 0;
		self.think = player_run;//player_change_gun;
	}
};

///////////////// AKM WEAPON CHANGE ///////////////////


void() playerRifleSwitch = [ 0, playerRifleSwitch2 ]
{
	self.weaponframe = 1;
	self.nextthink = time + 0.025;
	self.reload = 1;
};

void() playerRifleSwitch2 = [ 0, playerRifleSwitch2 ]
{
	playerAnim();
	
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	self.currentammo =  self.ammoRifle;
	if(self.weaponframe == 30)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};