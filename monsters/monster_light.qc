/*
==============================================================================

PRISON monster_heavy

==============================================================================
*/

$cd id1/models/monster_light
$origin 0 -6 -24
$base base		
$skin skin


$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17 
$frame stand18 stand19 stand20 stand21 stand22 // 1-22

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16 walk17 walk18 walk19
$frame walk20 walk21 walk22 walk23 walk24 walk25 walk26 walk27 walk28
$frame walk29 walk30 // 23-52

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 //53-61

$frame firec1 firec2 firec3 firec4 firec5 firec6 firec7 firec8 firec9 firec10 // 62-74
$frame firec11 firec12 firec13

$frame drawc1 drawc2 drawc3 drawc4 drawc5 drawc6 drawc7 drawc8 drawc9 //75-83

$frame fireb1 fireb2	//84-85

$frame drawb1 drawb2 drawb3 drawb4 drawb5 drawb6 drawb7 drawb8 drawb9	//86-94

$frame firea1 firea2 firea3 firea4 firea5 firea6 firea7 firea8	//95-102

$frame drawa1 drawa2 drawa3 drawa4 drawa5 drawa6 drawa7 //103-109

$frame grenade1 grenade2 grenade3 grenade4 grenade5 grenade6 grenade7 grenade8 grenade9 //110-125
$frame grenade10 grenade11 grenade12 grenade13 grenade14 grenade15 grenade16

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 //126-139
$frame load11 load12 load13 load14

$frame melee1 melee2 melee3 melee4 melee5 melee6 melee7 melee8 melee9 melee10 //140-149 fix

$frame paind1 paind2 paind3 paind4 paind5	//150-154

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 //155-160

$frame painb1 painb2 painb3 painb4 painb5 //162-166

$frame paina1 paina2 paina3 paina4 paina5 //167-171

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 //172-183

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11 //184-194

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 //195-204

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7 deathd8
$frame deathd9 deathd10 deathd11 //205-215

$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9 leap10 leap11 leap12
$frame leap13 leap14	//216-230

$frame roll1 roll2 roll3 roll4 roll5 roll6 roll7 roll8 roll9 roll10 roll11 roll12 roll13
$frame roll14 roll15 roll16 roll17 roll18 roll19 roll20 roll21 roll22 roll23 roll24
$frame roll25 roll26 roll27

/*
==============================================================================
SOLDIER CODE
==============================================================================
*/

void() monster_light_fire;
void() monster_lightFireGrenade;

void (float dist) ai_moveforeward =
{
	walkmove (self.angles_y, dist);
};

void()      monster_light_grenade1 = [ $grenade1, monster_light_grenade2] {ai_face();};
void()      monster_light_grenade2 = [ $grenade2, monster_light_grenade3] {ai_face();};
void()      monster_light_grenade3 = [ $grenade3, monster_light_grenade4] {ai_face();};
void()      monster_light_grenade4 = [ $grenade4, monster_light_grenade5] {ai_face();};
void()      monster_light_grenade5 = [ $grenade5, monster_light_grenade6] {ai_face();};
void()      monster_light_grenade6 = [ $grenade6, monster_light_grenade7] {ai_face();};
void()      monster_light_grenade7 = [ $grenade7, monster_light_grenade8] {ai_face();};
void()      monster_light_grenade8 = [ $grenade8, monster_light_grenade9] {ai_face();};
void()      monster_light_grenade9 = [ $grenade9, monster_light_grenade10] {ai_face();};
void()      monster_light_grenade10 = [ $grenade10, monster_light_grenade11] {ai_face();};
void()      monster_light_grenade11 = [ $grenade11, monster_light_grenade12] {ai_face();};
void()      monster_light_grenade12 = [ $grenade12, monster_light_grenade13] {ai_face();monster_lightFireGrenade();};
void()      monster_light_grenade13 = [ $grenade13, monster_light_grenade14] {ai_face();};
void()      monster_light_grenade14 = [ $grenade14, monster_light_grenade15] {ai_face();};
void()      monster_light_grenade15 = [ $grenade15, monster_light_grenade16] {ai_face();};
void()      monster_light_grenade16 = [ $grenade16, monster_light_run1] {ai_face();};

