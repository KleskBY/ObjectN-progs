/*
==============================================================================

PRISON GUARD

==============================================================================
*/

$cd id1/models/pdude
$origin 0 -6 -24
$base base		
$skin skin


$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17 
$frame stand18 stand19 stand20 stand21 stand22

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16 walk17 walk18 walk19
$frame walk20 walk21 walk22 walk23 walk24 walk25 walk26 walk27 walk28
$frame walk29 walk30

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9

$frame firec1 firec2 firec3 firec4 firec5 firec6 firec7 firec8 firec9 firec10
$frame firec11 firec12 firec13

$frame drawc1 drawc2 drawc3 drawc4 drawc5 drawc6 drawc7 drawc8 drawc9

$frame fireb1 fireb2

$frame drawb1 drawb2 drawb3 drawb4 drawb5 drawb6 drawb7 drawb8 drawb9

$frame firea1 firea2 firea3 firea4 firea5 firea6 firea7 firea8

$frame drawa1 drawa2 drawa3 drawa4 drawa5 drawa6 drawa7

$frame grenade1 grenade2 grenade3 grenade4 grenade5 grenade6 grenade7 grenade8 grenade9
$frame grenade10 grenade11 grenade12 grenade13 grenade14 grenade15 grenade16

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10
$frame load11 load12 load13 load14

$frame melee1 melee2 melee3 melee4 melee5 melee6 melee7 melee8 melee9 melee10 //fix

$frame paind1 paind2 paind3 paind4 paind5

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 

$frame painb1 painb2 painb3 painb4 painb5

$frame paina1 paina2 paina3 paina4 paina5 

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11 

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7 deathd8
$frame deathd9 

$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9 leap10 leap11 leap12
$frame leap13 leap14

$frame roll1 roll2 roll3 roll4 roll5 roll6 roll7 roll8 roll9 roll10 roll11 roll12 roll13
$frame roll14 roll15 roll16 roll17 roll18 roll19 roll20 roll21 roll22 roll23 roll24
$frame roll25 roll26 roll27

/*
==============================================================================
SOLDIER CODE
==============================================================================
*/

void() Laser_Touch =
{
	local vector org;
	
	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, self.velocity*0.2, 15);
		T_Damage (other, self, self.owner, 20);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
	
	remove(self);	
};

void(vector org, vector vec) LaunchLaser =
{		
	if (self.classname == "monster_heavy") sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);

	vec = normalize(vec);
	
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;

	setmodel (newmis, "progs/laser.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		

	setorigin (newmis, org);

	newmis.velocity = vec * 600;
	newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.touch = Laser_Touch;
};



void() pdude_fire;
void() pdudeFireGrenade;

void (float dist) ai_moveforeward =
{
	walkmove (self.angles_y, dist);
};

void()      pdude_grenade1 = [ $grenade1, pdude_grenade2] {ai_face();};
void()      pdude_grenade2 = [ $grenade2, pdude_grenade3] {ai_face();};
void()      pdude_grenade3 = [ $grenade3, pdude_grenade4] {ai_face();};
void()      pdude_grenade4 = [ $grenade4, pdude_grenade5] {ai_face();};
void()      pdude_grenade5 = [ $grenade5, pdude_grenade6] {ai_face();};
void()      pdude_grenade6 = [ $grenade6, pdude_grenade7] {ai_face();};
void()      pdude_grenade7 = [ $grenade7, pdude_grenade8] {ai_face();};
void()      pdude_grenade8 = [ $grenade8, pdude_grenade9] {ai_face();};
void()      pdude_grenade9 = [ $grenade9, pdude_grenade10] {ai_face();};
void()      pdude_grenade10 = [ $grenade10, pdude_grenade11] {ai_face();};
void()      pdude_grenade11 = [ $grenade11, pdude_grenade12] {ai_face();};
void()      pdude_grenade12 = [ $grenade12, pdude_grenade13] {ai_face();pdudeFireGrenade();};
void()      pdude_grenade13 = [ $grenade13, pdude_grenade14] {ai_face();};
void()      pdude_grenade14 = [ $grenade14, pdude_grenade15] {ai_face();};
void()      pdude_grenade15 = [ $grenade15, pdude_grenade16] {ai_face();};
void()      pdude_grenade16 = [ $grenade16, pdude_run1] {ai_face();};

