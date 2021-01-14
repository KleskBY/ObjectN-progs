/******************************************/
/*         		KNIFE                     */
/******************************************/

void() W_FireKnife =
{
	local	entity	head;
	local	vector	org;
	local	vector	source;
	local float damage;
	
	if(self.class == CLASS_ASSASSIN && deathmatch < 3) damage = 20;
	else damage = 16;
	
	local 	vector  meatdir;
	makevectors (self.v_angle);
	meatdir_x = ((random () * 300) );
	meatdir_y = ((random () * 300) );
	meatdir_z = ((random () * 300) );

	head = findradius(self.origin, 75);

	while (head)
	{
		if (head != self && head.takedamage)
		{
			if (CanDamage (head, self) && visible(head) && infront(head))
			{	
				if (head.flags & FL_MONSTER || head.classname == "player" || head.classname == "bot")
				{
					T_Damage (head, self, self, damage);
					Shoot_Blood (org,meatdir);
					Shoot_Blood (org,meatdir * 2);
					damage = 1;
					break;
				}
			}
		}
		head = head.chain;
	}
	
	{
		makevectors (self.v_angle);
		meatdir_x = ((random () * 300) );
		meatdir_y = ((random () * 300) );
		meatdir_z = ((random () * 300) );
		source = self.origin + '0 0 16';
		traceline (source, source + v_forward * 75, FALSE, self);
		if (trace_fraction == 1.0) return;

		org = trace_endpos - v_forward * 4;

		if (trace_ent.takedamage && trace_ent.classname != "worldspawn")
		{
			if(trace_ent.classname == "button")
			{
				trace_ent.axhitme = 1;
				T_Damage (trace_ent, self, self, damage);
				sound(trace_ent, CHAN_WEAPON,"weapons/knife/hit.wav", 1, ATTN_NORM);
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
				meatdir_x = ((random () * 300) + source_x);
				meatdir_y = ((random () * 300) + source_y);
				meatdir_z = ((random () * 300) + source_z);
				shootGib (org,meatdir,trace_ent.sounds);
				meatdir_x = ((random () * 300) + source_x);
				meatdir_y = ((random () * 300) + source_y);
				meatdir_z = ((random () * 300) + source_z);
				shootGib (org,meatdir,trace_ent.sounds);
				meatdir_x = ((random () * 300) + source_x);
				meatdir_y = ((random () * 300) + source_y);
				meatdir_z = ((random () * 300) + source_z);
				shootGib (org,meatdir,trace_ent.sounds);
				trace_ent.axhitme = 1;
				T_Damage (trace_ent, self, self, damage);
				sound(trace_ent, CHAN_WEAPON,"weapons/knife/hit.wav", 1, ATTN_NORM);
				return;
			}
			
			damage = DetectHitbox(damage);
			
			trace_ent.axhitme = 1;
			Shoot_Blood (org,meatdir);
			Shoot_Blood (org,meatdir * 2);
			SpawnBlood (org,'0 0 0',400);
			T_Damage (trace_ent, self, self, damage);
			sound(self, CHAN_WEAPON,"weapons/knife/hit.wav", 1, ATTN_NORM);
		}
		else // hit wall
		{	
			sound(self, CHAN_WEAPON,"weapons/knife/miss.wav", 1, ATTN_NORM);
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST, org_x);
			WriteCoord (MSG_BROADCAST, org_y);
			WriteCoord (MSG_BROADCAST, org_z);
		}
	}
}

//////////////////// KNIFE ATTACK ////////////////

void() playerKnifeAttack = [1, playerKnifeAttack2]
{
	self.weaponframe = 35;
	self.attack_finished = self.attack_finished + 0.01;
	self.nextthink = time + 0.01;
};

void() playerKnifeAttack2 = [2, playerKnifeAttack2]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.01;
	self.attack_finished = self.attack_finished + 0.01;


	if(self.weaponframe >= 50 && self.weaponframe < 55)
	{
	   if(self.weaponframe == 50) 
	   {
		   self.frame = 3;
		   if(random()) sound(self,CHAN_WEAPON,"weapons/knife/whoosh1.wav", 0.5, ATTN_NORM);
		   else sound(self,CHAN_WEAPON,"weapons/knife/whoosh2.wav", 0.5, ATTN_NORM);
	   }
	   W_FireKnife();
	}
	if(self.weaponframe >= 89) self.think = player_run;
};

void() playerKnifeAttackB = [1, playerKnifeAttackB2]
{
   self.weaponframe = 90;
   self.nextthink = time + 0.01;
   self.attack_finished = self.attack_finished + 0.01;
};

void() playerKnifeAttackB2 = [2, playerKnifeAttackB2]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.01;
	self.attack_finished = self.attack_finished + 0.01;

	if(self.weaponframe >= 101 && self.weaponframe < 107)
	{
	   if(self.weaponframe == 101) 
	   {
		   self.frame = 3;
		   if(random()) sound(self,CHAN_WEAPON,"weapons/knife/whoosh1.wav", 0.8, ATTN_NORM);
		   else sound(self,CHAN_WEAPON,"weapons/knife/whoosh2.wav", 0.8, ATTN_NORM);
	   }
	   W_FireKnife();
	}
	if(self.weaponframe >= 124) self.think = player_run;
};

///////////////// KNIFE WEAPON CHANGE ///////////////////

void() playerKnifeSwitch = [ 1, playerKnifeSwitch2 ]
{
	self.weaponframe = 1;
	self.nextthink = time + 0.025;
	self.reload = 1;
};

void() playerKnifeSwitch2 = [ 1, playerKnifeSwitch2 ]
{
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	
	if(self.weaponframe == 35)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};