void()      monster_light_straferight1 = [ $firec1,     monster_light_straferight2] {ai_face(); self.duck =1;};
void()      monster_light_straferight2 = [ $firec2,   monster_light_straferight3] {ai_face();};
void()      monster_light_straferight3 = [ $firec3,   monster_light_straferight4] {ai_face();};
void()      monster_light_straferight4 = [ $firec4,   monster_light_straferight5] {ai_face();};
void()      monster_light_straferight5 = [ $firec5,   monster_light_straferight6] {ai_face();};
void()      monster_light_straferight6 = [ $firec6,   monster_light_straferight7] {ai_face();ai_strafeleft(12.5);monster_light_fire();};
void()      monster_light_straferight7 = [ $firec7,   monster_light_straferight8] {ai_face();ai_strafeleft(4);};
void()      monster_light_straferight8 = [ $firec8,   monster_light_straferight9] {ai_face();ai_strafeleft(5);monster_light_fire();};
void()      monster_light_straferight9 = [ $firec9,   monster_light_straferight10] {ai_face();ai_strafeleft(3);};
void()      monster_light_straferight10 = [ $firec10,   monster_light_straferight11] {ai_face();ai_strafeleft(3);monster_light_fire();};
void()      monster_light_straferight11 = [ $firec11,   monster_light_straferight12] {ai_face();ai_strafeleft(5);};
void()      monster_light_straferight12 = [ $firec12,   monster_light_straferight13] {ai_face();ai_strafeleft(3);monster_light_fire();};
void()      monster_light_straferight13 = [ $firec13,   monster_light_straferight14] {ai_face();ai_strafeleft(4);};
// void()      monster_light_straferight14 = [ $firec14,   monster_light_straferight15] {ai_face();ai_strafeleft(4);monster_light_fire();};
// void()      monster_light_straferight15 = [ $firec15,   monster_light_straferight16] {ai_face();ai_strafeleft(4);};
// void()      monster_light_straferight16 = [ $firec16,   monster_light_straferight17] {ai_face();ai_strafeleft(4);monster_light_fire();};
// void()      monster_light_straferight17 = [ $firec17,   monster_light_straferight18] {ai_face();ai_strafeleft(3);};
//void()      monster_light_straferight18 = [ $firec4,   monster_light_straferight19] {ai_face();ai_straferight(6);};
void()      monster_light_straferight14 = [ $firec4,   monster_light_straferight19] {ai_face();ai_straferight(6);};
void()      monster_light_straferight19 = [ $firec3,   monster_light_straferight20] {ai_face();};
void()      monster_light_straferight20 = [ $firec2,   monster_light_run1] {ai_face();};

void()	monster_light_stand1	=[	$stand1,	monster_light_stand2	] {ai_stand();};
void()	monster_light_stand2	=[	$stand2,	monster_light_stand3	] {ai_stand();};
void()	monster_light_stand3	=[	$stand3,	monster_light_stand4	] {ai_stand();};
void()	monster_light_stand4	=[	$stand4,	monster_light_stand5	] {ai_stand();};
void()	monster_light_stand5	=[	$stand5,	monster_light_stand6	] {ai_stand();};
void()	monster_light_stand6	=[	$stand6,	monster_light_stand7	] {ai_stand();};
void()	monster_light_stand7	=[	$stand7,	monster_light_stand8	] {ai_stand();};
void()	monster_light_stand8	=[	$stand8,	monster_light_stand9	] {ai_stand();};
void()	monster_light_stand9	=[	$stand9,	monster_light_stand10	] {ai_stand();};
void()	monster_light_stand10	=[	$stand10,	monster_light_stand11	] {ai_stand();};
void()	monster_light_stand11	=[	$stand11,	monster_light_stand12	] {ai_stand();};
void()	monster_light_stand12	=[	$stand12,	monster_light_stand13	] {ai_stand();};
void()	monster_light_stand13	=[	$stand13,	monster_light_stand14	] {ai_stand();};
void()	monster_light_stand14	=[	$stand14,	monster_light_stand15	] {ai_stand();};
void()	monster_light_stand15	=[	$stand15,	monster_light_stand16	] {ai_stand();};
void()	monster_light_stand16	=[	$stand16,	monster_light_stand17	] {ai_stand();};
void()	monster_light_stand17	=[	$stand17,	monster_light_stand18	] {ai_stand();};
void()	monster_light_stand18	=[	$stand18,	monster_light_stand19	] {ai_stand();};
void()	monster_light_stand19 	=[	$stand19,	monster_light_stand20	] {ai_stand();};
void()	monster_light_stand20	=[	$stand20,	monster_light_stand21	] {ai_stand();};
void()	monster_light_stand21	=[	$stand21,	monster_light_stand22	] {ai_stand();};
void()	monster_light_stand22	=[	$stand22,	monster_light_stand1	] {ai_stand();};