void()      pdude_straferight1 = [ $firec1,     pdude_straferight2] {ai_face(); self.duck =1;};
void()      pdude_straferight2 = [ $firec2,   pdude_straferight3] {ai_face();};
void()      pdude_straferight3 = [ $firec3,   pdude_straferight4] {ai_face();};
void()      pdude_straferight4 = [ $firec4,   pdude_straferight5] {ai_face();};
void()      pdude_straferight5 = [ $firec5,   pdude_straferight6] {ai_face();};
void()      pdude_straferight6 = [ $firec6,   pdude_straferight7] {ai_face();ai_strafeleft(12.5);pdude_fire();};
void()      pdude_straferight7 = [ $firec7,   pdude_straferight8] {ai_face();ai_strafeleft(4);};
void()      pdude_straferight8 = [ $firec8,   pdude_straferight9] {ai_face();ai_strafeleft(5);pdude_fire();};
void()      pdude_straferight9 = [ $firec9,   pdude_straferight10] {ai_face();ai_strafeleft(3);};
void()      pdude_straferight10 = [ $firec10,   pdude_straferight11] {ai_face();ai_strafeleft(3);pdude_fire();};
void()      pdude_straferight11 = [ $firec11,   pdude_straferight12] {ai_face();ai_strafeleft(5);};
void()      pdude_straferight12 = [ $firec12,   pdude_straferight13] {ai_face();ai_strafeleft(3);pdude_fire();};
void()      pdude_straferight13 = [ $firec13,   pdude_straferight14] {ai_face();ai_strafeleft(4);};
// void()      pdude_straferight14 = [ $firec14,   pdude_straferight15] {ai_face();ai_strafeleft(4);pdude_fire();};
// void()      pdude_straferight15 = [ $firec15,   pdude_straferight16] {ai_face();ai_strafeleft(4);};
// void()      pdude_straferight16 = [ $firec16,   pdude_straferight17] {ai_face();ai_strafeleft(4);pdude_fire();};
// void()      pdude_straferight17 = [ $firec17,   pdude_straferight18] {ai_face();ai_strafeleft(3);};
//void()      pdude_straferight18 = [ $firec4,   pdude_straferight19] {ai_face();ai_straferight(6);};
void()      pdude_straferight14 = [ $firec4,   pdude_straferight19] {ai_face();ai_straferight(6);};
void()      pdude_straferight19 = [ $firec3,   pdude_straferight20] {ai_face();};
void()      pdude_straferight20 = [ $firec2,   pdude_run1] {ai_face();};

void()	pdude_stand1	=[	$stand1,	pdude_stand2	] {ai_stand();};
void()	pdude_stand2	=[	$stand2,	pdude_stand3	] {ai_stand();};
void()	pdude_stand3	=[	$stand3,	pdude_stand4	] {ai_stand();};
void()	pdude_stand4	=[	$stand4,	pdude_stand5	] {ai_stand();};
void()	pdude_stand5	=[	$stand5,	pdude_stand6	] {ai_stand();};
void()	pdude_stand6	=[	$stand6,	pdude_stand7	] {ai_stand();};
void()	pdude_stand7	=[	$stand7,	pdude_stand8	] {ai_stand();};
void()	pdude_stand8	=[	$stand8,	pdude_stand9	] {ai_stand();};
void()	pdude_stand9	=[	$stand9,	pdude_stand10	] {ai_stand();};
void()	pdude_stand10	=[	$stand10,	pdude_stand11	] {ai_stand();};
void()	pdude_stand11	=[	$stand11,	pdude_stand12	] {ai_stand();};
void()	pdude_stand12	=[	$stand12,	pdude_stand13	] {ai_stand();};
void()	pdude_stand13	=[	$stand13,	pdude_stand14	] {ai_stand();};
void()	pdude_stand14	=[	$stand14,	pdude_stand15	] {ai_stand();};
void()	pdude_stand15	=[	$stand15,	pdude_stand16	] {ai_stand();};
void()	pdude_stand16	=[	$stand16,	pdude_stand17	] {ai_stand();};
void()	pdude_stand17	=[	$stand17,	pdude_stand18	] {ai_stand();};
void()	pdude_stand18	=[	$stand18,	pdude_stand19	] {ai_stand();};
void()	pdude_stand19 	=[	$stand19,	pdude_stand20	] {ai_stand();};
void()	pdude_stand20	=[	$stand20,	pdude_stand21	] {ai_stand();};
void()	pdude_stand21	=[	$stand21,	pdude_stand22	] {ai_stand();};
void()	pdude_stand22	=[	$stand22,	pdude_stand1	] {ai_stand();};

