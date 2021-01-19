
/******************************************/
/*         Hand Grenades                  */
/******************************************/

void() explode1 = [0, explode2] 
{
    self.nextthink = time + 0.02;
	sound (self, CHAN_WEAPON, "weapons/grenade/explosion.wav", 1, ATTN_NORM);
};
void()	explode2	=	[1,		explode3] {self.nextthink = time + 0.02;};
void()	explode3	=	[2,		explode4] {self.nextthink = time + 0.02;};
void()	explode4	=	[3,		explode5] {self.nextthink = time + 0.02;};
void()	explode5	=	[4,		explode6] {self.nextthink = time + 0.02;};
void()	explode6	=	[5,		explode7] {self.nextthink = time + 0.02;};
void()	explode7	=	[6,		explode8] {self.nextthink = time + 0.02;};
void()	explode8	=	[7,		explode9] {self.nextthink = time + 0.02;};
void()	explode9	=	[8,		explode10] {self.nextthink = time + 0.03;};
void()	explode10   =   [9,		explode11] {self.nextthink = time + 0.03;};
void()	explode11	=	[10,	explode12] {self.nextthink = time + 0.03;};
void()	explode12	=	[11,	explode13] {self.nextthink = time + 0.03;};
void()	explode13	=	[12,	explode14] {self.nextthink = time + 0.03;};
void()	explode14	=	[13,	explode15] {self.nextthink = time + 0.03;};
void()	explode15	=	[14,	explode16] {self.nextthink = time + 0.03;};
void()	explode16	=	[15,	explode17] {self.nextthink = time + 0.03;};
void()	explode17	=	[16,	SUB_Remove] {self.nextthink = time + 0.03;};


void(entity inflictor, entity attacker, float damage, entity ignore) T_GrenadeRadiusDamage =
{
	local	float 	points;
	local	entity	head;
	local	vector	org;
	local   float temp;
	local   float grange;

	head = findradius(inflictor.origin, damage+200);

	while (head)
	{
		if (head.takedamage)
		{
			org = head.origin + (head.mins + head.maxs)*0.5;
			points = 0.25*vlen (inflictor.origin - org);
			if (points < 0) points = 0;
			points = damage - points;
			if (head == attacker) points = points * 0.5;
			if (points > 0)
			{
				if (CanDamage (head, inflictor))
				{	
					T_Damage (head, inflictor, attacker, points);
					if(head.takedamage)
					//if (head.flags & FL_MONSTER || head.classname == "player" || head.classname == "player" || head.classname == "bot")
					{
						head.flags = head.flags - FL_ONGROUND;
						temp = vlen(org - inflictor.origin);
						if (temp < 60 && temp >= 0) grange = 15;
						if (temp < 120 && temp >= 60) grange = 9;
						if (temp < 180 && temp >= 120) grange = 5;
						if (temp < 240 && temp >= 180) grange = 3;
						if (temp >= 240) grange = 1.5;
						head.velocity = (org - inflictor.origin) * grange;
						Shoot_Blood(org,head.velocity * 100);
						head.velocity_z = 150 + (grange * 20);
					}
				}
			}
		}
		head = head.chain;
	}
};

void() shrapnel_touch =
{
	if (other == self.owner) return;
	if (other.solid == SOLID_TRIGGER) return;	// trigger field, do nothing
	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}	

	if (other.takedamage) // hit something that bleeds
	{
        makevectors(self.v_angle);
		Shoot_Blood (other.origin,v_forward * 2000);
        T_Damage (other, self, self, 20);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		
		if (self.classname == "wizspike") WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
		else if (self.classname == "knightspike") WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
		else WriteByte (MSG_BROADCAST, TE_SPIKE);
		
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	remove(self);

};

void(vector org, vector dir) shoot_shrapnel =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_BOUNCE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);

	//newmis.touch = spike_touch;
	newmis.touch = shrapnel_touch;
    newmis.classname = "shrapnel";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 1.5;
	setmodel (newmis, "models/shrap.md3");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);

	newmis.velocity = dir * 3;
};

void() BecomeGrenedeExplosion =
{
    local vector shrapdir;
	local float i;

	self.movetype = MOVETYPE_NONE;
    self.angles = '0 0 0';
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "models/explode.md3");
	self.solid = SOLID_NOT;

	for (i = 0; i < 17; i = i+1)	
	{
      shrapdir_x = 0 - (random(-1,1) * 200);
      shrapdir_y = 0 - (random(-1,1) * 200);
      shrapdir_z = (random(-1,1) * 200);
      shoot_shrapnel(self.origin , shrapdir);
	}
	sound (self, CHAN_WEAPON, "weapons/grenade/explosion.wav", 1, ATTN_NORM);
	remove(self);
	//sound(self,CHAN_WEAPON,"weapons/explode1.wav",TRUE,ATTN_NORM);
	//self.think = SUB_Remove;
	//self.nextthink = time + 0.1;
	//explode1();
};

