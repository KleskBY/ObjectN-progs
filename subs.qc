void() SUB_Null = {};
void() SUB_Remove = {remove(self);};

/*
QuakeEd only writes a single float for angles (bad idea), so up and down are
just constant angles.
*/
void() SetMovedir =
{
	//bprint("debug SetMovedir()\n");
	if (self.angles == '0 -1 0') self.movedir = '0 0 1';
	else if (self.angles == '0 -2 0') self.movedir = '0 0 -1';
	else
	{
		makevectors (self.angles);
		self.movedir = v_forward;
	}
	
	self.angles = '0 0 0';
};

/*
================
InitTrigger
================
*/
void() InitTrigger =
{
	//bprint("debug InitTrigger()\n");
// trigger angles are used for one-way touches.  An angle of 0 is assumed
// to mean no restrictions, so use a yaw of 360 instead.
	if (self.angles != '0 0 0') SetMovedir ();
	self.solid = SOLID_TRIGGER;
	setmodel (self, self.model);	// set size and link into world
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
};

/*
=============
SUB_CalcMove

calculate self.velocity and self.nextthink to reach dest from
self.origin traveling at speed
===============
*/
void(entity ent, vector tdest, float tspeed, void() func) SUB_CalcMoveEnt =
{
	//bprint("debug SUB_CalcMoveEnt()\n");
	local entity	stemp;
	stemp = self;
	self = ent;

	SUB_CalcMove (tdest, tspeed, func);
	self = stemp;
};

void(vector tdest, float tspeed, void() func) SUB_CalcMove =
{
	//bprint("debug SUB_CalcMove()\n");
	local vector	vdestdelta;
	local float		len, traveltime;
	if (!tspeed) objerror("No speed is defined!");
	self.think1 = func;
	self.finaldest = tdest;
	self.think = SUB_CalcMoveDone;
	if (tdest == self.origin)
	{
		self.velocity = '0 0 0';
		self.nextthink = self.ltime + 0.1;
		return;
	}
// set destdelta to the vector needed to move
	vdestdelta = tdest - self.origin;
	
// calculate length of vector
	len = vlen (vdestdelta);
	
// divide by speed to get time to reach dest
	traveltime = len / tspeed;
	if (traveltime < 0.1)
	{
		self.velocity = '0 0 0';
		self.nextthink = self.ltime + 0.1;
		return;
	}
// set nextthink to trigger a think when dest is reached
	self.nextthink = self.ltime + traveltime;

// scale the destdelta vector by the time spent traveling to get velocity
	self.velocity = vdestdelta * (1/traveltime);	// qcc won't take vec/float	
};

/*
============
After moving, set origin to exact final destination
============
*/
void()  SUB_CalcMoveDone =
{
	//bprint("debug SUB_CalcMoveDone()\n");
	setorigin(self, self.finaldest);
	self.velocity = '0 0 0';
	self.nextthink = -1;
	if (self.think1) self.think1();
};


/*
=============
SUB_CalcAngleMove

calculate self.avelocity and self.nextthink to reach destangle from
self.angles rotating 

The calling function should make sure self.think is valid
===============
*/
void(entity ent, vector destangle, float tspeed, void() func) SUB_CalcAngleMoveEnt =
{
	//bprint("debug SUB_CalcAngleMoveEnt()\n");
	local entity stemp;
	stemp = self;
	self = ent;
	SUB_CalcAngleMove (destangle, tspeed, func);
	self = stemp;
};

void(vector destangle, float tspeed, void() func) SUB_CalcAngleMove =
{
	//bprint("debug SUB_CalcAngleMove()\n");
	local vector	destdelta;
	local float		len, traveltime;

	if (!tspeed) objerror("No speed is defined!");

	// set destdelta to the vector needed to move
	destdelta = destangle - self.angles;

	// calculate length of vector
	len = vlen (destdelta);

	// divide by speed to get time to reach dest
	traveltime = len / tspeed;

	// set nextthink to trigger a think when dest is reached
	self.nextthink = self.ltime + traveltime;

	// scale the destdelta vector by the time spent traveling to get velocity
	self.avelocity = destdelta * (1 / traveltime);

	self.think1 = func;
	self.finalangle = destangle;
	self.think = SUB_CalcAngleMoveDone;
};

