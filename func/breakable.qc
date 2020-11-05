
void(vector position, vector direction) Shoot_Parts
{
   local entity blood;

   blood = spawn ();
   blood.owner = self;
   blood.movetype = MOVETYPE_FLYMISSILE;
   blood.solid = SOLID_NOT;
   makevectors (self.angles);
   blood.velocity = direction;
   blood.nextthink = (time + 0.250);
   blood.think = SUB_Remove;
   blood.touch = SUB_Remove;
   setmodel (blood,"models/blood.mdl");
   setsize (blood,VEC_ORIGIN,VEC_ORIGIN);
   setorigin (blood,position);
   
}

void() breakable_use =
{
	// pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + v_up * 20, self.velocity*50, 1);
	// local vector meatdir;
	// meatdir_x = ((random () * 300.000) );
	// meatdir_y = ((random () * 300.000) );
	// meatdir_z = ((random () * 300.000) );
	// Shoot_Parts(self.origin,meatdir);
	// self.think = SUB_Remove;
	// self.nextthink = self.ltime + 0.01;
	

	
	if(random() > 0.5) sound(self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	else sound(self, CHAN_VOICE, self.noise2, 1, ATTN_NORM);

	self.think = SUB_Remove;
	self.nextthink = self.ltime + 1.01;
	
	
};

void() breakable_touch =
{
	local vector meatdir;
	local float i;
	
	if (self.health) return;
	if (other.classname != "player") return;
	//if (self.owner.attack_finished > time) return;
	//self.owner.attack_finished = time + 2;

	if (self.owner.message != "")
	{
		centerprint (other, self.owner.message);
		sound (other, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	}
	
	self.touch = SUB_Null;
	
	for(i = 0; i < 10; ++i)
	{
		meatdir_x = ((random () * 300.000) + other.velocity_x);
		meatdir_y = ((random () * 300.000) + other.velocity_y);
		meatdir_z = ((random () * 300.000) + other.velocity_z);
		ShootGlass(other.origin, meatdir);
	}
	breakable_use();
}

void() func_breakable =
{
	if (self.sounds == 0)
	{
		precache_sound ("misc/null.wav");
		self.noise1 = "misc/null.wav";
		self.noise2 = "misc/null.wav";
	}
	if (self.sounds == 1)
	{
		precache_sound2("func/doorstop1.wav");
		precache_sound2("func/doormove1.wav");
		self.noise1 = "func/doorstop1.wav";
		self.noise2 = "func/doormove1.wav";
	}
	if (self.sounds == 2)
	{
		precache_sound2("func/glass1.wav");
		precache_sound2("func/glass2.wav");
		self.noise1 = "func/glass1.wav";
		self.noise2 = "func/glass2.wav";
	}
	else if (self.sounds == 3)
	{
		precache_sound2("func/metal1.wav");
		precache_sound2("func/metal2.wav");
		self.noise1 = "func/metal1.wav";
		self.noise2 = "func/metal2.wav";
	}
	
	self.max_health = self.health;
	self.solid = SOLID_BSP;
	self.movetype = MOVETYPE_NONE;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.classname = "breakable";
	
	if (self.health)
	{
		self.takedamage = DAMAGE_AIM;
		self.th_die = breakable_use;
	}
	
	self.use = breakable_use;
	self.touch = breakable_touch;
	//self.think = LinkDoors;
	//self.nextthink = self.ltime + 0.1;
}