void() MyGrenadeExplode =
{
	T_GrenadeRadiusDamage (self, self.owner, 100, world);
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
		//te_explosionrgb(self.origin, '1. 1 0');

	BecomeGrenedeExplosion ();
};



void() HandGrenadeTouch =
{
	local vector meatdir;

	if (other == self.owner) return;		// don't explode on owner
	if(other.classname ==  "breakable")
	{
		T_Damage (other, self, self, 2);
		pointparticles(particleeffectnum("nailgun_muzzleflash"), self.origin, self.velocity*50, 1);
		meatdir_x = ((random () * 300) +  self.origin_x);
		meatdir_y = ((random () * 300) +  self.origin_y);
		meatdir_z = ((random () * 300) +  self.origin_z);
		shootGib (self.origin,meatdir,other.sounds);
		meatdir_x = ((random () * 300) +  self.origin_x);
		meatdir_y = ((random () * 300) +  self.origin_y);
		meatdir_z = ((random () * 300) +  self.origin_z);
		shootGib (self.origin,meatdir,other.sounds);
		meatdir_x = ((random () * 300) +  self.origin_x);
		meatdir_y = ((random () * 300) +  self.origin_y);
		meatdir_z = ((random () * 300) +  self.origin_z);
		shootGib (self.origin,meatdir,other.sounds);
	}
	// if (other.takedamage == DAMAGE_AIM)
	// {
		// MyGrenadeExplode();
		// self.velocity = self.velocity * 0.3;
		// return;
	// }
	sound (self, CHAN_WEAPON, "weapons/grenade/hit.wav", 1, ATTN_NORM);
	if (self.velocity == '0 0 0') self.avelocity = '0 0 0';
};

void() W_FireHandGrenade =
{
	local entity missile;
	self.punchangle_x = -2;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
// set missile speed

	makevectors (self.v_angle);

	if (self.v_angle_x) missile.velocity = v_forward * (25 * self.grenadetime) + v_up * 100 + (2*(random() - 0.5)) * v_right*10 + (2*(random() - 0.5)) *v_up*30;
	else
	{
		missile.velocity = aim(self, 10000);
        missile.velocity = missile.velocity * (20 * self.grenadetime);
		missile.velocity_z = 30;
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);

	missile.touch = HandGrenadeTouch;

	missile.nextthink = time + 3;
	missile.think = MyGrenadeExplode;
	missile.search_time = time + 3.0;
	missile.nextthink   = time + 1.5; //Delay
  
    setmodel (missile, "models/w_grenade.md3");
	setsize (missile, '0 0 0', '1 1 1');
	setorigin (missile, self.origin - (v_right * -6) + (v_up * 11));
	if(self.currentammo == 0) CycleWeaponReverseCommand();
	self.grenadetime = 0;
};

void() player_HEAttack = [103, hgrenade2]
{
	self.grenadetime = 10;
	self.weaponframe = 36;
	self.nextthink = time + 0.025;
};
void() hgrenade3;
void() hgrenade2 = [103.0, hgrenade2]
{
	playerAnim();
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.025;
	if (self.weaponframe == 49)sound(self,CHAN_WEAPON,"weapons/grenade/pinpull.wav",1,ATTN_NORM);
	if (self.weaponframe >= 60) self.think = hgrenade3;
};

void() hgrenade4;

void() hgrenade3 = [1, hgrenade3] 
{
	playerAnim();
	self.nextthink = time + 0.02;
	self.attack_finished = time + 0.03;
		

	if (self.button0)
	{
		if (self.grenadetime <= 40)
		{
			self.grenadetime = self.grenadetime + 0.3; 
			// local string temp;
			// local float power;
			// power = ((self.grenadetime-10) / 30) *100;
			// temp = ftos(power);
			// temp = substring(temp,0,strstrofs(temp, ".", 0));
			// temp = strcat(temp, "%");
			// centerprint (self, temp);
		}
	}
	else self.think = hgrenade4;
};

void() hgrenade4 = [2, hgrenade4]
{
	playerAnim();
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.02;
	
	if (self.weaponframe == 70) W_FireHandGrenade ();
	if (self.weaponframe >= 82) self.think = player_run; //self.think = SUB_Remove;	
};



void() player_HESwitch = [ 1, player_HESwitch2 ]
{
	self.weaponframe = 1;
	self.nextthink = time + 0.015;
	self.reload = 1;
};

void() player_HESwitch2 = [ 1, player_HESwitch2 ]
{
	playerAnim();
	
	self.weaponframe = self.weaponframe + 1;
	self.nextthink = time + 0.015;
	self.currentammo =  self.ammoGrenades;
	if(self.weaponframe >= 35)
	{
		self.think = player_run;//player_change_gun;
		self.reload = 0;
	}
};