void()	monster_light_walk1	=[	$walk1,	monster_light_walk2	] {};
void()	monster_light_walk2	=[	$walk2,	monster_light_walk3	] {ai_walk(1);};
void()	monster_light_walk3	=[	$walk3,	monster_light_walk4	] {ai_walk(1);};
void()	monster_light_walk4	=[	$walk4,	monster_light_walk5	] {ai_walk(1);};
void()	monster_light_walk5	=[	$walk5,	monster_light_walk6	] {ai_walk(2);};
void()	monster_light_walk6	=[	$walk6,	monster_light_walk7	] {ai_walk(5);};
void()	monster_light_walk7	=[	$walk7,	monster_light_walk8	] {ai_walk(5);};
void()	monster_light_walk8	=[	$walk8,	monster_light_walk9	] {ai_walk(4);};
void()	monster_light_walk9	=[	$walk9,	monster_light_walk10	] {ai_walk(-1);};
void()	monster_light_walk10	=[	$walk10,	monster_light_walk11	] {ai_walk(0);};
void()	monster_light_walk11	=[	$walk11,	monster_light_walk12	] {ai_walk(0);};
void()	monster_light_walk12	=[	$walk12,	monster_light_walk13	] {ai_walk(0);};
void()	monster_light_walk13	=[	$walk13,	monster_light_walk14	] {ai_walk(1);};
void()	monster_light_walk14	=[	$walk14,	monster_light_walk15	] {ai_walk(8);};
void()	monster_light_walk15	=[	$walk15,	monster_light_walk16	] {ai_walk(7);};
void()	monster_light_walk16	=[	$walk16,	monster_light_walk1	] {ai_walk(6);};

void()	monster_light_run1	=[	$run1,		monster_light_run2	] 
{
  self.duck = 0;
  setsize (self, '-9 -9 -24', '9 9 34');
  //self.pistolClip = 8;
};
void()	monster_light_run2	=[	$run2,		monster_light_run3	] {ai_run(5);};
void()	monster_light_run3	=[	$run3,		monster_light_run4	] {ai_run(3);};
void()	monster_light_run4	=[	$run4,		monster_light_run5	] {ai_run(13);};
void()	monster_light_run5	=[	$run5,		monster_light_run6	] {ai_run(7);};
void()	monster_light_run6	=[	$run6,		monster_light_run7	] {ai_run(8);};
void()	monster_light_run7	=[	$run7,		monster_light_run8	] {ai_run(7);};
void()	monster_light_run8	=[	$run8,		monster_light_run9	] {ai_run(10);};
void()	monster_light_run9	=[	$run9,		monster_light_run1	] {ai_run(7);};

void()      monster_light_load1   =[    $load1,      monster_light_load2] {self.pistolClip = 20;};
void()      monster_light_load2   =[    $load2,      monster_light_load3] {};
void()      monster_light_load3   =[    $load3,      monster_light_load4] {};
void()      monster_light_load4   =[    $load4,      monster_light_load5] {sound(self,CHAN_WEAPON,"weapons/rifle/clipout.wav",1,ATTN_NORM);};
void()      monster_light_load5   =[    $load5,      monster_light_load6] {};
void()      monster_light_load6   =[    $load6,      monster_light_load7] {};
void()      monster_light_load7   =[    $load7,      monster_light_load8] {};
void()      monster_light_load8   =[    $load8,      monster_light_load9] {};
void()      monster_light_load9   =[    $load9,      monster_light_load10] {};
void()      monster_light_load10   =[    $load10,      monster_light_load11] {};
void()      monster_light_load11   =[    $load11,      monster_light_load12] {};
void()      monster_light_load12   =[    $load12,      monster_light_load13] {};
void()      monster_light_load13   =[    $load13,      monster_light_load14] {};
void()      monster_light_load14   =[    $load14,      monster_light_run1] {sound(self,CHAN_WEAPON,"weapons/rifle/clipin.wav",1,ATTN_NORM);};


void() monster_light_drawa1;