/*
============
After rotating, set angle to exact final angle
============
*/
void() SUB_CalcAngleMoveDone =
{
	//bprint("debug SUB_CalcAngleMoveDone()\n");
	self.angles = self.finalangle;
	self.avelocity = '0 0 0';
	self.nextthink = -1;
	if (self.think1) self.think1();
};


//=============================================================================

void() DelayThink =
{
	//bprint("debug DelayThink()\n");
	activator = self.enemy;
	SUB_UseTargets ();
	remove(self);
};

/*
==============================
SUB_UseTargets

the global "activator" should be set to the entity that initiated the firing.

If self.delay is set, a DelayedUse entity will be created that will actually
do the SUB_UseTargets after that many seconds have passed.

Centerprints any self.message to the activator.

Removes all entities with a targetname that match self.killtarget,
and removes them, so some events can remove other triggers.

Search for (string)targetname in all entities that
match (string)self.target and call their .use function

==============================
*/
void() SUB_UseTargets =
{
	local entity t, stemp, otemp, act;

//
// check for a delay
//
	if (self.delay)
	{
	// create a temp object to fire at a later time
		t = spawn();
		t.classname = "DelayedUse";
		t.nextthink = time + self.delay;
		t.think = DelayThink;
		t.enemy = activator;
		t.message = self.message;
		t.killtarget = self.killtarget;
		t.target = self.target;
		return;
	}
	
	
//
// print the message
//
	if (activator.classname == "player" && self.message != "")
	{
		centerprint (activator, self.message);
		if (!self.noise)
			sound (activator, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	}

	if (self.target) // fire targets
	{
		act = activator;
		t = world;
		do
		{
			t = find (t, targetname, self.target);
			if (!t)
			{
				if (self.killtarget) // kill the killtagets
				{
					t = world;
					do
					{
						t = find (t, targetname, self.killtarget);
						if (!t) return;
						remove (t);
					} while ( 1 );
				}
				return;
			}
			stemp = self;
			otemp = other;
			self = t;
			other = stemp;
			if (self.use != SUB_Null)
			{
				if (self.use)
					self.use ();
			}
			self = stemp;
			other = otemp;
			activator = act;
		} while ( 1 );
	}
	else if (self.killtarget) // kill the killtagets
	{
		t = world;
		do
		{
			t = find (t, targetname, self.killtarget);
			if (!t) return;
			remove (t);
		} while ( 1 );
	}



	

};


/*

in nightmare mode, all attack_finished times become 0
some monsters refire twice automatically

*/

void(float normal) SUB_AttackFinished =
{
	self.cnt = 0;		// refire count for nightmare
	if (skill != 3) self.attack_finished = time + normal;
};

float (entity targ) visible;

void (void() thinkst) SUB_CheckRefire =
{
	if (skill != 3) return;
	if (self.cnt == 1) return;
	if (!visible (self.enemy)) return;
	self.cnt = 1;
	self.think = thinkst;
};

void() footsteps =
{
	if(self.flags & FL_ONGROUND && !self.duck && !self.button4 && self.classname != "monster_zombie" &&  self.movetype != MOVETYPE_NOCLIP)
	{
		if(time+random(0,0.1) > self.footstep_finished || self.footstep_finished == 0) 
		{
			local float r;
			r=random();
			if (r <=0.25) sound(self, CHAN_BODY, "player/footstep1.wav", 0.5, ATTN_IDLE );
			else if (r <=0.5 && r>0.25) sound(self, CHAN_BODY, "player/footstep2.wav", 0.5, ATTN_IDLE );
			else if (r <=0.75 && r>0.5) sound(self, CHAN_BODY, "player/footstep3.wav", 0.5, ATTN_IDLE );
			else sound(self, CHAN_BODY, "player/footstep4.wav", 0.5, ATTN_IDLE );
			self.footstep_finished = time + 0.5;
		}
	}
}

void() ZombieAttackSound = 
{
	local float r;
	r=random();
	if (r <=0.33) sound(self, CHAN_BODY, "zombie/attack1.wav", 0.7, ATTN_NORM);
	else if (r <=0.33 && r>0.66) sound(self, CHAN_BODY, "zombie/attack2.wav", 0.7, ATTN_NORM);
	else sound(self, CHAN_BODY, "zombie/attack3.wav", 0.7, ATTN_NORM);
}
