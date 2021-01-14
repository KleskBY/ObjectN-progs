
/******************************************/
/*       Barrett Sniper Rifle             */
/******************************************/

void(vector org, vector dir) ShootSniper =
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

void (float damage, vector dir) sniperTraceAttack = 
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
		meatdir_x = ((random () * 300) + dir_x);
		meatdir_y = ((random () * 300) + dir_y);
		meatdir_z = ((random () * 300) + dir_z);
		makevectors (self.v_angle);
		ShootSniper (trace_ent.origin,v_forward*3000);
		
		//      trace_ent.flags = (trace_ent.flags - FL_ONGROUND);
		if (trace_ent.flags < 0) trace_ent.flags = trace_ent.flags + FL_ONGROUND; 
		if (particle_color <= 0.8) 
		{
			//     Shoot_Blood (org,meatdir);
			meatdir_y = meatdir_y * (-1.3);
			meatdir_z = meatdir_z * (0.8);
			SpawnBlood (org,(vel * 0.200),(damage * 10));
			//       Shoot_Blood (org,meatdir);
		}
		
		if ((trace_ent.health <= damage) && (trace_ent.movetype != MOVETYPE_PUSH) && (trace_ent.duck != 1))
		{
			trace_ent.flags = trace_ent.flags - FL_ONGROUND;
			trace_ent.velocity = (v_forward * 230);
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
	}
	if(self.zoomlevel > 0) pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_forward*20, self.velocity*50, 1);
	else pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_right * 2 + v_forward * 20 +v_up * -3.5, self.velocity*50, 1);
};

void() W_FireSniper = 
{
	local float SpreadX,SpreadY;
	local vector dir;
	local vector src;
	local float r;

	r = random ();
	self.sniperClip = self.sniperClip - 1;
	makevectors (self.angles);
	self.punchangle_x = random(4, 8);
	self.punchangle_z = random(3, 6);
	dir = aim (self,1000);
	makevectors (self.v_angle);
	src = (self.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.absmin_z + (self.size_z * 0.800)); //0.800
	if(self.duck) src_z = (self.absmin_z + self.size_z);
	src_y = (self.absmin_y + (self.size_y * 0.5)); //0.400
	ClearMultiDamage ();
	
	SpreadX = random (-200, 200);
	SpreadY = random (-200, 200);
	
	//traceline (src, (src + (v_forward * IT_762x54)) - (v_right * (SpreadX * 0.02)) - (v_up * (SpreadY * 0.02)), FALSE, self);
	if (self.zoomlevel != 0 || clienttype(self) == CLIENTTYPE_BOT /* && vlen(self.velocity) < 50*/) traceline (src, (src + (v_forward * IT_762x54 * 2)) - (v_right * (SpreadX * 0.1)) - (v_up * (SpreadY * 0.05)), FALSE, self);
	else traceline (src, (src + (v_forward * IT_762x54 * 2)) - (v_right * (SpreadX)) - (v_up * (SpreadY)), FALSE, self);

	if (vlen(trace_endpos - self.origin) < 250) sniperTraceAttack(90,dir);
	else sniperTraceAttack (80,dir);
	ApplyMultiDamage ();
};

void() playerSniperAttack = [1, playerSniperAttack2]
{
	playerAnim();
	self.nextthink = time + 0.022;
	self.weaponframe = 31;
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound(self,CHAN_WEAPON,"weapons/sniper/shot.wav",1,ATTN_NORM);
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
		else if (self.weaponframe == 63) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward*28 - v_right * (-6), dir);
		else if (self.weaponframe == 66) sound(self,CHAN_WEAPON,"weapons/sniper/boltrelease.wav",0.4,ATTN_NORM);
	}
	else if (self.weaponframe == 32) eject_shell (self.origin + self.view_ofs + v_up * -15 + v_forward*28 - v_right * (-6), dir);
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
		if ((self.ammoSniper >= 1) && (self.ammoSniper <= CLIP_SNIPER))
		{
			self.sniperClip = self.ammoSniper; 
			self.ammoSniper = 0;
		}
		else
		{
			self.ammoSniper = (self.ammoSniper - (CLIP_SNIPER - self.sniperClip));
			self.sniperClip = CLIP_SNIPER;
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