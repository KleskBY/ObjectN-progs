
void() W_FirePM = 
{	
	self.pistolClip = self.pistolClip - 1;
	self.punchangle_x = -2;
	self.punchangle_z = -random (2);
	fireBullet('40 35 0', IT_9x18 * 2, 25);
	
	if(self.weaponmodel == "models/v_colt.md3") 
	{
		sound (self,CHAN_WEAPON,"weapons/pistol/glock.wav", 1, ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*36 + v_right*5, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*35 - v_right * (-11));
	}
	else 
	{
		sound (self,CHAN_WEAPON,"weapons/pistol/pm.wav", 1, ATTN_NORM);
		pointparticles(particleeffectnum("supernailgun_muzzleflash"), self.origin + self.view_ofs + v_up * -5 + v_forward*25 + v_right*10, self.velocity*50, 1);
		eject_shell (self.origin + self.view_ofs + v_up * -9 + v_forward*22 - v_right * (-11));
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
	self.nextthink = time + 0.015;
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
	