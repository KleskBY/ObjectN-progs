/*
==============================================================================

zombie

==============================================================================
*/

$cd id1/models/zombie
$origin 0 0 24
$base base
$skin badass3

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame runb1 runb2 runb3 runb4 runb5 runb6 runb7 runb8

//frame runc1 runc2 runc3 runc4 runc5 runc6

$frame runattack1 runattack2 runattack3 runattack4 runattack5
$frame runattack6 runattack7 runattack8 runattack9 runattack10
$frame runattack11

$frame pain1 pain2 pain3

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9
$frame painb10 painb11

//frame attack1 attack2 attack3 attack4 attack5 attack6 attack7
//frame attack8 attack9 attack10 attack11

$frame attackb1 attackb2 attackb3 attackb4 attackb5
$frame attackb6 attackb7 attackb8 attackb9 attackb10

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9
$frame walk10 walk11 walk12 walk13 walk14

$frame kneel1 kneel2 kneel3 kneel4 kneel5

$frame standing2 standing3 standing4 standing5

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11 deathb12

void()	zombie_stand1	=[	$stand1,	zombie_stand2	] {ai_stand();};
void()	zombie_stand2	=[	$stand2,	zombie_stand3	] {ai_stand();};
void()	zombie_stand3	=[	$stand3,	zombie_stand4	] {ai_stand();};
void()	zombie_stand4	=[	$stand4,	zombie_stand5	] {ai_stand();};
void()	zombie_stand5	=[	$stand5,	zombie_stand6	] {ai_stand();};
void()	zombie_stand6	=[	$stand6,	zombie_stand7	] {ai_stand();};
void()	zombie_stand7	=[	$stand7,	zombie_stand8	] {ai_stand();};
void()	zombie_stand8	=[	$stand8,	zombie_stand9	] {ai_stand();};
void()	zombie_stand9	=[	$stand9,	zombie_stand1	] {ai_stand();};

void()	zombie_walk1	=[	$walk1,		zombie_walk2	] 
{
	local float rsnd;
	if (random() < 0.15)
	{
		rsnd = rint(random() * 4);	
		if (rsnd == 1) sound (self, CHAN_VOICE, "zombie/idle1.wav", 1, ATTN_NORM); 
		else if (rsnd == 2) sound (self, CHAN_VOICE, "zombie/idle2.wav", 1, ATTN_NORM); 
		else if (rsnd == 3) sound (self, CHAN_VOICE, "zombie/idle3.wav", 1, ATTN_NORM); 
		else sound (self, CHAN_VOICE, "zombie/idle4.wav", 1, ATTN_NORM); 
	}
	ai_walk(3);
};
void()	zombie_walk2	=[	$walk2,		zombie_walk3	] {ai_walk(2);};
void()	zombie_walk3	=[	$walk3,		zombie_walk4	] {ai_walk(3);};
void()	zombie_walk4	=[	$walk4,		zombie_walk5	] {ai_walk(4);};
void()	zombie_walk5	=[	$walk5,		zombie_walk6	] {ai_walk(3);};
void()	zombie_walk6	=[	$walk6,		zombie_walk7	] {ai_walk(3);};
void()	zombie_walk7	=[	$walk7,		zombie_walk8	] {ai_walk(3);};
void()	zombie_walk8	=[	$walk8,		zombie_walk9	] {ai_walk(4);};
void()	zombie_walk9	=[	$walk9,		zombie_walk10	] {ai_walk(3);};
void()	zombie_walk10	=[	$walk10,	zombie_walk11	] {ai_walk(3);};
void()	zombie_walk11	=[	$walk11,	zombie_walk12	] {ai_walk(2);};
void()	zombie_walk12	=[	$walk12,	zombie_walk13	] {ai_walk(3);};
void()	zombie_walk13	=[	$walk13,	zombie_walk14	] {ai_walk(4);};
void()	zombie_walk14	=[	$walk14,	zombie_walk1	] {ai_walk(3);};


void()	zombie_run1	=[	$runb1,		zombie_run2	] 
{
	local float rsnd;
	if (random() < 0.05)
	{
		rsnd = rint(random() * 4);	
		if (rsnd == 1) sound (self, CHAN_VOICE, "zombie/idle1.wav", 1, ATTN_NORM); 
		else if (rsnd == 2) sound (self, CHAN_VOICE, "zombie/idle2.wav", 1, ATTN_NORM); 
		else if (rsnd == 3) sound (self, CHAN_VOICE, "zombie/idle3.wav", 1, ATTN_NORM); 
		else sound (self, CHAN_VOICE, "zombie/idle4.wav", 1, ATTN_NORM); 
	}
	ai_run(20);
};
void()	zombie_run2	=[	$runb2,		zombie_run3	] {ai_run(22);};
void()	zombie_run3	=[	$runb3,		zombie_run4	] {ai_run(15);};
void()	zombie_run4	=[	$runb4,		zombie_run5	] {ai_run(8);};
void()	zombie_run5	=[	$runb5,		zombie_run6	] {ai_run(18);};
void()	zombie_run6	=[	$runb6,		zombie_run7	] {ai_run(22);};
void()	zombie_run7	=[	$runb7,		zombie_run8	] {ai_run(15);};
void()	zombie_run8	=[	$runb8,		zombie_run1	] {ai_run(8);};


