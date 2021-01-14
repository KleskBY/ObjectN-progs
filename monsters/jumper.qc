/*
==============================================================================

DEMON

==============================================================================
*/

$cd id1/models/demon3
$scale	0.8
$origin 0 0 24
$base base
$skin base

//============================================================================

void()	Demon_JumpTouch;
void(float side)	Demon_Melee;

void()	jumper_stand = [ 0, jumper_stand ] 
{
	self.walkframe = self.walkframe + 1;
	if(self.walkframe > 50) self.walkframe = 0;
	ai_stand();
	self.nextthink = time + 0.025;
	self.frame = self.walkframe;
};

void()	jumper_walk = [	51, jumper_walk ] 
{
	self.walkframe = self.walkframe + 1;
	//if (random() < 0.1) sound (self, CHAN_VOICE, "jumper/idle1.wav", 1, ATTN_IDLE);
	if(self.walkframe > 88) self.walkframe = 51;
	ai_walk(1);
	self.nextthink = time + 0.025;
	self.frame = self.walkframe;
};

void()	jumper_run = [	90, jumper_run ] 
{
	self.walkframe = self.walkframe + 1;
	if(self.walkframe > 115) self.walkframe = 90;
	//if (random() < 0.1) sound (self, CHAN_VOICE, "jumper/idle1.wav", 1, ATTN_IDLE);
	ai_run(4);
	self.nextthink = time + 0.025;
	self.frame = self.walkframe;
};
void()	jumper_jump = 
{
	if(self.frame < 116 || self.frame > 130) 
	{
		self.frame = 116;
		sound (self, CHAN_VOICE, "jumper/jump.wav", 1, ATTN_IDLE);
	}
	else self.frame = self.frame + 1;
	self.think = jumper_jump;
	self.nextthink = time + 0.025;
	if(self.frame & 2 == 0) ai_face();
	if(self.frame == 123) 
	{
		self.touch = Demon_JumpTouch;
		makevectors (self.angles);
		self.origin_z = self.origin_z + 1;
		self.velocity = v_forward * 600 + '0 0 250'; 
		if (self.flags & FL_ONGROUND) self.flags = self.flags - FL_ONGROUND;
	}
	if(self.frame == 130) 
	{
		self.walkframe = 90;
		self.think = jumper_run;
		self.nextthink = time + 1;
	}
};

void()	jumper_jump2 = 
{
	if(self.frame < 130 || self.frame > 142) self.frame = 130;
	else self.frame = self.frame + 1;
	self.think = jumper_jump2;
	self.nextthink = time + 0.025;
	if(self.frame == 142) 
	{
		self.walkframe = 90;
		self.think = jumper_run;
	}
};

void()	jumper_attack = 
{
	if(self.frame < 206 || self.frame > 230) self.frame = 206;
	else self.frame = self.frame + 1;
	ai_charge(4);
	if(self.frame == 218) Demon_Melee(200);
	if(self.frame == 230) 
	{
		self.walkframe = 90;
		self.think = jumper_run;
	}
	else self.think = jumper_attack;
	self.nextthink = time + 0.025;
};


void()	jumper_pain1 =
{
	if(self.frame < 142 || self.frame > 154) self.frame = 142;
	else self.frame = self.frame + 1;
	if(self.frame > 154) 
	{
		self.walkframe = 90;
		self.think = jumper_run;
	}
	else self.think = jumper_pain1;
	self.nextthink = time + 0.025;
};

void(entity attacker, float damage)	jumper_pain =
{
	if (self.touch == Demon_JumpTouch) return;
	if (self.pain_finished > time) return;

	self.pain_finished = time + 1;
    sound (self, CHAN_VOICE, "jumper/pain.wav", 1, ATTN_NORM);

	if (random()*200 > damage) return;		// didn't flinch
		
	jumper_pain1 ();
};

void()	jumper_die =
{
	if(self.frame < 162 || self.frame > 203) self.frame = 162;
	else if(self.frame != 203) self.frame = self.frame + 1;
	self.think = jumper_die;
	self.nextthink = time + 0.025;
	if(self.frame == 162) sound (self, CHAN_VOICE, "jumper/death.wav", 1, ATTN_NORM);
	if(self.frame == 190) self.solid = SOLID_NOT;
};



/*QUAKED monster_demon1 (1 0 0) (-32 -32 -24) (32 32 64) Ambush

*/
void() monster_demon1 =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2("models/npc/jumper.md3");

	precache_sound2("jumper/death.wav");
	precache_sound2("jumper/attack.wav");
	precache_sound2("jumper/jump.wav");
	precache_sound2("jumper/pain.wav");
	precache_sound2("zombie/sight1.wav");
	precache_sound2("zombie/sight2.wav");
	precache_sound2("zombie/sight3.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "models/npc/jumper.md3");

	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 1500;

	self.th_stand = jumper_stand;
	self.th_walk = jumper_walk;
	self.th_run = jumper_run;
	self.th_die = jumper_die;
	self.th_melee = jumper_attack;		// one of two attacks
	self.th_missile = jumper_jump;			// jump attack
	self.th_pain = jumper_pain;
		
	walkmonster_start();
};


/*
==============================================================================

DEMON

==============================================================================
*/

/*
==============
CheckDemonMelee

Returns TRUE if a melee attack would hit right now
==============
*/
float()	CheckDemonMelee =
{
	if (enemy_range == RANGE_MELEE)
	{	// FIXME: check canreach
		self.attack_state = AS_MELEE;
		return TRUE;
	}
	return FALSE;
};

/*
==============
CheckDemonJump

==============
*/
float()	CheckDemonJump =
{
	local	vector	dist;
	local	float	d;

	if (self.origin_z + self.mins_z > self.enemy.origin_z + self.enemy.mins_z
	+ 0.75 * self.enemy.size_z)
		return FALSE;
		
	if (self.origin_z + self.maxs_z < self.enemy.origin_z + self.enemy.mins_z
	+ 0.25 * self.enemy.size_z)
		return FALSE;
		
	dist = self.enemy.origin - self.origin;
	dist_z = 0;
	
	d = vlen(dist);
	
	if (d < 100)
		return FALSE;
		
	if (d > 200)
	{
		if (random() < 0.9)
			return FALSE;
	}
		
	return TRUE;
};


//===========================================================================

void(float side)	Demon_Melee =
{
	local	float	ldmg;
	local vector	delta;
	
	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100) return;
	if (!CanDamage (self.enemy, self)) return;
		
    sound (self, CHAN_WEAPON, "jumper/attack.wav", 1, ATTN_NORM);
	ldmg = 20 + 5 * random();
	T_Damage (self.enemy, self, self, ldmg);	

	makevectors (self.angles);
	//SpawnMeatSpray (self.origin + v_forward*16, side * v_right);
};


void()	Demon_JumpTouch =
{
	local	float	ldmg;

	if (self.health <= 0) return;
		
	if (other.takedamage)
	{
		if ( vlen(self.velocity) > 400 )
		{
			ldmg = 40 + 10*random();
			T_Damage (other, self, self, ldmg);	
		}
	}

	if (!checkbottom(self))
	{
		if (self.flags & FL_ONGROUND)
		{
			self.touch = SUB_Null;
			self.think = jumper_jump;
			self.nextthink = time + 0.1;
		}
		return;	// not on ground yet
	}

	self.touch = SUB_Null;
	self.think = jumper_jump2;
	self.nextthink = time + 0.05;
};