void()	pdude_walk1	=[	$walk1,	pdude_walk2	] {};
void()	pdude_walk2	=[	$walk2,	pdude_walk3	] {ai_walk(1);};
void()	pdude_walk3	=[	$walk3,	pdude_walk4	] {ai_walk(1);};
void()	pdude_walk4	=[	$walk4,	pdude_walk5	] {ai_walk(1);};
void()	pdude_walk5	=[	$walk5,	pdude_walk6	] {ai_walk(2);};
void()	pdude_walk6	=[	$walk6,	pdude_walk7	] {ai_walk(5);};
void()	pdude_walk7	=[	$walk7,	pdude_walk8	] {ai_walk(5);};
void()	pdude_walk8	=[	$walk8,	pdude_walk9	] {ai_walk(4);};
void()	pdude_walk9	=[	$walk9,	pdude_walk10	] {ai_walk(-1);};
void()	pdude_walk10	=[	$walk10,	pdude_walk11	] {ai_walk(0);};
void()	pdude_walk11	=[	$walk11,	pdude_walk12	] {ai_walk(0);};
void()	pdude_walk12	=[	$walk12,	pdude_walk13	] {ai_walk(0);};
void()	pdude_walk13	=[	$walk13,	pdude_walk14	] {ai_walk(1);};
void()	pdude_walk14	=[	$walk14,	pdude_walk15	] {ai_walk(8);};
void()	pdude_walk15	=[	$walk15,	pdude_walk16	] {ai_walk(7);};
void()	pdude_walk16	=[	$walk16,	pdude_walk1	] {ai_walk(6);};

void()	pdude_run1	=[	$run1,		pdude_run2	] 
{
  self.duck = 0;
  setsize (self, '-9 -9 -24', '9 9 34');
  //self.PMclip = 8;
};
void()	pdude_run2	=[	$run2,		pdude_run3	] {ai_run(5);};
void()	pdude_run3	=[	$run3,		pdude_run4	] {ai_run(3);};
void()	pdude_run4	=[	$run4,		pdude_run5	] {ai_run(13);};
void()	pdude_run5	=[	$run5,		pdude_run6	] {ai_run(7);};
void()	pdude_run6	=[	$run6,		pdude_run7	] {ai_run(8);};
void()	pdude_run7	=[	$run7,		pdude_run8	] {ai_run(7);};
void()	pdude_run8	=[	$run8,		pdude_run9	] {ai_run(10);};
void()	pdude_run9	=[	$run9,		pdude_run1	] {ai_run(7);};

void()      pdude_load1   =[    $load1,      pdude_load2] {self.PMclip = 20;};
void()      pdude_load2   =[    $load2,      pdude_load3] {};
void()      pdude_load3   =[    $load3,      pdude_load4] {};
void()      pdude_load4   =[    $load4,      pdude_load5] {sound(self,CHAN_WEAPON,"weapons/ak47/ak47_clipout.wav",1,ATTN_NORM);};
void()      pdude_load5   =[    $load5,      pdude_load6] {};
void()      pdude_load6   =[    $load6,      pdude_load7] {};
void()      pdude_load7   =[    $load7,      pdude_load8] {};
void()      pdude_load8   =[    $load8,      pdude_load9] {};
void()      pdude_load9   =[    $load9,      pdude_load10] {};
void()      pdude_load10   =[    $load10,      pdude_load11] {};
void()      pdude_load11   =[    $load11,      pdude_load12] {};
void()      pdude_load12   =[    $load12,      pdude_load13] {};
void()      pdude_load13   =[    $load13,      pdude_load14] {};
void()      pdude_load14   =[    $load14,      pdude_run1] {sound(self,CHAN_WEAPON,"weapons/ak47/ak47_clipin.wav",1,ATTN_NORM);};


void() pdude_drawa1;

