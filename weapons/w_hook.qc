float MIN_CHAIN_LEN 	= 40;		// minimum chain length
float MAX_CHAIN_LEN 	= 1000;	// maximum chain length
float CHAIN_LINK_LEN	= 40;		// length between chain link origins
float GROW_SHRINK_RATE 	= 40;		// units of lengthen/shrink chain in 0.1 sec
float () crandom;	

void() BeamThink =
{
	if(!self.owner.hooking)
	{
		self.think = SUB_Remove;
	}
	self.nextthink = time+0.2;
}

void() DrawBeam = 
{
	local vector chainvec;		// vector of the chain 
	local vector chainunit; 	// vector of chain with distance of 1
	local float chainlen;		// length of chain
	local entity newlink;		// pointer to chain link being added
	local entity currlink;		// pointer to current link being traversed
	local entity nextlink;		// pointer to next link after current link
	local float currpos;		// numeric position of currlink
	local float linknum;		// number of links that should exist
	local float linkstart;		// length from hook at which currlink starts
	local vector p_self_origin;	// predicted future hook origin

	// predicts hook's future position since chain links fall behind
	currpos = vlen(self.velocity) / 22;   // currpos used here just as an intermediate value
	p_self_origin = self.origin + normalize(self.velocity) * currpos;

      // get info about chain
	chainvec = ((self.owner.origin + '0 0 16') - p_self_origin);
	chainunit = normalize(chainvec);
	chainvec = chainvec - chainunit * 18;
	chainlen = vlen(chainvec);

	currlink = self;
	currpos = 0;

	// generate and refresh links
	linknum = ceil(chainlen / CHAIN_LINK_LEN);    
	while (currpos < linknum)
	{
		// add entities if chain's length grows
		if (currlink.goalentity == world)
		{
			newlink = spawn();
			newlink.movetype = MOVETYPE_NOCLIP;
			newlink.solid = SOLID_NOT;
			setmodel (newlink, "models/chain.mdl");
			setsize (newlink, '0 0 0', '0 0 0');
			newlink.goalentity = world;
			currlink.goalentity = newlink;
			newlink.owner = self.owner;
			newlink.think = BeamThink;
			newlink.nextthink = time+0.2;
		}
		currlink = currlink.goalentity;
		currpos = currpos + 1;
		
		// set angles 
		currlink.angles = vectoangles(chainvec);

		// fixes vectoangles round off error
		if ((currlink.angles_y > 0) && (currlink.angles_y < 180))
			currlink.angles = currlink.angles + '0 1 0';

		// vibrates chain links on the z axis
		currlink.angles_z = currlink.angles_z + crandom() * 30;

		// set position and frames 
		linkstart = (currpos - 1) * CHAIN_LINK_LEN;
		if (currpos < linknum)
		{
			setorigin (currlink, p_self_origin + chainunit * (linkstart + CHAIN_LINK_LEN / 2 ));
			currlink.frame = 9;
		}
		else
		{
			setorigin (currlink, p_self_origin + chainunit * (linkstart + (chainlen - linkstart) / 2 ));
			currlink.frame = floor((chainlen - linkstart) / CHAIN_LINK_LEN * 10);
		}
	}
	
	// remove remaining entities if chain's length shrinks
	nextlink = currlink.goalentity;
	currlink.goalentity = world;
	currlink = nextlink;
	while (currlink != world)
	{
		nextlink = currlink.goalentity;
		remove (currlink);
		currlink = nextlink;
	}
};

void() pull =
{
	if (self.owner.hooking == 1)
	{
		self.owner.velocity = normalize(self.origin - self.owner.origin);
		self.owner.velocity = self.owner.velocity * 500;
		self.think = pull;
		self.nextthink = time + 0.1;
		if(random() > 0.5) sound (self.owner, CHAN_WEAPON, "hook/chain1.wav", 1, ATTN_NORM);	
		else sound (self.owner, CHAN_WEAPON, "hook/chain2.wav", 1, ATTN_NORM);	
	}
	else
	{
		self.owner.hooking = 0;
		remove(self);
		sound (self.owner, CHAN_WEAPON, "hook/retract.wav", 1, ATTN_NORM);
	}	
};

void() hookdamage =
{
	if (self.enemy.health && self.enemy.deadflag != DEAD_DEAD && self.enemy.deadflag != DEAD_DYING && self.owner.health && self.owner.deadflag != DEAD_DEAD && self.owner.deadflag != DEAD_DYING)
	{
		self.owner.velocity = normalize(self.origin - self.owner.origin);
		self.owner.velocity = self.owner.velocity * 500;
		
		T_Damage(self.enemy, self, self.owner, 2);

		self.origin = self.enemy.origin;
		self.think = hookdamage;
		self.nextthink = time + 0.1;
	}
	else
	{
		self.owner.hooking = 0;
		remove(self);
		sound (self.owner, CHAN_WEAPON, "hook/retract.wav", 1, ATTN_NORM);	
	}
};

void() PullHook =
{
	if (other == self.owner) return;
	if (other == world) // Pull
	{
		self.solid = SOLID_NOT;
		self.movetype = MOVETYPE_NONE;
		self.think = pull;
		self.nextthink = time;
    }
	if (other.takedamage && other.health)
	{
		self.think = hookdamage;
		self.enemy = other;
		self.solid = SOLID_NOT;
		self.nextthink = time;
	}
	sound (self.owner, CHAN_WEAPON, "weapons/knife/knife_hit2.wav", 1, ATTN_NORM);	
	
};


void() BreakHook =
{
	if (self.hooking == 1)
	{
		remove(self.hook);
		self.hooking = 0;
		sound (self.owner, CHAN_WEAPON, "hook/retract.wav", 1, ATTN_NORM);	
	}
};

void() HookThink =
{
	DrawBeam();
	sound (self, CHAN_WEAPON, "hook/fire.wav", 1, ATTN_NORM);	
	self.nextthink = time + 0.2;
}

void () FireHook =
{
	local entity hooky;
	hooky = spawn();
	setorigin(hooky, self.origin + self.view_ofs);
	setmodel(hooky, "models/hook.mdl");
	setsize (hooky, '0 0 0', '0 0 0');
	hooky.solid = SOLID_BBOX;
	hooky.movetype = MOVETYPE_FLYMISSILE;
	makevectors(self.v_angle);
	self.aiment = hooky;
	hooky.velocity = v_forward * 1500;
	hooky.owner = self;
	self.hook = hooky;
	hooky.classname = "hookend";
	self.hooking = 1;
	hooky.touch = PullHook;
	hooky.think = HookThink;
	hooky.nextthink = time+0.2;
	//hooky.cansplash = 1; // If my splash tutorial is installed, uncomment this line
	sound (self, CHAN_WEAPON, "hook/fire.wav", 1, ATTN_NORM);	
};
