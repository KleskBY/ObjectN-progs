
void() W_FireRifle = 
{
	self.rifleClip = self.rifleClip - 1;
	if (self.ShootsFired == 0) self.punchangle_x = (random(2,3));
	else if (self.ShootsFired == 1) self.punchangle_x = (random(3,4));
	else if (self.ShootsFired >= 2) self.punchangle_x = (random(5,6));
	self.punchangle_z = (random(-1,1));
	
	if (self.duck)
	{
		if (self.ShootsFired == 0) fireBullet('8 8 0', IT_545x39, 35);
		else if (self.ShootsFired == 1) fireBullet('30 30 0', IT_545x39, 35);
		else if (self.ShootsFired == 2) fireBullet('50 50 0', IT_545x39, 35);
		else fireBullet('80 80 0', IT_545x39, 35);
	}		
	else
	{
		if (self.ShootsFired == 0) fireBullet('10 10 0', IT_545x39, 35);
		else if (self.ShootsFired == 1) fireBullet('35 35 0', IT_545x39, 35);
		else if (self.ShootsFired == 2) fireBullet('60 60 0', IT_545x39, 35);
		else fireBullet('100 100 0', IT_545x39, 35);
	}
	
	if(self.weaponmodel == "models/v_m4.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/rifle/m4.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*20 + v_right*2, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*24 - v_right * -5);
	}
	else
	{
		sound (self,CHAN_WEAPON,"weapons/rifle/shot.wav",TRUE,ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*20 + v_right*2, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -12 + v_forward*24 - v_right * -5);
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