void()      pdude_leapleft1 = [  $leap1, pdude_leapleft2 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft2 = [  $leap2, pdude_leapleft3 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft3 = [  $leap3, pdude_leapleft4 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft4 = [  $leap4, pdude_leapleft5 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft5 = [  $leap5, pdude_leapleft6 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft6 = [  $leap6, pdude_leapleft7 ] {self.nextthink = time + 0.03;ai_strafeleft(8);};
void()      pdude_leapleft7 = [  $leap7, pdude_leapleft8 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      pdude_leapleft8 = [  $leap8, pdude_leapleft9 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      pdude_leapleft9 = [  $leap9, pdude_leapleft10 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      pdude_leapleft10 = [  $leap10, pdude_leapleft11 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      pdude_leapleft11 = [  $leap11, pdude_leapleft12 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      pdude_leapleft12 = [  $leap12, pdude_leapleft13 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft13 = [  $leap13, pdude_leapleft14 ] {self.nextthink = time + 0.03;};
void()      pdude_leapleft14 = [  $leap14, pdude_drawa2 ] {};

void()      pdude_leapright1 = [  $leap1, pdude_leapright2 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright2 = [  $leap2, pdude_leapright3 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright3 = [  $leap3, pdude_leapright4 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright4 = [  $leap4, pdude_leapright5 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright5 = [  $leap5, pdude_leapright6 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright6 = [  $leap6, pdude_leapright7 ] {ai_straferight(8);self.nextthink = time + 0.03;};
void()      pdude_leapright7 = [  $leap7, pdude_leapright8 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      pdude_leapright8 = [  $leap8, pdude_leapright9 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      pdude_leapright9 = [  $leap9, pdude_leapright10 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      pdude_leapright10 = [  $leap10, pdude_leapright11 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      pdude_leapright11 = [  $leap11, pdude_leapright12 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      pdude_leapright12 = [  $leap12, pdude_leapright13 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright13 = [  $leap13, pdude_leapright14 ] {self.nextthink = time + 0.03;};
void()      pdude_leapright14 = [  $leap14, pdude_drawa2 ] {};

//void() pdude_fired1;

void()      pdude_roll1 = [ $roll1 , pdude_roll2 ] {self.nextthink = time + 0.03;};
void()      pdude_roll2 = [ $roll2 , pdude_roll3 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      pdude_roll3 = [ $roll3 , pdude_roll4 ] {ai_moveforeward(2);self.nextthink = time + 0.03;};
void()      pdude_roll4 = [ $roll4 , pdude_roll5 ] {ai_moveforeward(2);self.nextthink = time + 0.03;};
void()      pdude_roll5 = [ $roll5 , pdude_roll6 ] {ai_moveforeward(1);self.nextthink = time + 0.03;};
void()      pdude_roll6 = [ $roll6 , pdude_roll7 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      pdude_roll7 = [ $roll7 , pdude_roll8 ] {ai_moveforeward(7);self.nextthink = time + 0.03;};
void()      pdude_roll8 = [ $roll8 , pdude_roll9 ] {ai_moveforeward(8);self.nextthink = time + 0.03;};
void()      pdude_roll9 = [ $roll9 , pdude_roll10 ] {ai_moveforeward(6);setsize (self, '-23 -12 -25', '11 12 18');self.duck = 1;self.nextthink = time + 0.03;};
void()      pdude_roll10 = [ $roll10 , pdude_roll11 ] {ai_moveforeward(6);self.nextthink = time + 0.03;};
void()      pdude_roll11 = [ $roll11 , pdude_roll12 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll12 = [ $roll12 , pdude_roll13 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll13 = [ $roll13 , pdude_roll14 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll14 = [ $roll14 , pdude_roll15 ] {ai_moveforeward(6);self.nextthink = time + 0.03;};
void()      pdude_roll15 = [ $roll15 , pdude_roll16 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll16 = [ $roll16 , pdude_roll17 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll17 = [ $roll17 , pdude_roll18 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll18 = [ $roll18 , pdude_roll19 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll19 = [ $roll19 , pdude_roll20 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll20 = [ $roll20 , pdude_roll21 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll21 = [ $roll21 , pdude_roll22 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll22 = [ $roll22 , pdude_roll23 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      pdude_roll23 = [ $roll23 , pdude_roll24 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      pdude_roll24 = [ $roll24 , pdude_roll25 ] {ai_moveforeward(2.5);self.nextthink = time + 0.03;};
void()      pdude_roll25 = [ $roll25 , pdude_roll26 ] {ai_moveforeward(-0.5);self.nextthink = time + 0.03;};
void()      pdude_roll26 = [ $roll26 , pdude_roll27 ] {ai_moveforeward(-1);self.nextthink = time + 0.03;};
void()      pdude_roll27 = [ $roll27 , pdude_straferight1 ] {ai_moveforeward(-0.5);self.nextthink = time + 0.03;};

// void()      pdude_fired1 = [ $fired1 , pdude_fired2  ]
// {
 // ai_face();
 // pdude_fire();
// };

// void()      pdude_fired2 = [ $fired2 , pdude_fired3 ] 
// { 
 // ai_face();
// };

// void()      pdude_fired3 = [ $fired3 , pdude_run1 ] 
// { 
 // ai_face();
 // SUB_CheckRefire (pdude_fired1);
 // if (self.PMclip <= 0)
   // {
     // self.think = pdude_load1;
   // }
// };

void()      pdude_firea1 = [ $firea1 , pdude_firea2 ] 
{ 
	ai_face();
	pdude_fire();
};

void()      pdude_firea2 = [ $firea2 , pdude_firea3 ] 
{ 
	ai_face();
	pdude_fire();
};

void()      pdude_firea3 = [ $firea3 , pdude_run1 ] 
{ 
	ai_face();
	SUB_CheckRefire (pdude_firea1);
	if (self.PMclip <= 0) self.think = pdude_load1;
	else pdude_fire();
};

void() pdude_drawb1;

void()      pdude_drawa1   =[    $drawa1,     pdude_drawa2   ] 
{
	local float temp;

	temp = random();
	ai_face();
	
	/*** Check to see if grenades are throwable ***/
	if (((self.absmax_z - self.enemy.absmax_z) > -50) && (vlen(self.enemy.origin - self.origin) > 500) && random () < 0.5 )
	{
		self.think = pdude_grenade1;
		self.attack_finished = time + 1.3;
	}   
	else
	{
		if (temp < 0.35)
		{
			self.think = pdude_drawa1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.8) && (temp >= 0.35))
		{
			self.think = pdude_drawb1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.9) && (temp >= 0.8)) 
		{ 
			self.think = pdude_roll1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.95) && (temp >= 0.9))
		{
			self.think = pdude_leapright1;
			self.nextthink = time + 0.03;
		}
		else if (temp >= 0.95)
		{
			self.think = pdude_leapleft1;
			self.nextthink = time + 0.03;
		}
	}

	/*** Check to see if reload is necessary ***/
	if (self.PMclip <= 0) self.think = pdude_load1;

	/*** Check to see if someone is in front of me ***/
	traceline(self.origin,self.enemy.origin,0,self);
	if ( (trace_ent.classname == "monster_heavy") || (trace_ent.classname == "monster_light") )
	{
	if (random() < 0.50)self.think = pdude_leapright1;
	else self.think = pdude_leapleft1;
	}

};

void()      pdude_drawa2   =[    $drawa2,     pdude_drawa3   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawa3   =[    $drawa3,     pdude_drawa4   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawa4   =[    $drawa4,     pdude_drawa5   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawa5   =[    $drawa5,     pdude_drawa6   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawa6   =[    $drawa6,     pdude_drawa7   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawa7   =[    $drawa7,     pdude_firea1   ] {ai_face();self.nextthink = time + 0.03;};

/************************* END OF DRAWA  ************************/

void()      pdude_fireb1         =[    $fireb1,     pdude_fireb2   ] 
{ 
	ai_face();
	pdude_fire();
};

void()      pdude_fireb2         =[    $fireb2,     pdude_fireb3   ] 
{ 
	ai_face();
	pdude_fire();
};


void()      pdude_fireb3         =[    $fireb1,     pdude_run1     ] 
{ 
	ai_face();
	self.nextthink = time + 0.02;
	SUB_CheckRefire (pdude_fireb1);
	if (self.PMclip <= 0) self.think = pdude_load1;
	else pdude_fire();
};

void()      pdude_drawb1   =[    $drawb1,     pdude_drawb2   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawb2   =[    $drawb2,     pdude_drawb3   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawb3   =[    $drawb3,     pdude_drawb4   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawb4   =[    $drawb4,     pdude_drawb5   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawb5   =[    $drawb5,     pdude_drawb6   ] {ai_face();self.nextthink = time + 0.03;};
void()      pdude_drawb6   =[    $drawb6,     pdude_fireb1   ] 
 {
  ai_face();
  self.nextthink = time + 0.03;
  if (random() < 0.5)
   self.think = pdude_straferight1;
 };

/************************** END OF DRAWB *******************************/




void()	pdude_paina1	=[	$paina1,		pdude_paina2	] {};
void()	pdude_paina2	=[	$paina2,		pdude_paina3	] {};
void()	pdude_paina3	=[	$paina3,		pdude_paina4	] {};
void()	pdude_paina4	=[	$paina4,		pdude_paina5	] {};
void()	pdude_paina5	=[	$paina5,		pdude_drawa1	] {};
//void()	pdude_paina6	=[	$paina6,		pdude_drawa1	] {};

void()	pdude_painb1	=[	$painb1,	pdude_painb2	] {};
void()	pdude_painb2	=[	$painb2,	pdude_painb3	] {};
void()	pdude_painb3	=[	$painb3,	pdude_painb4	] {};
void()	pdude_painb4	=[	$painb4,	pdude_painb5	] {};
void()	pdude_painb5	=[	$painb5,	pdude_drawa1	] {};
// void()	pdude_painb6	=[	$painb6,	pdude_painb7	] {};
// void()	pdude_painb7	=[	$painb7,	pdude_painb8	] {};
// void()	pdude_painb8	=[	$painb8,	pdude_drawa1	] {};

void()	pdude_painc1	=[	$painc1,	pdude_painc2	] {};
void()	pdude_painc2	=[	$painc2,	pdude_painc3	] {};
void()	pdude_painc3	=[	$painc3,	pdude_painc4	] {};
void()	pdude_painc4	=[	$painc4,	pdude_painc5	] {};
void()	pdude_painc5	=[	$painc5,	pdude_painc6	] {};
void()	pdude_painc6	=[	$painc6,	pdude_drawa1	] {};

void()	pdude_paind1	=[	$paind1,	pdude_paind2	] {};
void()	pdude_paind2	=[	$paind2,	pdude_paind3	] {};
void()	pdude_paind3	=[	$paind3,	pdude_paind4	] {};
void()	pdude_paind4	=[	$paind4,	pdude_paind5	] {};
void()	pdude_paind5	=[	$paind5,	pdude_drawa1	] {};
//void()	pdude_paind6	=[	$paind6,	pdude_drawa1	] {};

// void()	pdude_paine1	=[	$paine1,	pdude_paine2	] {};
// void()	pdude_paine2	=[	$paine2,	pdude_paine3	] {};
// void()	pdude_paine3	=[	$paine3,	pdude_paine4	] {};
// void()	pdude_paine4	=[	$paine4,	pdude_paine5	] {};
// void()	pdude_paine5	=[	$paine5,	pdude_paine6	] {};
// void()	pdude_paine6	=[	$paine6,	pdude_drawa1	] {};

void()	pdude_Melee =
{
	local	float	ldmg;
	local vector	delta;
	
	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100) return;
	if (!CanDamage (self.enemy, self)) return;
		
    sound (self, CHAN_WEAPON, "weapons/knife/knife_hit1.wav", 1, ATTN_NORM);
	ldmg = 10 + 5*random();
	T_Damage (self.enemy, self, self, ldmg);	

	makevectors (self.angles);
};

void() pdudeFireGrenade =
{
	local	entity missile;
	

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
		
// set missile speed	

	makevectors (self.angles);

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 400;
	missile.velocity_z = 400;

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = HandGrenadeTouch;
	
// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = MyGrenadeExplode;

	setmodel (missile, "models/w_grenade.md3");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, self.origin);
};

void(entity attacker, float damage)	pdude_pain =
{
	local float r;
	
	//if (self.pain_finished > time)
	//	return;

	r = random();

    if (self.duck == 1)
     {
      if (r < 0.5)
         {
          self.pain_finished = time + 0.1;
          sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);
          pdude_paina1 ();
         }
      else
         {
          self.pain_finished = time + 0.1;
          sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);
          pdude_painb1 ();
         }
     }
    else
     {
		if (r < 0.333)
		{
			pdude_painc1 ();
			sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);
		}
		
		pdude_paind1 ();
        sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);

     }
};

void() pdude_fire =
{
	local	vector	dir;
	local	entity	en;
	local	vector	src;
	
	ai_face();

// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	dir = (en.origin + '0 0 -8') - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	//guardFire(17,dir);
	sound (self, CHAN_WEAPON, "npc/soldier_scorpion.wav", 1, ATTN_NORM);
	if(self.duck == 1) pointparticles(particleeffectnum("shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -24 , self.velocity*50, 1);
	else pointparticles(particleeffectnum("shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -13, self.velocity*50, 1);

	makevectors(self.v_angle);
	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;        
	traceline (src, src + dir * 1024, FALSE, self);
	if (trace_fraction != 1.0)
	{
		if (trace_ent.takedamage) T_Damage (trace_ent, self, self, 8);
		else
		{
			// WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
			// WriteByte (MSG_BROADCAST,TE_GUNSHOT);
			// WriteCoord (MSG_BROADCAST,trace_ent.origin_x);
			// WriteCoord (MSG_BROADCAST,trace_ent.origin_y);
			// WriteCoord (MSG_BROADCAST,trace_ent.origin_z);
			particle (trace_endpos,'3.000 2.000 7.000',192.000,TE_WIZSPIKE);
			particle (trace_endpos,'7.000 6.000 8.000',192.000,TE_WIZSPIKE);
						
		}    
	}
    self.PMclip = self.PMclip - 1;
};

void()      pdude_melee1 = [   $melee1,   pdude_melee2 ] {ai_face();};
void()      pdude_melee2 = [   $melee2,   pdude_melee3 ] {ai_face();};
void()      pdude_melee3 = [   $melee3,   pdude_melee4 ] {ai_face();};
void()      pdude_melee4 = [   $melee4,   pdude_melee5 ] {ai_face();};
void()      pdude_melee5 = [   $melee5,   pdude_melee6 ] {ai_face();};
void()      pdude_melee6 = [   $melee6,   pdude_melee7 ] {ai_face();pdude_Melee ();};
void()      pdude_melee7 = [   $melee7,   pdude_melee8 ] {ai_face();pdude_Melee ();};
void()      pdude_melee8 = [   $melee8,   pdude_melee9 ] {ai_face();};
void()      pdude_melee9 = [   $melee9,   pdude_melee10 ] {ai_face();};
void()      pdude_melee10 = [   $melee10,   pdude_run1 ] {ai_face();};

void()	pdude_diea1	=[	$deatha1,	pdude_diea2	] {self.nextthink = time + 0.02;};
void()	pdude_diea2	=[	$deatha2,	pdude_diea3	] {self.nextthink = time + 0.02; ai_moveforeward(-4);};
void()	pdude_diea3	=[	$deatha3,	pdude_diea4	] 
{
  ai_moveforeward(-4);
  self.solid = SOLID_NOT;
  self.nextthink = time + 0.02;
  ai_back(4);
};
void()	pdude_diea4	=[	$deatha4,	pdude_diea5	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	pdude_diea5	=[	$deatha5,	pdude_diea6	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	pdude_diea6	=[	$deatha6,	pdude_diea7	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	pdude_diea7	=[	$deatha7,	pdude_diea8	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	pdude_diea8	=[	$deatha8,	pdude_diea9	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	pdude_diea9	=[	$deatha9,	pdude_diea10	] {self.nextthink = time + 0.02;ai_moveforeward(-2);};
void()	pdude_diea10	=[	$deatha10,	pdude_diea10	] {self.nextthink = time + 0.02;};
void()	pdude_diea11	=[	$deatha11,	pdude_diea11	] {/*self.nextthink = time + 0.02;*/};
// void()	pdude_diea12	=[	$deatha12,	pdude_diea13	] {self.nextthink = time + 0.02;};
// void()	pdude_diea13	=[	$deatha13,	pdude_diea14	] {self.nextthink = time + 0.02;};
// void()	pdude_diea14	=[	$deatha14,	pdude_diea14	] {};


void()	pdude_dieb1	=[	$deathb1,	pdude_dieb2	] 
{
  if (self.headshot == 1) self.skin = 2;
  self.nextthink = time + 0.03;
};
void()	pdude_dieb2	=[	$deathb2,	pdude_dieb3	] {self.nextthink = time + 0.03;};
void()	pdude_dieb3	=[	$deathb3,	pdude_dieb4	]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
};
void()	pdude_dieb4	=[	$deathb4,	pdude_dieb5	] {self.nextthink = time + 0.03;};
void()	pdude_dieb5	=[	$deathb5,	pdude_dieb6	] {self.nextthink = time + 0.03;};
void()	pdude_dieb6	=[	$deathb6,	pdude_dieb7	] {self.nextthink = time + 0.03;};
void()	pdude_dieb7	=[	$deathb7,	pdude_dieb8	] {self.nextthink = time + 0.03;};
void()	pdude_dieb8	=[	$deathb8,	pdude_dieb9	] {self.nextthink = time + 0.03;};
void()	pdude_dieb9	=[	$deathb9,	pdude_dieb10	] {self.nextthink = time + 0.03;};
void()	pdude_dieb10	=[	$deathb10,	pdude_dieb11	] {self.nextthink = time + 0.03;};
void()	pdude_dieb11	=[	$deathb11,	pdude_dieb11	] {};

void()	pdude_diec1	=[	$deathc1,	pdude_diec2	] 
{
  if (self.headshot == 1) self.skin = 2;
  self.nextthink = time + 0.03;
};
void()	pdude_diec2	=[	$deathc2,	pdude_diec3	] {self.nextthink = time + 0.03;};
void()	pdude_diec3	=[	$deathc3,	pdude_diec4	]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  ai_back(4);
};
void()	pdude_diec4	=[	$deathc4,	pdude_diec5	] {self.nextthink = time + 0.03;};
void()	pdude_diec5	=[	$deathc5,	pdude_diec6	] {self.nextthink = time + 0.03;};
void()	pdude_diec6	=[	$deathc6,	pdude_diec7	] {self.nextthink = time + 0.03;};
void()	pdude_diec7	=[	$deathc7,	pdude_diec8	] {self.nextthink = time + 0.03;};
void()	pdude_diec8	=[	$deathc8,	pdude_diec9	] {self.nextthink = time + 0.03;};
void()	pdude_diec9	=[	$deathc9,	pdude_diec10	] {self.nextthink = time + 0.03;};
void()	pdude_diec10	=[	$deathc10,	pdude_diec11	] {self.nextthink = time + 0.03;};
void()	pdude_diec11	=[	$deathc11,	pdude_diec12	] {self.nextthink = time + 0.03;};
void()	pdude_diec12	=[	$deathc12,	pdude_diec12	] {self.nextthink = time + 0.03;};



// void()	pdude_diee1	=[	$deathe1,	pdude_diee2	] {self.nextthink = time + 0.02;};
// void()	pdude_diee2	=[	$deathe2,	pdude_diee3	] {self.nextthink = time + 0.02;};
// void()	pdude_diee3	=[	$deathe3,	pdude_diee4	]
// {
  // self.nextthink = time + 0.02;
  // self.solid = SOLID_NOT;
  // ai_back(4);
// };
// void()	pdude_diee4	=[	$deathe4,	pdude_diee5	] {self.nextthink = time + 0.02;};
// void()	pdude_diee5	=[	$deathe5,	pdude_diee6	] {self.nextthink = time + 0.02;};
// void()	pdude_diee6	=[	$deathe6,	pdude_diee7	] {self.nextthink = time + 0.02;};
// void()	pdude_diee7	=[	$deathe7,	pdude_diee8	] {self.nextthink = time + 0.02;};
// void()	pdude_diee8	=[	$deathe8,	pdude_diee9	] {self.nextthink = time + 0.02;};
// void()	pdude_diee9	=[	$deathe9,	pdude_diee10	] {self.nextthink = time + 0.02;};
// void()	pdude_diee10	=[	$deathe10,	pdude_diee11	] {self.nextthink = time + 0.02;};
// void()  pdude_diee11    =[      $deathe11,      pdude_diee12    ] {self.nextthink = time + 0.02;};
// void()  pdude_diee12    =[      $deathe12,      pdude_diee12    ] {};

// void()	pdude_dief1	=[	$deathf1,	pdude_dief2	] {self.nextthink = time + 0.02;};
// void()	pdude_dief2	=[	$deathf2,	pdude_dief3	] {self.nextthink = time + 0.02;};
// void()	pdude_dief3	=[	$deathf3,	pdude_dief4	]
// {
	// self.nextthink = time + 0.02;
	// self.solid = SOLID_NOT;
	// ai_back(4);
// };
// void()	pdude_dief4	=[	$deathf4,	pdude_dief5	] {self.nextthink = time + 0.02;};
// void()	pdude_dief5	=[	$deathf5,	pdude_dief6	] {self.nextthink = time + 0.02;};
// void()	pdude_dief6	=[	$deathf6,	pdude_dief7	] {self.nextthink = time + 0.02;};
// void()	pdude_dief7	=[	$deathf7,	pdude_dief8	] {self.nextthink = time + 0.02;};
// void()	pdude_dief8	=[	$deathf8,	pdude_dief9	] {self.nextthink = time + 0.02;};
// void()	pdude_dief9	=[	$deathf9,	pdude_dief9	] {};


void() pdude_die =
{
	local float temp;
	self.ammo_9x18= self.PMclip;
	DropClip19x18();
	
	temp = random();
	if (self.health < -10)
	{
		if (self.headshot == 1)
		{
			ThrowHead ("models/npc/tors.md3",self.health);
			ThrowBlastedCorpse ("models/npc/nohead.md3",self.health);
			return ;
		}
		else 
		{
			if (temp < 0.333)
			{
				sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
				ThrowBlastedCorpse ("models/npc/corpse2.md3",self.health);
				return ;
			}
			else if(temp >= 0.333 && temp < 0.666)
			{
				sound (self,CHAN_VOICE,"npc/soldier_death1.wav",TRUE,ATTN_NORM);
				ThrowBlastedCorpse ("models/npc/corpse.md3",self.health);
				ThrowChunk ("models/npc/Rleg.md3",self.health);
				return ;
			}
			else
			{
				sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
				ThrowHead ("models/npc/tors.md3",self.health);
				ThrowChunk ("models/npc/Rleg.md3",self.health);
				ThrowChunk ("models/npc/Lleg.md3",self.health);
				return ;
			}
			
		}
	}



	if (self.duck == 1)
	{
		pdude_diea1 ();
		sound (self, CHAN_VOICE, "npc/soldier_death1.wav", 1, ATTN_NORM);     
	}
	// else if (self.headshot == -1)
	// {
		// pdude_diee1 ();
	// }
	else
	{
		if (temp < 0.333)
		{
			pdude_diea1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death2.wav", 1, ATTN_NORM);
		}
		else if ( (temp < 0.666) && (temp >= 0.333) )
		{
			pdude_dieb1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death3.wav", 1, ATTN_NORM);     
		}
		else 
		{
			pdude_diec1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death1.wav", 1 , ATTN_NORM);
		}
  
	}
};


/*QUAKED pdude_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/

void() monster_light =
{	
	if (deathmatch)
	{
		remove(self);
		return;
	}

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
    setmodel(self, "models/npc/light.md3");

	setsize (self, '-9 -9 -24', '9 9 34');
	self.health = 100;
    self.PMclip = 20;
	self.th_stand = pdude_stand1;
	self.th_walk = pdude_walk1;
	self.th_run = pdude_run1;
	self.th_missile = pdude_drawa1;
    self.th_melee = pdude_melee1;
	self.th_pain = pdude_pain;
	self.th_die = pdude_die;

	walkmonster_start ();
};


 