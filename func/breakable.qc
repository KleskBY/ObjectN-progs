void(vector orig, float type) shootParts =
{
	local vector dir;
	local float i;
	if(self.lastTouch + 0.3 < time)
	{
		for (i = 0; i < 11; i = i+1)	
		{
			dir_x = 0 - (random(-1,1) * 100);
			dir_y = 0 - (random(-1,1) * 100);
			dir_z = (random(-1,1) * 100);
			
			shootGib(orig, dir, type);
		}
		self.lastTouch = time;
	}
}

void() breakable_use =
{
	//shootParts(self.pos1, self.sounds);
	if(!self.pos1)
	{
		local vector center;
		center = (self.absmin + self.absmax) * 0.5;
		shootParts(center, self.sounds);
	}
	else shootParts(self.pos1, self.sounds);

	if(random() > 0.5) sound(self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
	else sound(self, CHAN_VOICE, self.noise2, 1, ATTN_NORM);

	self.think = SUB_Remove;
	self.nextthink = self.ltime + 1.01;
	
	
};

void() breakable_touch =
{	
	if(self.health && self.sounds != 2) return;
	if (other.classname != "player") return;
	//if (self.owner.attack_finished > time) return;
	//self.owner.attack_finished = time + 2;
	
	// if (self.owner.message != "")
	// {
		// centerprint (other, self.owner.message);
		// sound (other, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	// }
	
	self.touch = SUB_Null;
	
	shootParts(other.origin, self.sounds);
	breakable_use();
}

void() func_breakable =
{
	precache_model2("models/wood1.bsp");
	precache_model2("models/wood2.bsp");
	precache_model2("models/wood3.bsp");
	precache_model2("models/wood4.bsp");
	precache_model2("models/metal1.bsp");
	precache_model2("models/metal2.bsp");
	precache_model2("models/metal3.bsp");
	precache_model2("models/metal4.bsp");
	
	if (self.sounds == 0)
	{
		precache_sound ("misc/null.wav");
		self.noise1 = "misc/null.wav";
		self.noise2 = "misc/null.wav";
	}
	if (self.sounds == 1)
	{
		precache_sound2("func/wood1.wav");
		precache_sound2("func/wood2.wav");
		self.noise1 = "func/wood1.wav";
		self.noise2 = "func/wood2.wav";
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
	if(self.sounds == 2) self.movetype = MOVETYPE_NONE;
	else self.movetype = MOVETYPE_TOSS;
	setmodel (self, self.model);
	self.classname = "breakable";
	if (self.health)
	{
		self.takedamage = DAMAGE_AIM;
		self.th_die = breakable_use;
	}
	self.use = breakable_use;
	self.touch = breakable_touch;
}