
void() W_FireShotgun =
{
	self.shotgunClip = self.shotgunClip - 1;
	self.punchangle_x = random (2,6);
	self.punchangle_z = -2;
	local float i;
	i = 16;
	while (i > 0)
	{
		fireBullet('120 120 0', IT_9x18 * 2, 8);
		i = i -1;
	}
	sound(self,CHAN_WEAPON,"weapons/shotgun/shot.wav", 1, ATTN_NORM);
	//makevectors(self.v_angle);     
	pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -2.6 + v_forward * 26 + v_right*3.7, self.velocity*50, 1);
	eject_shell (self.origin + self.view_ofs + v_up * -8 + v_forward*22 - v_right * -8);

};

void() playerShotgunAttack = [1, playerShotgunAttack2] 
{
	local vector dir;
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.weaponframe = 46;
	self.nextthink = time + 0.03;
	self.punchangle_x = -2;
	self.punchangle_z = 2;
	W_FireShotgun ();

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
	playerAnim();
	self.weaponframe = 1;
	self.nextthink = time + 0.02;
	self.reload = 1;
	
};

void() player_TozSwitch2 = [ 1, player_TozSwitch2 ]
{
	playerAnim();
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


