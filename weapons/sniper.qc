
void() W_FireSniper = 
{
	self.sniperClip = self.sniperClip - 1;
	self.punchangle_x = random(-4, -8);
	self.punchangle_y = random(-1, -4);
	self.punchangle_z = random(3, 6);
	if (self.zoomlevel || clienttype(self) == CLIENTTYPE_BOT) fireBullet('8 8 0', IT_762x54, 90);
	else fireBullet('20 20 0', IT_762x54, 90);
	
	sound(self,CHAN_WEAPON,"weapons/sniper/shot.wav",1,ATTN_NORM);
	if(self.zoomlevel > 0) pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_forward*20, self.velocity*50, 1);
	else pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_right * 2 + v_forward * 20 +v_up * -3.5, self.velocity*50, 1);
};

void() playerSniperAttack = [1, playerSniperAttack2]
{
	playerAnim();
	self.nextthink = time + 0.022;
	self.weaponframe = 31;
	self.effects = self.effects | EF_MUZZLEFLASH;
	W_FireSniper ();
};
void() playerSniperAttack2 = [2, playerSniperAttack2]
{
	playerAnim();
	self.nextthink = time + 0.023;
	
	local vector dir;
	self.weaponframe = self.weaponframe + 1;

	if(self.team == TEAM_USA)
	{
		if (self.weaponframe == 56) sound(self,CHAN_WEAPON,"weapons/sniper/boltback.wav",0.4,ATTN_NORM); 
		else if (self.weaponframe == 63) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward * 28 - v_right * -6);
		else if (self.weaponframe == 66) sound(self,CHAN_WEAPON,"weapons/sniper/boltrelease.wav",0.4,ATTN_NORM);
	}
	else if (self.weaponframe == 32) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward * 28 - v_right * -6);
	if (self.weaponframe == 86) self.think = player_run;
};

void() playerSniperReload = [1, playerSniperReload2]
{
	self.zoomlevel = 0;
	self.weaponframe = 90;
	self.nextthink = time + 0.04;
	self.reload = 1;
	self.think = playerSniperReload2;
};

void() playerSniperReload2 = [1, playerSniperReload2]
{
	playerAnim();
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.05;
	if (self.weaponframe == 103) sound(self,CHAN_WEAPON,"weapons/sniper/boltback.wav",0.6,ATTN_NORM); 
	if (self.weaponframe == 130) sound(self,CHAN_WEAPON,"weapons/sniper/put.wav",0.6,ATTN_NORM);
	if (self.weaponframe == 155) sound(self,CHAN_WEAPON,"weapons/sniper/clipin.wav",0.6,ATTN_NORM); 
	if (self.weaponframe == 182) sound(self,CHAN_WEAPON,"weapons/sniper/boltrelease.wav",0.6,ATTN_NORM); 

	if(self.weaponframe >= 212)
	{
		if(self.ammoSniper >= CLIP_SNIPER)
		{
			self.ammoSniper = self.ammoSniper - (CLIP_SNIPER - self.sniperClip);
			self.sniperClip = CLIP_SNIPER;
		}
		else
		{
			self.sniperClip = self.ammoSniper;
			self.ammoSniper = 0;
		}

		W_SetCurrentAmmo();
		self.think = player_run;
	}
};

void() playerSniperSwitch = [1, playerSniperSwitch2]
{
	playerAnim();
	self.weaponframe = 1;
	self.nextthink = time + 0.025;
	self.reload = 1;
};

void() playerSniperSwitch2 = [1, playerSniperSwitch2]
{
	playerAnim();
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	self.currentammo =  self.ammoSniper;
	if(self.weaponframe == 30)
	{
		self.think = player_run;
		self.reload = 0;
	}
};