void()	zombie_runatk1	=[	$runattack1,		zombie_runatk2	]
{
	ZombieAttackSound();
	ai_charge(20);
};
void()	zombie_runatk2	=[	$runattack2,	zombie_runatk3	] {ai_charge_side();};
void()	zombie_runatk3	=[	$runattack3,	zombie_runatk4	] {ai_charge_side();};
void()	zombie_runatk4	=[	$runattack4,	zombie_runatk5	] {ai_charge_side();};
void()	zombie_runatk5	=[	$runattack5,	zombie_runatk6	] {ai_melee_side();};
void()	zombie_runatk6	=[	$runattack6,	zombie_runatk7	] {ai_melee_side();};
void()	zombie_runatk7	=[	$runattack7,	zombie_runatk8	] {ai_melee_side();};
void()	zombie_runatk8	=[	$runattack8,	zombie_runatk9	] {ai_melee_side();};
void()	zombie_runatk9	=[	$runattack9,	zombie_runatk10	] {ai_melee_side();};
void()	zombie_runatk10	=[	$runattack10,	zombie_runatk11	] {ai_charge_side();};
void()	zombie_runatk11	=[	$runattack11,	zombie_run1	] {ai_charge(10);};

void()	zombie_atk1	=[	$attackb1,		zombie_atk2	]
{
	ZombieAttackSound();
	ai_charge(0);
};
void()	zombie_atk2	=[	$attackb2,		zombie_atk3	] {ai_charge(7);};
void()	zombie_atk3	=[	$attackb3,		zombie_atk4	] {ai_charge(4);};
void()	zombie_atk4	=[	$attackb4,		zombie_atk5	] {ai_charge(0);};
void()	zombie_atk5	=[	$attackb5,		zombie_atk6	] {ai_charge(3);};
void()	zombie_atk6	=[	$attackb6,		zombie_atk7	] {ai_charge(4); ai_melee();};
void()	zombie_atk7	=[	$attackb7,		zombie_atk8	] {ai_charge(1); ai_melee();};
void()	zombie_atk8	=[	$attackb8,		zombie_atk9	] {ai_charge(3); ai_melee();};
void()	zombie_atk9	=[	$attackb9,		zombie_atk10] {ai_charge(1);};
void()	zombie_atk10=[	$attackb10,		zombie_run1	] {ai_charge(5);};

//void()	zombie_atk9	=[	$attack9,		zombie_atk10	] {};
//void()	zombie_atk10	=[	$attack10,		zombie_atk11	] {};
//void()	zombie_atk11	=[	$attack11,		zombie_run1	] {};

//===========================================================================

void()	zombie_pain1	=[	$pain1,		zombie_pain2	] {};
void()	zombie_pain2	=[	$pain2,		zombie_pain3	] {};
void()	zombie_pain3	=[	$pain3,		zombie_run1	] {};

void()	zombie_painb1	=[	$painb1,	zombie_painb2	] {ai_painforward(0);};
void()	zombie_painb2	=[	$painb2,	zombie_painb3	] {ai_painforward(3);};
void()	zombie_painb3	=[	$painb3,	zombie_painb4	] {};
void()	zombie_painb4	=[	$painb4,	zombie_painb5	] {};
void()	zombie_painb5	=[	$painb5,	zombie_painb6	] {ai_painforward(2);};
void()	zombie_painb6	=[	$painb6,	zombie_painb7	] {ai_painforward(4);};
void()	zombie_painb7	=[	$painb7,	zombie_painb8	] {ai_painforward(2);};
void()	zombie_painb8	=[	$painb8,	zombie_painb9	] {ai_painforward(5);};
void()	zombie_painb9	=[	$painb9,	zombie_painb10	] {ai_painforward(5);};
void()	zombie_painb10	=[	$painb10,	zombie_painb11	] {ai_painforward(0);};
void()	zombie_painb11	=[	$painb11,	zombie_run1	] {};

void(entity attacker, float damage)	zombie_pain =
{
	local float r;

	if (self.pain_finished > time)
		return;

	r = random();
	
	// sound (self, CHAN_VOICE, "zombie/khurt.wav", 1, ATTN_NORM);
	if (r < 0.85)
	{
		zombie_pain1 ();
		self.pain_finished = time + 1;
	}
	else
	{
		zombie_painb1 ();
		self.pain_finished = time + 1;
	}
	
};

//===========================================================================

void()	zombie_bow1	=[	$kneel1,		zombie_bow2	] {ai_turn();};
void()	zombie_bow2	=[	$kneel2,		zombie_bow3	] {ai_turn();};
void()	zombie_bow3	=[	$kneel3,		zombie_bow4	] {ai_turn();};
void()	zombie_bow4	=[	$kneel4,		zombie_bow5	] {ai_turn();};

