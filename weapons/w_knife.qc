/******************************************/
/*         		KNIFE                     */
/******************************************/

void() W_FireKnife =
{
	local	vector	source;
	local	vector	org;
	local vector      meatdir;
	local float damage;
	local entity nearest;
	local entity e;
	damage = 50;
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		if(e != self)
		{
			if (!nearest) nearest = e;
			else if(vlen(e.origin - self.origin) < vlen(nearest.origin - self.origin)) nearest = e;
		}
	}
	if(nearest && vlen(nearest.origin - self.origin) < 80)
	{
		T_Damage (nearest, self, self, damage);
		trace_ent.headshot = 0;
	}
	else
	{
		damage = 16;

		makevectors (self.v_angle);
		meatdir_x = ((random () * 300.000) );
		meatdir_y = ((random () * 300.000) );
		meatdir_z = ((random () * 300.000) );
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward*64, FALSE, self);
		if (trace_fraction == 1.0) return;

		org = trace_endpos - v_forward*4;

		if (trace_ent.takedamage)
		{
			if(trace_ent.classname == "button")
			{
				trace_ent.axhitme = 1;
				T_Damage (trace_ent, self, self, 15);
				sound(trace_ent, CHAN_AUTO,"weapons/knife/knife_hit1.wav",TRUE,ATTN_NORM);
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
				meatdir_x = ((random () * 300.000) + source_x);
				meatdir_y = ((random () * 300.000) + source_y);
				meatdir_z = ((random () * 300.000) + source_z);
				ShootGlass (org,meatdir);
				meatdir_x = ((random () * 300.000) + source_x);
				meatdir_y = ((random () * 300.000) + source_y);
				meatdir_z = ((random () * 300.000) + source_z);
				ShootGlass (org,meatdir);
				meatdir_x = ((random () * 300.000) + source_x);
				meatdir_y = ((random () * 300.000) + source_y);
				meatdir_z = ((random () * 300.000) + source_z);
				ShootGlass (org,meatdir);
				trace_ent.axhitme = 1;
				T_Damage (trace_ent, self, self, 15);
				sound(trace_ent, CHAN_AUTO,"weapons/knife/knife_hit1.wav",TRUE,ATTN_NORM);
				return;
			}
			
			DetectHitbox(damage);
			
			if(self.class == CLASS_ASSASSIN) damage = damage *2;
			
			trace_ent.axhitme = 1;
			Shoot_Blood (org,meatdir);
			Shoot_Blood (org,meatdir * 2);
			SpawnBlood (org,'0 0 0',400.000);
			T_Damage (trace_ent, self, self, damage);
			sound(trace_ent, CHAN_AUTO,"weapons/knife/knife_hit1.wav",TRUE,ATTN_NORM);
		}
		else // hit wall
		{	
			sound (self, CHAN_WEAPON, "weapons/knife/knife_hit2.wav", 1, ATTN_NORM);
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST, org_x);
			WriteCoord (MSG_BROADCAST, org_y);
			WriteCoord (MSG_BROADCAST, org_z);
		}
	}
};

//////////////////// KNIFE ATTACK ////////////////

void () player_KnifeAttack = [$knifeattack1, knifea2]
{
	self.weaponframe = 35;
	self.attack_finished = self.attack_finished + 0.02;
	self.nextthink = time + 0.02;
};

void () knifea2 = [$knifeattack2, knifea2]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	self.attack_finished = self.attack_finished + 0.005;


	if(self.weaponframe >= 37 && self.weaponframe <41)
	{
		if(self.weaponframe == 37)
		{
			self.frame = $knifeattack3;
			sound(self,CHAN_WEAPON,"weapons/knife/knife_whoosh1.wav",TRUE,ATTN_NORM);
		}
		W_FireKnife();
	}
	if(self.weaponframe >= 60) self.think = player_run;
};

void () player_KnifeAttackb = [$knifeattack1, knifeb2]
{
   self.weaponframe = 61;
   self.nextthink = time + 0.025;
   self.attack_finished = self.attack_finished + 0.025;
};

void () knifeb2 = [$knifeattack2, knifeb2]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	self.attack_finished = self.attack_finished + 0.005;

	if(self.weaponframe >= 62 && self.weaponframe <67)
	{
	   if(self.weaponframe == 62) 
	   {
		   self.frame = $knifeattack3;
		   sound(self,CHAN_WEAPON,"weapons/knife/knife_whoosh1.wav",TRUE,ATTN_NORM);
	   }
	   W_FireKnife();
	}
	if(self.weaponframe >= 84) self.think = player_run;
};

///////////////// KNIFE WEAPON CHANGE ///////////////////

void () player_KnifeSwitch = [ 1.000, player_KnifeSwitch2 ]
{
	if (self.hgrenade != 1) self.weaponmodel = "models/v_knife.md3";
	else self.weaponmodel = "models/v_grenade.md3";
	self.weaponframe = 3;
	self.nextthink = time + 0.05;
	self.reload = 1;
	
};

void () player_KnifeSwitch2 = [ 1.000, player_KnifeSwitch2 ]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.05;
	
	if(self.weaponframe == 25)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};