void()      monster_light_leapleft1 = [  $leap1, monster_light_leapleft2 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft2 = [  $leap2, monster_light_leapleft3 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft3 = [  $leap3, monster_light_leapleft4 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft4 = [  $leap4, monster_light_leapleft5 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft5 = [  $leap5, monster_light_leapleft6 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft6 = [  $leap6, monster_light_leapleft7 ] {self.nextthink = time + 0.03;ai_strafeleft(8);};
void()      monster_light_leapleft7 = [  $leap7, monster_light_leapleft8 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      monster_light_leapleft8 = [  $leap8, monster_light_leapleft9 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      monster_light_leapleft9 = [  $leap9, monster_light_leapleft10 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      monster_light_leapleft10 = [  $leap10, monster_light_leapleft11 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      monster_light_leapleft11 = [  $leap11, monster_light_leapleft12 ] {self.nextthink = time + 0.03;ai_strafeleft(4);};
void()      monster_light_leapleft12 = [  $leap12, monster_light_leapleft13 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft13 = [  $leap13, monster_light_leapleft14 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapleft14 = [  $leap14, monster_light_drawa2 ] {};

void()      monster_light_leapright1 = [  $leap1, monster_light_leapright2 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright2 = [  $leap2, monster_light_leapright3 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright3 = [  $leap3, monster_light_leapright4 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright4 = [  $leap4, monster_light_leapright5 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright5 = [  $leap5, monster_light_leapright6 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright6 = [  $leap6, monster_light_leapright7 ] {ai_straferight(8);self.nextthink = time + 0.03;};
void()      monster_light_leapright7 = [  $leap7, monster_light_leapright8 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      monster_light_leapright8 = [  $leap8, monster_light_leapright9 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      monster_light_leapright9 = [  $leap9, monster_light_leapright10 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      monster_light_leapright10 = [  $leap10, monster_light_leapright11 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      monster_light_leapright11 = [  $leap11, monster_light_leapright12 ] {ai_straferight(4);self.nextthink = time + 0.03;};
void()      monster_light_leapright12 = [  $leap12, monster_light_leapright13 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright13 = [  $leap13, monster_light_leapright14 ] {self.nextthink = time + 0.03;};
void()      monster_light_leapright14 = [  $leap14, monster_light_drawa2 ] {};

//void() monster_light_fired1;

void()      monster_light_roll1 = [ $roll1 , monster_light_roll2 ] {self.nextthink = time + 0.03;};
void()      monster_light_roll2 = [ $roll2 , monster_light_roll3 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      monster_light_roll3 = [ $roll3 , monster_light_roll4 ] {ai_moveforeward(2);self.nextthink = time + 0.03;};
void()      monster_light_roll4 = [ $roll4 , monster_light_roll5 ] {ai_moveforeward(2);self.nextthink = time + 0.03;};
void()      monster_light_roll5 = [ $roll5 , monster_light_roll6 ] {ai_moveforeward(1);self.nextthink = time + 0.03;};
void()      monster_light_roll6 = [ $roll6 , monster_light_roll7 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      monster_light_roll7 = [ $roll7 , monster_light_roll8 ] {ai_moveforeward(7);self.nextthink = time + 0.03;};
void()      monster_light_roll8 = [ $roll8 , monster_light_roll9 ] {ai_moveforeward(8);self.nextthink = time + 0.03;};
void()      monster_light_roll9 = [ $roll9 , monster_light_roll10 ] {ai_moveforeward(6);setsize (self, '-23 -12 -25', '11 12 18');self.duck = 1;self.nextthink = time + 0.03;};
void()      monster_light_roll10 = [ $roll10 , monster_light_roll11 ] {ai_moveforeward(6);self.nextthink = time + 0.03;};
void()      monster_light_roll11 = [ $roll11 , monster_light_roll12 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll12 = [ $roll12 , monster_light_roll13 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll13 = [ $roll13 , monster_light_roll14 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll14 = [ $roll14 , monster_light_roll15 ] {ai_moveforeward(6);self.nextthink = time + 0.03;};
void()      monster_light_roll15 = [ $roll15 , monster_light_roll16 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll16 = [ $roll16 , monster_light_roll17 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll17 = [ $roll17 , monster_light_roll18 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll18 = [ $roll18 , monster_light_roll19 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll19 = [ $roll19 , monster_light_roll20 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll20 = [ $roll20 , monster_light_roll21 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll21 = [ $roll21 , monster_light_roll22 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll22 = [ $roll22 , monster_light_roll23 ] {ai_moveforeward(5);self.nextthink = time + 0.03;};
void()      monster_light_roll23 = [ $roll23 , monster_light_roll24 ] {ai_moveforeward(3);self.nextthink = time + 0.03;};
void()      monster_light_roll24 = [ $roll24 , monster_light_roll25 ] {ai_moveforeward(2.5);self.nextthink = time + 0.03;};
void()      monster_light_roll25 = [ $roll25 , monster_light_roll26 ] {ai_moveforeward(-0.5);self.nextthink = time + 0.03;};
void()      monster_light_roll26 = [ $roll26 , monster_light_roll27 ] {ai_moveforeward(-1);self.nextthink = time + 0.03;};
void()      monster_light_roll27 = [ $roll27 , monster_light_straferight1 ] {ai_moveforeward(-0.5);self.nextthink = time + 0.03;};

// void()      monster_light_fired1 = [ $fired1 , monster_light_fired2  ]
// {
 // ai_face();
 // monster_light_fire();
// };

// void()      monster_light_fired2 = [ $fired2 , monster_light_fired3 ] 
// { 
 // ai_face();
// };

// void()      monster_light_fired3 = [ $fired3 , monster_light_run1 ] 
// { 
 // ai_face();
 // SUB_CheckRefire (monster_light_fired1);
 // if (self.pistolClip <= 0)
   // {
     // self.think = monster_light_load1;
   // }
// };

void()      monster_light_firea1 = [ $firea1 , monster_light_firea2 ] 
{ 
	ai_face();
	monster_light_fire();
};

void()      monster_light_firea2 = [ $firea2 , monster_light_firea3 ] 
{ 
	ai_face();
	monster_light_fire();
};

void()      monster_light_firea3 = [ $firea3 , monster_light_run1 ] 
{ 
	ai_face();
	SUB_CheckRefire (monster_light_firea1);
	if (self.pistolClip <= 0) self.think = monster_light_load1;
	else monster_light_fire();
};

void() monster_light_drawb1;

void()      monster_light_drawa1   =[    $drawa1,     monster_light_drawa2   ] 
{
	local float temp;

	temp = random();
	ai_face();
	
	/*** Check to see if grenades are throwable ***/
	if (((self.absmax_z - self.enemy.absmax_z) > -50) && (vlen(self.enemy.origin - self.origin) > 500) && random () < 0.5 )
	{
		self.think = monster_light_grenade1;
		self.attack_finished = time + 1.3;
	}   
	else
	{
		if (temp < 0.35)
		{
			self.think = monster_light_drawa1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.8) && (temp >= 0.35))
		{
			self.think = monster_light_drawb1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.9) && (temp >= 0.8)) 
		{ 
			self.think = monster_light_roll1;
			self.nextthink = time + 0.03;
		}
		else if ((temp < 0.95) && (temp >= 0.9))
		{
			self.think = monster_light_leapright1;
			self.nextthink = time + 0.03;
		}
		else if (temp >= 0.95)
		{
			self.think = monster_light_leapleft1;
			self.nextthink = time + 0.03;
		}
	}

	/*** Check to see if reload is necessary ***/
	if (self.pistolClip <= 0) self.think = monster_light_load1;

	/*** Check to see if someone is in front of me ***/
	traceline(self.origin,self.enemy.origin,0,self);
	if ( (trace_ent.classname == "monster_heavy") || (trace_ent.classname == "monster_light") )
	{
	if (random() < 0.50)self.think = monster_light_leapright1;
	else self.think = monster_light_leapleft1;
	}

};

void()      monster_light_drawa2   =[    $drawa2,     monster_light_drawa3   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawa3   =[    $drawa3,     monster_light_drawa4   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawa4   =[    $drawa4,     monster_light_drawa5   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawa5   =[    $drawa5,     monster_light_drawa6   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawa6   =[    $drawa6,     monster_light_drawa7   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawa7   =[    $drawa7,     monster_light_firea1   ] {ai_face();self.nextthink = time + 0.03;};

/************************* END OF DRAWA  ************************/

void()      monster_light_fireb1         =[    $fireb1,     monster_light_fireb2   ] 
{ 
	ai_face();
	monster_light_fire();
};

void()      monster_light_fireb2         =[    $fireb2,     monster_light_fireb3   ] 
{ 
	ai_face();
	monster_light_fire();
};


void()      monster_light_fireb3         =[    $fireb1,     monster_light_run1     ] 
{ 
	ai_face();
	self.nextthink = time + 0.02;
	SUB_CheckRefire (monster_light_fireb1);
	if (self.pistolClip <= 0) self.think = monster_light_load1;
	else monster_light_fire();
};

void()      monster_light_drawb1   =[    $drawb1,     monster_light_drawb2   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawb2   =[    $drawb2,     monster_light_drawb3   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawb3   =[    $drawb3,     monster_light_drawb4   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawb4   =[    $drawb4,     monster_light_drawb5   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawb5   =[    $drawb5,     monster_light_drawb6   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_light_drawb6   =[    $drawb6,     monster_light_fireb1   ] 
 {
  ai_face();
  self.nextthink = time + 0.03;
  if (random() < 0.5)
   self.think = monster_light_straferight1;
 };

/************************** END OF DRAWB *******************************/




void()	monster_light_paina1	=[	$paina1,		monster_light_paina2	] {};
void()	monster_light_paina2	=[	$paina2,		monster_light_paina3	] {};
void()	monster_light_paina3	=[	$paina3,		monster_light_paina4	] {};
void()	monster_light_paina4	=[	$paina4,		monster_light_paina5	] {};
void()	monster_light_paina5	=[	$paina5,		monster_light_drawa1	] {};
//void()	monster_light_paina6	=[	$paina6,		monster_light_drawa1	] {};

void()	monster_light_painb1	=[	$painb1,	monster_light_painb2	] {};
void()	monster_light_painb2	=[	$painb2,	monster_light_painb3	] {};
void()	monster_light_painb3	=[	$painb3,	monster_light_painb4	] {};
void()	monster_light_painb4	=[	$painb4,	monster_light_painb5	] {};
void()	monster_light_painb5	=[	$painb5,	monster_light_drawa1	] {};
// void()	monster_light_painb6	=[	$painb6,	monster_light_painb7	] {};
// void()	monster_light_painb7	=[	$painb7,	monster_light_painb8	] {};
// void()	monster_light_painb8	=[	$painb8,	monster_light_drawa1	] {};

void()	monster_light_painc1	=[	$painc1,	monster_light_painc2	] {};
void()	monster_light_painc2	=[	$painc2,	monster_light_painc3	] {};
void()	monster_light_painc3	=[	$painc3,	monster_light_painc4	] {};
void()	monster_light_painc4	=[	$painc4,	monster_light_painc5	] {};
void()	monster_light_painc5	=[	$painc5,	monster_light_painc6	] {};
void()	monster_light_painc6	=[	$painc6,	monster_light_drawa1	] {};

void()	monster_light_paind1	=[	$paind1,	monster_light_paind2	] {};
void()	monster_light_paind2	=[	$paind2,	monster_light_paind3	] {};
void()	monster_light_paind3	=[	$paind3,	monster_light_paind4	] {};
void()	monster_light_paind4	=[	$paind4,	monster_light_paind5	] {};
void()	monster_light_paind5	=[	$paind5,	monster_light_drawa1	] {};
//void()	monster_light_paind6	=[	$paind6,	monster_light_drawa1	] {};

// void()	monster_light_paine1	=[	$paine1,	monster_light_paine2	] {};
// void()	monster_light_paine2	=[	$paine2,	monster_light_paine3	] {};
// void()	monster_light_paine3	=[	$paine3,	monster_light_paine4	] {};
// void()	monster_light_paine4	=[	$paine4,	monster_light_paine5	] {};
// void()	monster_light_paine5	=[	$paine5,	monster_light_paine6	] {};
// void()	monster_light_paine6	=[	$paine6,	monster_light_drawa1	] {};

void()	monster_light_Melee =
{
	local	float	ldmg;
	local vector	delta;
	
	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100) return;
	if (!CanDamage (self.enemy, self)) return;
		
    sound (self, CHAN_WEAPON, "weapons/knife/hit.wav", 1, ATTN_NORM);
	ldmg = 10 + 5*random();
	T_Damage (self.enemy, self, self, ldmg);	

	makevectors (self.angles);
};

void() monster_lightFireGrenade =
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

void(entity attacker, float damage)	monster_light_pain =
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
          monster_light_paina1 ();
         }
      else
         {
          self.pain_finished = time + 0.1;
          sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);
          monster_light_painb1 ();
         }
     }
    else
     {
		if (r < 0.333)
		{
			monster_light_painc1 ();
			sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);
		}
		
		monster_light_paind1 ();
        sound(self,CHAN_BODY,"npc/soldier_pain1.wav",1,ATTN_NORM);

     }
};

void() monster_light_fire =
{
	local	vector	dir;
	local	entity	en;
	local	vector	src;
	
	ai_face();

// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	dir = (en.origin + '0 0 -8') - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	//monster_heavyFire(17,dir);
	sound (self, CHAN_WEAPON, "weapons/pistol/pm.wav", 1, ATTN_NORM);
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
			WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST,TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST,trace_endpos_x);
			WriteCoord (MSG_BROADCAST,trace_endpos_y);
			WriteCoord (MSG_BROADCAST,trace_endpos_z);
			CreateHitSound(trace_endpos);
			// particle (trace_endpos,'3 2 7',192,TE_WIZSPIKE);
			// particle (trace_endpos,'7 6 8',192,TE_WIZSPIKE);
						
		}    
	}
    self.pistolClip = self.pistolClip - 1;
};

void()      monster_light_melee1 = [   $melee1,   monster_light_melee2 ] {ai_face();};
void()      monster_light_melee2 = [   $melee2,   monster_light_melee3 ] {ai_face();};
void()      monster_light_melee3 = [   $melee3,   monster_light_melee4 ] {ai_face();};
void()      monster_light_melee4 = [   $melee4,   monster_light_melee5 ] {ai_face();};
void()      monster_light_melee5 = [   $melee5,   monster_light_melee6 ] {ai_face();};
void()      monster_light_melee6 = [   $melee6,   monster_light_melee7 ] {ai_face();monster_light_Melee ();};
void()      monster_light_melee7 = [   $melee7,   monster_light_melee8 ] {ai_face();monster_light_Melee ();};
void()      monster_light_melee8 = [   $melee8,   monster_light_melee9 ] {ai_face();};
void()      monster_light_melee9 = [   $melee9,   monster_light_melee10 ] {ai_face();};
void()      monster_light_melee10 = [   $melee10,   monster_light_run1 ] {ai_face();};

void()	monster_light_diea1	=[	$deatha1,	monster_light_diea2	] {self.nextthink = time + 0.02;};
void()	monster_light_diea2	=[	$deatha2,	monster_light_diea3	] {self.nextthink = time + 0.02; ai_moveforeward(-4);};
void()	monster_light_diea3	=[	$deatha3,	monster_light_diea4	] 
{
  ai_moveforeward(-4);
  self.solid = SOLID_NOT;
  self.nextthink = time + 0.02;
  ai_back(4);
};
void()	monster_light_diea4	=[	$deatha4,	monster_light_diea5	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	monster_light_diea5	=[	$deatha5,	monster_light_diea6	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	monster_light_diea6	=[	$deatha6,	monster_light_diea7	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	monster_light_diea7	=[	$deatha7,	monster_light_diea8	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	monster_light_diea8	=[	$deatha8,	monster_light_diea9	] {self.nextthink = time + 0.02;ai_moveforeward(-4);};
void()	monster_light_diea9	=[	$deatha9,	monster_light_diea10	] {self.nextthink = time + 0.02;ai_moveforeward(-2);};
void()	monster_light_diea10	=[	$deatha10,	monster_light_diea10	] {self.nextthink = time + 0.02;};
//void()	monster_light_diea11	=[	$deatha11,	monster_light_diea11	] {/*self.nextthink = time + 0.02;*/};
// void()	monster_light_diea12	=[	$deatha12,	monster_light_diea13	] {self.nextthink = time + 0.02;};
// void()	monster_light_diea13	=[	$deatha13,	monster_light_diea14	] {self.nextthink = time + 0.02;};
// void()	monster_light_diea14	=[	$deatha14,	monster_light_diea14	] {};


void()	monster_light_dieb1	=[	$deathb1,	monster_light_dieb2	] { self.nextthink = time + 0.03;};
void()	monster_light_dieb2	=[	$deathb2,	monster_light_dieb3	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb3	=[	$deathb3,	monster_light_dieb4	]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
};
void()	monster_light_dieb4	=[	$deathb4,	monster_light_dieb5	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb5	=[	$deathb5,	monster_light_dieb6	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb6	=[	$deathb6,	monster_light_dieb7	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb7	=[	$deathb7,	monster_light_dieb8	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb8	=[	$deathb8,	monster_light_dieb9	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb9	=[	$deathb9,	monster_light_dieb10	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb10	=[	$deathb10,	monster_light_dieb11	] {self.nextthink = time + 0.03;};
void()	monster_light_dieb11	=[	$deathb11,	monster_light_dieb11	] {};

void()	monster_light_diec1	=[	$deathc1,	monster_light_diec2	] { self.nextthink = time + 0.03;};
void()	monster_light_diec2	=[	$deathc2,	monster_light_diec3	] {self.nextthink = time + 0.03;};
void()	monster_light_diec3	=[	$deathc3,	monster_light_diec4	]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  ai_back(4);
};
void()	monster_light_diec4	=[	$deathc4,	monster_light_diec5	] {self.nextthink = time + 0.03;};
void()	monster_light_diec5	=[	$deathc5,	monster_light_diec6	] {self.nextthink = time + 0.03;};
void()	monster_light_diec6	=[	$deathc6,	monster_light_diec7	] {self.nextthink = time + 0.03;};
void()	monster_light_diec7	=[	$deathc7,	monster_light_diec8	] {self.nextthink = time + 0.03;};
void()	monster_light_diec8	=[	$deathc8,	monster_light_diec9	] {self.nextthink = time + 0.03;};
void()	monster_light_diec9	=[	$deathc9,	monster_light_diec10	] {self.nextthink = time + 0.03;};
void()	monster_light_diec10	=[	$deathc10,	monster_light_diec11	] {self.nextthink = time + 0.03;};
void()	monster_light_diec11	=[	$deathc11,	monster_light_diec12	] {self.nextthink = time + 0.03;};
void()	monster_light_diec12	=[	$deathc12,	monster_light_diec12	] {self.nextthink = time + 0.03;};



// void()	monster_light_diee1	=[	$deathe1,	monster_light_diee2	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee2	=[	$deathe2,	monster_light_diee3	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee3	=[	$deathe3,	monster_light_diee4	]
// {
  // self.nextthink = time + 0.02;
  // self.solid = SOLID_NOT;
  // ai_back(4);
// };
// void()	monster_light_diee4	=[	$deathe4,	monster_light_diee5	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee5	=[	$deathe5,	monster_light_diee6	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee6	=[	$deathe6,	monster_light_diee7	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee7	=[	$deathe7,	monster_light_diee8	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee8	=[	$deathe8,	monster_light_diee9	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee9	=[	$deathe9,	monster_light_diee10	] {self.nextthink = time + 0.02;};
// void()	monster_light_diee10	=[	$deathe10,	monster_light_diee11	] {self.nextthink = time + 0.02;};
// void()  monster_light_diee11    =[      $deathe11,      monster_light_diee12    ] {self.nextthink = time + 0.02;};
// void()  monster_light_diee12    =[      $deathe12,      monster_light_diee12    ] {};

// void()	monster_light_dief1	=[	$deathf1,	monster_light_dief2	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief2	=[	$deathf2,	monster_light_dief3	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief3	=[	$deathf3,	monster_light_dief4	]
// {
	// self.nextthink = time + 0.02;
	// self.solid = SOLID_NOT;
	// ai_back(4);
// };
// void()	monster_light_dief4	=[	$deathf4,	monster_light_dief5	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief5	=[	$deathf5,	monster_light_dief6	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief6	=[	$deathf6,	monster_light_dief7	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief7	=[	$deathf7,	monster_light_dief8	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief8	=[	$deathf8,	monster_light_dief9	] {self.nextthink = time + 0.02;};
// void()	monster_light_dief9	=[	$deathf9,	monster_light_dief9	] {};


void() monster_light_die =
{
	local float temp;
	self.ammoPistol= self.pistolClip;
	DropClip19x18();
	
	temp = random();
	if (self.health < -10)
	{
		if (self.hitbox == 1)
		{
			sound (self,CHAN_VOICE,"npc/soldier_death1.wav",TRUE,ATTN_NORM);
			ThrowBlastedCorpse ("models/npc/nohead.md3",self.health);
			return;
		}
		else if(self.hitbox == 0)
		{
			if (temp < 0.5)
			{
				sound (self,CHAN_VOICE,"npc/soldier_death1.wav",TRUE,ATTN_NORM);
				ThrowBlastedCorpse ("models/npc/corpse.md3",self.health);
				ThrowChunk ("models/npc/Rleg.md3",self.health);
				return;
			}
			else
			{
				sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
				ThrowHead ("models/npc/tors.md3",self.health);
				ThrowChunk ("models/npc/Rleg.md3",self.health);
				ThrowChunk ("models/npc/Lleg.md3",self.health);
				return;
			}
		}
		else 
		{
			if (temp < 0.5)
			{
				sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
				ThrowBlastedCorpse ("models/npc/corpse2.md3",self.health);
				return;
			}
			else
			{
				sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
				ThrowHead ("models/npc/tors.md3",self.health);
				ThrowChunk ("models/npc/Rleg.md3",self.health);
				ThrowChunk ("models/npc/Lleg.md3",self.health);
				return;
			}
		}
	}

	if (self.duck == 1)
	{
		monster_light_diea1 ();
		sound (self, CHAN_VOICE, "npc/soldier_death1.wav", 1, ATTN_NORM);     
	}
	else
	{
		if (temp < 0.333)
		{
			monster_light_diea1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death2.wav", 1, ATTN_NORM);
		}
		else if ( (temp < 0.666) && (temp >= 0.333) )
		{
			monster_light_dieb1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death3.wav", 1, ATTN_NORM);     
		}
		else 
		{
			monster_light_diec1 ();
			sound (self, CHAN_VOICE, "npc/soldier_death1.wav", 1 , ATTN_NORM);
		}
	}
};


/*QUAKED monster_light_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
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
	self.health = 75;
    self.pistolClip = 20;
	self.th_stand = monster_light_stand1;
	self.th_walk = monster_light_walk1;
	self.th_run = monster_light_run1;
	self.th_missile = monster_light_drawa1;
    self.th_melee = monster_light_melee1;
	self.th_pain = monster_light_pain;
	self.th_die = monster_light_die;

	walkmonster_start ();
};