void()	zombie_bow5	=[	$kneel5,		zombie_bow5	] {ai_turn();};

void()	zombie_bow6	=[	$kneel4,		zombie_bow7	] {ai_turn();};
void()	zombie_bow7	=[	$kneel3,		zombie_bow8	] {ai_turn();};
void()	zombie_bow8	=[	$kneel2,		zombie_bow9	] {ai_turn();};
void()	zombie_bow9	=[	$kneel1,		zombie_bow10	] {ai_turn();};
void()	zombie_bow10	=[	$walk1,		zombie_walk1	] {ai_turn();};



void()	zombie_die1	=[	$death1,	zombie_die2	] {};
void()	zombie_die2	=[	$death2,	zombie_die3	] {};
void()	zombie_die3	=[	$death3,	zombie_die4	] {self.solid = SOLID_NOT;};
void()	zombie_die4	=[	$death4,	zombie_die5	] {};
void()	zombie_die5	=[	$death5,	zombie_die6	] {};
void()	zombie_die6	=[	$death6,	zombie_die7	] {};
void()	zombie_die7	=[	$death7,	zombie_die8	] {};
void()	zombie_die8	=[	$death8,	zombie_die9	] {};
void()	zombie_die9	=[	$death9,	zombie_die10] {};
void()	zombie_die10=[	$death10,	zombie_die10] {};


void()	zombie_dieb1	=[	$deathb1,	zombie_dieb2	] {};
void()	zombie_dieb2	=[	$deathb2,	zombie_dieb3	] {};
void()	zombie_dieb3	=[	$deathb3,	zombie_dieb4	] {self.solid = SOLID_NOT;};
void()	zombie_dieb4	=[	$deathb4,	zombie_dieb5	] {};
void()	zombie_dieb5	=[	$deathb5,	zombie_dieb6	] {};
void()	zombie_dieb6	=[	$deathb6,	zombie_dieb7	] {};
void()	zombie_dieb7	=[	$deathb7,	zombie_dieb8	] {};
void()	zombie_dieb8	=[	$deathb8,	zombie_dieb9	] {};
void()	zombie_dieb9	=[	$deathb9,	zombie_dieb10] {};
void()	zombie_dieb10 = [	$deathb10,	zombie_dieb11] {};
void()	zombie_dieb11 = [	$deathb11,	zombie_dieb12] {};
void()	zombie_dieb12 = [	$deathb12,	zombie_dieb12] {};

void() zombie_die =
{
	local float rsnd;
	// check for gib
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
		ThrowHead ("", self.health);
		ThrowGib ("models/gib1.md3", self.health);
		ThrowGib ("models/gib2.md3", self.health);
		ThrowGib ("models/gib3.md3", self.health);
		return;
	}

// regular death
	rsnd = rint(random() * 5);
	switch (rsnd)
	{
		case 1:
			sound (self, CHAN_VOICE, "zombie/death1.wav", 1, ATTN_NORM);
			break;
		case 2:
			sound (self, CHAN_VOICE, "zombie/death2.wav", 1, ATTN_NORM);
			break;
		case 3:
			sound (self, CHAN_VOICE, "zombie/death3.wav", 1, ATTN_NORM);
			break;
		default:
			sound (self, CHAN_VOICE, "zombie/death4.wav", 1, ATTN_NORM);
			break;
	}
	
	if (random() < 0.5) zombie_die1 ();
	else
	{
		//ThrowHead ("progs/h_zombie.mdl", self.health);
		zombie_dieb1 ();
	}
};


/*QUAKED monster_zombie (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/

void() monster_zombie =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2("models/npc/zombie1.md3");
	precache_model2("models/npc/zombie2.md3");

	precache_sound2("zombie/death1.wav");
	precache_sound2("zombie/death2.wav");
	precache_sound2("zombie/death3.wav");
	precache_sound2("zombie/death4.wav");
	precache_sound2("zombie/idle1.wav");
	precache_sound2("zombie/idle2.wav");
	precache_sound2("zombie/idle3.wav");
	precache_sound2("zombie/idle4.wav");
	precache_sound2("zombie/sight1.wav");
	precache_sound2("zombie/sight2.wav");
	precache_sound2("zombie/sight3.wav");
	precache_sound2("zombie/attack1.wav");
	precache_sound2("zombie/attack2.wav");
	precache_sound2("zombie/attack3.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	if(random() >= 0.5) setmodel (self, "models/npc/zombie1.md3");
	else setmodel (self, "models/npc/zombie2.md3");
	setsize (self, '-9 -9 -24', '9 9 34');
	self.health = 80;

	self.th_stand = zombie_stand1;
	self.th_walk = zombie_walk1;
	self.th_run = zombie_run1;
	self.th_melee = zombie_atk1;
	self.th_pain = zombie_pain;
	self.th_die = zombie_die;
	
	walkmonster_start ();
};
