$cd id1/models/monster_heavy
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

$frame lstrafe1 lstrafe2 lstrafe3 lstrafe4 lstrafe5 lstrafe6 lstrafe7

$frame rstrafe1 rstrafe2 rstrafe3 rstrafe4 rstrafe5 rstrafe6 rstrafe7

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





















/*
==============================================================================
SOLDIER CODE
==============================================================================
*/

void (float dist) ai_straferight =
{
	walkmove (self.angles_y+90, dist);
};

void (float dist) ai_strafeleft =
{
	walkmove ( (self.angles_y+270), dist);
};

void() monster_heavy_fire;
void() monster_heavyFireGrenade;

void()      monster_heavy_grenade1 = [ $grenade1, monster_heavy_grenade2] {ai_face();};
void()      monster_heavy_grenade2 = [ $grenade2, monster_heavy_grenade3] {ai_face();};
void()      monster_heavy_grenade3 = [ $grenade3, monster_heavy_grenade4] {ai_face();};
void()      monster_heavy_grenade4 = [ $grenade4, monster_heavy_grenade5] {ai_face();};
void()      monster_heavy_grenade5 = [ $grenade5, monster_heavy_grenade6] {ai_face();};
void()      monster_heavy_grenade6 = [ $grenade6, monster_heavy_grenade7] {ai_face();};
void()      monster_heavy_grenade7 = [ $grenade7, monster_heavy_grenade8] {ai_face();};
void()      monster_heavy_grenade8 = [ $grenade8, monster_heavy_grenade9] {ai_face();};
void()      monster_heavy_grenade9 = [ $grenade9, monster_heavy_grenade10] {ai_face();};
void()      monster_heavy_grenade10 = [ $grenade10, monster_heavy_grenade11] {ai_face();};
void()      monster_heavy_grenade11 = [ $grenade11, monster_heavy_grenade12] {ai_face();};
void()      monster_heavy_grenade12 = [ $grenade12, monster_heavy_grenade13] {ai_face();monster_heavyFireGrenade();};
void()      monster_heavy_grenade13 = [ $grenade13, monster_heavy_grenade14] {ai_face();};
void()      monster_heavy_grenade14 = [ $grenade14, monster_heavy_grenade15] {ai_face();};
void()      monster_heavy_grenade15 = [ $grenade15, monster_heavy_grenade16] {ai_face();};
void()      monster_heavy_grenade16 = [ $grenade16, monster_heavy_run1] {ai_face();};

void()      monster_heavy_straferight1 = [ $rstrafe1,   monster_heavy_straferight2] {ai_face();ai_straferight(5);monster_heavy_fire(); };
void()      monster_heavy_straferight2 = [ $rstrafe2,   monster_heavy_straferight3] {ai_face();ai_straferight(7);};
void()      monster_heavy_straferight3 = [ $rstrafe3,   monster_heavy_straferight4] {ai_face();ai_straferight(6);monster_heavy_fire();};
void()      monster_heavy_straferight4 = [ $rstrafe4,   monster_heavy_straferight5] {ai_face();ai_straferight(6);};
void()      monster_heavy_straferight5 = [ $rstrafe5,   monster_heavy_straferight6] {ai_face();ai_straferight(5);monster_heavy_fire();};
void()      monster_heavy_straferight6 = [ $rstrafe6,   monster_heavy_straferight7] {ai_face();ai_straferight(5);};
void()      monster_heavy_straferight7 = [ $rstrafe7,   monster_heavy_straferight8] {ai_face();ai_straferight(3);monster_heavy_fire();};
void()      monster_heavy_straferight8 = [ $rstrafe1,   monster_heavy_straferight9] {ai_face();ai_straferight(5);monster_heavy_fire();};
void()      monster_heavy_straferight9 = [ $rstrafe2,   monster_heavy_straferight10] {ai_face();ai_straferight(7);};
void()      monster_heavy_straferight10 = [ $rstrafe3,   monster_heavy_straferight11] {ai_face();ai_straferight(6);monster_heavy_fire();};
void()      monster_heavy_straferight11 = [ $rstrafe4,   monster_heavy_straferight12] {ai_face();ai_straferight(6);};
void()      monster_heavy_straferight12 = [ $rstrafe5,   monster_heavy_straferight13] {ai_face();ai_straferight(5);monster_heavy_fire();};
void()      monster_heavy_straferight13 = [ $rstrafe6,   monster_heavy_straferight14] {ai_face();ai_straferight(5);};
void()      monster_heavy_straferight14 = [ $rstrafe7,   monster_heavy_run1] {ai_face();ai_straferight(3);monster_heavy_fire();};

void()      monster_heavy_strafeleft1 = [ $lstrafe1,   monster_heavy_strafeleft2] {ai_face();ai_strafeleft(5);monster_heavy_fire();};
void()      monster_heavy_strafeleft2 = [ $lstrafe2,   monster_heavy_strafeleft3] {ai_face();ai_strafeleft(7);};
void()      monster_heavy_strafeleft3 = [ $lstrafe3,   monster_heavy_strafeleft4] {ai_face();ai_strafeleft(6);monster_heavy_fire();};
void()      monster_heavy_strafeleft4 = [ $lstrafe4,   monster_heavy_strafeleft5] {ai_face();ai_strafeleft(6);};
void()      monster_heavy_strafeleft5 = [ $lstrafe5,   monster_heavy_strafeleft6] {ai_face();ai_strafeleft(5);monster_heavy_fire();};
void()      monster_heavy_strafeleft6 = [ $lstrafe6,   monster_heavy_strafeleft7] {ai_face();ai_strafeleft(5);};
void()      monster_heavy_strafeleft7 = [ $lstrafe7,   monster_heavy_strafeleft8] {ai_face();ai_strafeleft(3);monster_heavy_fire();};
void()      monster_heavy_strafeleft8 = [ $lstrafe1,   monster_heavy_strafeleft9] {ai_face();ai_strafeleft(5);monster_heavy_fire();};
void()      monster_heavy_strafeleft9 = [ $lstrafe2,   monster_heavy_strafeleft10] {ai_face();ai_strafeleft(7);};
void()      monster_heavy_strafeleft10 = [ $lstrafe3,   monster_heavy_strafeleft11] {ai_face();ai_strafeleft(6);monster_heavy_fire();};
void()      monster_heavy_strafeleft11 = [ $lstrafe4,   monster_heavy_strafeleft12] {ai_face();ai_strafeleft(6);};
void()      monster_heavy_strafeleft12 = [ $lstrafe5,   monster_heavy_strafeleft13] {ai_face();ai_strafeleft(5);monster_heavy_fire();};
void()      monster_heavy_strafeleft13 = [ $lstrafe6,   monster_heavy_strafeleft14] {ai_face();ai_strafeleft(5);};
void()      monster_heavy_strafeleft14 = [ $lstrafe7,   monster_heavy_run1] {ai_face();ai_strafeleft(3);monster_heavy_fire();};

void()	monster_heavy_stand1	=[	$stand1,	monster_heavy_stand2	] {ai_stand();};
void()	monster_heavy_stand2	=[	$stand2,	monster_heavy_stand3	] {ai_stand();};
void()	monster_heavy_stand3	=[	$stand3,	monster_heavy_stand4	] {ai_stand();};
void()	monster_heavy_stand4	=[	$stand4,	monster_heavy_stand5	] {ai_stand();};
void()	monster_heavy_stand5	=[	$stand5,	monster_heavy_stand6	] {ai_stand();};
void()	monster_heavy_stand6	=[	$stand6,	monster_heavy_stand7	] {ai_stand();};
void()	monster_heavy_stand7	=[	$stand7,	monster_heavy_stand8	] {ai_stand();};
void()	monster_heavy_stand8	=[	$stand8,	monster_heavy_stand9	] {ai_stand();};
void()	monster_heavy_stand9	=[	$stand9,	monster_heavy_stand10	] {ai_stand();};
void()	monster_heavy_stand10	=[	$stand10,	monster_heavy_stand11	] {ai_stand();};
void()	monster_heavy_stand11	=[	$stand11,	monster_heavy_stand12	] {ai_stand();};
void()	monster_heavy_stand12	=[	$stand12,	monster_heavy_stand13	] {ai_stand();};
void()	monster_heavy_stand13	=[	$stand13,	monster_heavy_stand14	] {ai_stand();};
void()	monster_heavy_stand14	=[	$stand14,	monster_heavy_stand15	] {ai_stand();};
void()	monster_heavy_stand15	=[	$stand15,	monster_heavy_stand16	] {ai_stand();};
void()	monster_heavy_stand16	=[	$stand16,	monster_heavy_stand17	] {ai_stand();};
void()	monster_heavy_stand17	=[	$stand17,	monster_heavy_stand18	] {ai_stand();};
void()	monster_heavy_stand18	=[	$stand18,	monster_heavy_stand19	] {ai_stand();};
void()	monster_heavy_stand19 	=[	$stand19,	monster_heavy_stand20	] {ai_stand();};
void()	monster_heavy_stand20	=[	$stand20,	monster_heavy_stand21	] {ai_stand();};
void()	monster_heavy_stand21	=[	$stand21,	monster_heavy_stand22	] {ai_stand();};
void()	monster_heavy_stand22	=[	$stand22,	monster_heavy_stand1	] {ai_stand();};

void()	monster_heavy_walk1	=[	$walk1,	monster_heavy_walk2	] {ai_walk(2);};
void()	monster_heavy_walk2	=[	$walk2,	monster_heavy_walk3	] {ai_walk(4);};
void()	monster_heavy_walk3	=[	$walk3,	monster_heavy_walk4	] {ai_walk(4);};
void()	monster_heavy_walk4	=[	$walk4,	monster_heavy_walk5	] {ai_walk(3);};
void()	monster_heavy_walk5	=[	$walk5,	monster_heavy_walk6	] {ai_walk(1);};
void()	monster_heavy_walk6	=[	$walk6,	monster_heavy_walk7	] {ai_walk(2);};
void()	monster_heavy_walk7	=[	$walk7,	monster_heavy_walk8	] {ai_walk(2);};
void()	monster_heavy_walk8	=[	$walk8,	monster_heavy_walk9	] {ai_walk(1);};
void()	monster_heavy_walk9	=[	$walk9,	monster_heavy_walk10	] {ai_walk(2);};
void()	monster_heavy_walk10	=[	$walk10,	monster_heavy_walk11	] {ai_walk(4);};
void()	monster_heavy_walk11	=[	$walk11,	monster_heavy_walk12	] {ai_walk(4);};
void()	monster_heavy_walk12	=[	$walk12,	monster_heavy_walk13	] {ai_walk(1);};
void()	monster_heavy_walk13	=[	$walk13,	monster_heavy_walk14	] {ai_walk(2);};
void()	monster_heavy_walk14	=[	$walk14,	monster_heavy_walk15	] {ai_walk(3);};
void()	monster_heavy_walk15	=[	$walk15,	monster_heavy_walk16	] {ai_walk(4);};
void()	monster_heavy_walk16	=[	$walk16,	monster_heavy_walk17	] {ai_walk(2);};
void()	monster_heavy_walk17	=[	$walk17,	monster_heavy_walk18	] {ai_walk(2);};
void()	monster_heavy_walk18	=[	$walk18,	monster_heavy_walk19	] {ai_walk(4);};
void()	monster_heavy_walk19	=[	$walk19,	monster_heavy_walk20	] {ai_walk(4);};
void()	monster_heavy_walk20	=[	$walk20,	monster_heavy_walk21	] {ai_walk(3);};
void()	monster_heavy_walk21	=[	$walk21,	monster_heavy_walk22	] {ai_walk(1);};
void()	monster_heavy_walk22	=[	$walk22,	monster_heavy_walk23	] {ai_walk(2);};
void()	monster_heavy_walk23	=[	$walk23,	monster_heavy_walk24	] {ai_walk(2);};
void()	monster_heavy_walk24	=[	$walk24,	monster_heavy_walk25	] {ai_walk(1);};
void()	monster_heavy_walk25	=[	$walk25,	monster_heavy_walk26	] {ai_walk(2);};
void()	monster_heavy_walk26	=[	$walk26,	monster_heavy_walk27	] {ai_walk(4);};
void()	monster_heavy_walk27	=[	$walk27,	monster_heavy_walk28	] {ai_walk(4);};
void()	monster_heavy_walk28	=[	$walk28,	monster_heavy_walk29	] {ai_walk(1);};
void()	monster_heavy_walk29	=[	$walk30,	monster_heavy_walk1	] {ai_walk(2);};
void()	monster_heavy_walk30	=[	$walk30,	monster_heavy_walk1	] {ai_walk(3);};
// void()	monster_heavy_walk31	=[	$walk31,	monster_heavy_walk32	] {ai_walk(4);};
// void()	monster_heavy_walk32	=[	$walk32,	monster_heavy_walk1	] {ai_walk(2);};

void()	monster_heavy_run1	=[	$run1,		monster_heavy_run2	] {ai_run(18);self.duck = 0;setsize (self, '-9 -9 -24', '9 9 34');};
void()	monster_heavy_run2	=[	$run2,		monster_heavy_run3	] {ai_run(14);};
void()	monster_heavy_run3	=[	$run3,		monster_heavy_run4	] {ai_run(7);};
void()	monster_heavy_run4	=[	$run4,		monster_heavy_run5	] {ai_run(12);};
void()	monster_heavy_run5	=[	$run5,		monster_heavy_run6	] {ai_run(14);};
void()	monster_heavy_run6	=[	$run6,		monster_heavy_run7	] {ai_run(14);};
void()	monster_heavy_run7	=[	$run7,		monster_heavy_run8	] {ai_run(7);};
void()	monster_heavy_run8	=[	$run8,		monster_heavy_run9	] {ai_run(7);};
void()	monster_heavy_run9	=[	$run9,		monster_heavy_run1	] {ai_run(11);};

void()      monster_heavy_load1   =[    $load1,      monster_heavy_load2] {self.rifleClip = 30;};
void()      monster_heavy_load2   =[    $load2,      monster_heavy_load3] {};
void()      monster_heavy_load3   =[    $load3,      monster_heavy_load4] {};
void()      monster_heavy_load4   =[    $load4,      monster_heavy_load5] {sound(self,CHAN_WEAPON,"weapons/rifle/clipout.wav",1,ATTN_NORM);};
void()      monster_heavy_load5   =[    $load5,      monster_heavy_load6] {};
void()      monster_heavy_load6   =[    $load6,      monster_heavy_load7] {};
void()      monster_heavy_load7   =[    $load7,      monster_heavy_load8] {};
void()      monster_heavy_load8   =[    $load8,      monster_heavy_load9] {};
void()      monster_heavy_load9   =[    $load9,      monster_heavy_load10] {};
void()      monster_heavy_load10   =[    $load10,      monster_heavy_load11] {};
void()      monster_heavy_load11   =[    $load11,      monster_heavy_load12] {};
void()      monster_heavy_load12   =[    $load12,      monster_heavy_load13] {};
void()      monster_heavy_load13   =[    $load13,      monster_heavy_load14] {};
void()      monster_heavy_load14   =[    $load14,      monster_heavy_run1] {sound(self,CHAN_WEAPON,"weapons/rifle/clipin.wav",1,ATTN_NORM);};

void()      monster_heavy_firea1 = [ $firea1 , monster_heavy_firea2 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea2 = [ $firea2 , monster_heavy_firea3 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea3 = [ $firea3 , monster_heavy_firea4 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea4 = [ $firea4 , monster_heavy_firea5 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea5 = [ $firea5 , monster_heavy_firea6 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea6 = [ $firea6 , monster_heavy_firea7 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea7 = [ $firea7 , monster_heavy_firea8 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firea8 = [ $firea8 , monster_heavy_run1 ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

self.nextthink = time + 0.5;
SUB_CheckRefire (monster_heavy_firea1);
};


void() monster_heavy_drawb1;
void() monster_heavy_drawc1;

void()      monster_heavy_drawa1   =[    $drawa1,     monster_heavy_drawa2   ] 
{
 local float temp;

 temp = random();
 ai_face();
 if (temp < 0.25) 
  {
   self.think = monster_heavy_drawb1;
   self.nextthink = time + 0.03;
  }
 if ( (temp < 0.5) && (temp >= 0.25) )
  {
   self.think = monster_heavy_drawc1;
   self.nextthink = time + 0.03;
  }
 if (temp >= 0.5)
  { 
   self.think = monster_heavy_drawa2;
   self.nextthink = time + 0.03;
  }

};
void()      monster_heavy_drawa2   =[    $drawa2,     monster_heavy_drawa3   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawa3   =[    $drawa3,     monster_heavy_drawa4   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawa4   =[    $drawa4,     monster_heavy_drawa5   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawa5   =[    $drawa5,     monster_heavy_drawa6   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawa6   =[    $drawa6,     monster_heavy_drawa7   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawa7   =[    $drawa7,     monster_heavy_firea1   ] 
{
ai_face();
if (random() < 0.65)
 {
  if (random() < 0.5)
   {
    self.think = monster_heavy_strafeleft1;
   }
  else
   {
    self.think = monster_heavy_straferight1;
   }
 }
if (self.health <= 30)
 {
  if (random() < 0.75)
   {
    if (random() < 0.5)
     {
      self.think = monster_heavy_strafeleft1;
     }
    else
     {
      self.think = monster_heavy_straferight1;
     }
   }
 }
if (self.rifleClip <= 0)
 { 
  self.think = monster_heavy_load1;
 }

if ( ( (self.absmax_z - self.enemy.absmax_z) > -50) 
    && ( ( vlen(self.enemy.origin - self.origin) ) > 500) 
    /*&& (self.firstgrenade != 23)*/ )

{
  if (random () < 0.8)
   {
    self.think = monster_heavy_grenade1;
    self.attack_finished = time + 1.3;
   /* self.firstgrenade = 23;*/
   }
}   

};

/************************* END OF DRAWA  ************************/

void()      monster_heavy_fireb1         =[    $fireb1,     monster_heavy_fireb2   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_fireb2         =[    $fireb2,     monster_heavy_run1     ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

self.nextthink = time + 0.5;
SUB_CheckRefire (monster_heavy_fireb1);
};

void()      monster_heavy_drawb1   =[    $drawb1,     monster_heavy_drawb2   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb2   =[    $drawb2,     monster_heavy_drawb3   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb3   =[    $drawb3,     monster_heavy_drawb4   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb4   =[    $drawb4,     monster_heavy_drawb5   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb5   =[    $drawb5,     monster_heavy_drawb6   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb6   =[    $drawb6,     monster_heavy_drawb7   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb7   =[    $drawb7,     monster_heavy_drawb8   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb8   =[    $drawb8,     monster_heavy_drawb9   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawb9   =[    $drawb9,     monster_heavy_fireb1   ] 
{
  ai_face();

  if ( ( (self.absmax_z - self.enemy.absmax_z) > -50) 
    && ( ( vlen(self.enemy.origin - self.origin) ) > 500) 
   /* && (self.firstgrenade != 23)*/ )
{
  if (random () < 0.7)
   {
    self.think = monster_heavy_grenade1;
    self.attack_finished = time + 1.3;
    /*self.firstgrenade = 23;*/
   }
}   

if (self.rifleClip <= 0)
 { 
  self.think = monster_heavy_load1;
 }

};

/************************** END OF DRAWB *******************************/

void()      monster_heavy_firec1         =[    $firec1,     monster_heavy_firec2   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec2         =[    $firec2,     monster_heavy_firec3   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec3         =[    $firec3,     monster_heavy_firec4   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec4         =[    $firec4,     monster_heavy_firec5   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec5         =[    $firec5,     monster_heavy_firec6   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec6         =[    $firec6,     monster_heavy_firec7   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec7         =[    $firec7,     monster_heavy_firec8   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec8         =[    $firec8,     monster_heavy_firec9   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec9         =[    $firec9,     monster_heavy_firec10   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec10         =[    $firec10,     monster_heavy_firec11   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec11         =[    $firec11,     monster_heavy_firec12   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec12         =[    $firec12,     monster_heavy_firec13   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

};

void()      monster_heavy_firec13         =[    $firec13,     monster_heavy_run1   ] 
{ 
 ai_face();
 monster_heavy_fire();
 if (self.rifleClip <= 0)
   {
     self.think = monster_heavy_load1;
   }

self.nextthink = time + 0.5;
SUB_CheckRefire (monster_heavy_firec1);
};




void()      monster_heavy_drawc1   =[    $drawc1,     monster_heavy_drawc2   ] {self.duck = 1;ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawc2   =[    $drawc2,     monster_heavy_drawc3   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawc3   =[    $drawc3,     monster_heavy_drawc4   ] {ai_face();self.nextthink = time + 0.03;};
void()      monster_heavy_drawc4   =[    $drawc4,     monster_heavy_drawc5   ] {ai_face();self.nextthink = time + 0.03;setsize (self, '-16 -16 -24', '16 16 32');};
void()      monster_heavy_drawc5   =[    $drawc5,     monster_heavy_drawc6   ] {ai_face();self.nextthink = time + 0.03;setsize (self, '-16 -16 -24', '16 16 30');};
void()      monster_heavy_drawc6   =[    $drawc6,     monster_heavy_drawc7   ] {ai_face();self.nextthink = time + 0.03;setsize (self, '-16 -16 -24', '16 16 28');};
void()      monster_heavy_drawc7   =[    $drawc7,     monster_heavy_drawc8   ] {ai_face();self.nextthink = time + 0.03;setsize (self, '-16 -16 -24', '16 16 24');};
void()      monster_heavy_drawc8   =[    $drawc8,     monster_heavy_drawc9   ] {ai_face();self.nextthink = time + 0.03;setsize (self, '-16 -16 -24', '16 16 22');};
void()      monster_heavy_drawc9   =[    $drawc9,     monster_heavy_firec1   ] 
{
  setsize (self, '-16 -16 -24', '16 16 18');
  ai_face();

  if ( ( (self.absmax_z - self.enemy.absmax_z) > -50) 
    && ( ( vlen(self.enemy.origin - self.origin) ) > 500) 
    /*&& (self.firstgrenade != 23)*/ )
{
  if (random () < 0.6)
   {
    self.think = monster_heavy_grenade1;
    self.attack_finished = time + 1.3;
   /*self.firstgrenade = 23;*/
   }
}   

if (self.rifleClip <= 0)
 { 
  self.think = monster_heavy_load1;
 }

};




void()	monster_heavy_paina1	=[	$paina1,		monster_heavy_paina2	] 
{
  if (self.health < 25)  
    self.skin = 1;
};
void()	monster_heavy_paina2	=[	$paina2,		monster_heavy_paina3	] {};
void()	monster_heavy_paina3	=[	$paina3,		monster_heavy_paina4	] {};
void()	monster_heavy_paina4	=[	$paina4,		monster_heavy_paina5	] {};
void()	monster_heavy_paina5	=[	$paina5,		monster_heavy_drawc1	] {};

void()	monster_heavy_painb1	=[	$painb1,	monster_heavy_painb2	] 
{
  if (self.health < 25)  
    self.skin = 1;
};
void()	monster_heavy_painb2	=[	$painb2,	monster_heavy_painb3	] {};
void()	monster_heavy_painb3	=[	$painb3,	monster_heavy_painb4	] {};
void()	monster_heavy_painb4	=[	$painb4,	monster_heavy_painb5	] {};
void()	monster_heavy_painb5	=[	$painb5,	monster_heavy_drawb1	] {};

void()	monster_heavy_painc1	=[	$painc1,	monster_heavy_painc2	] 
{
  if (self.health < 25)  
  self.skin = 1;
};
void()	monster_heavy_painc2	=[	$painc2,	monster_heavy_painc3	] {};
void()	monster_heavy_painc3	=[	$painc3,	monster_heavy_painc4	] {};
void()	monster_heavy_painc4	=[	$painc4,	monster_heavy_painc5	] {};
void()	monster_heavy_painc5	=[	$painc5,	monster_heavy_painc6	] {};
void()	monster_heavy_painc6	=[	$painc6,	monster_heavy_painc7	] {};
void()	monster_heavy_painc7	=[	$painc7,	monster_heavy_run1	] {};

void()	monster_heavy_paind1	=[	$paind1,	monster_heavy_paind2	] 
{
  if (self.health < 25)  
  self.skin = 1;
};
void()	monster_heavy_paind2	=[	$paind2,	monster_heavy_paind3	] {};
void()	monster_heavy_paind3	=[	$paind3,	monster_heavy_paind4	] {};
void()	monster_heavy_paind4	=[	$paind4,	monster_heavy_paind5	] {};
void()	monster_heavy_paind5	=[	$paind5,	monster_heavy_run1	] {};

void()	monster_heavy_Melee =
{
	local	float	ldmg;
	local vector	delta;
	
	ai_face ();
	walkmove (self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 90) return;
	if (!CanDamage (self.enemy, self)) return;
		
    sound (self, CHAN_WEAPON, "weapons/knife/hit.wav", 1, ATTN_NORM);
	ldmg = 10 + 5*random();
	T_Damage (self.enemy, self, self, ldmg);	

	makevectors (self.angles);
};



void() monster_heavyFireGrenade =
{
	float r;
	r = random();
	if(r < 0.2) sound (self, CHAN_VOICE, "npc/grenade1.wav", 1, ATTN_NORM);
	else if(r >0.2 && r <0.4) sound (self, CHAN_VOICE, "npc/grenade2.wav", 1, ATTN_NORM);
	else if(r < 0.6) sound (self, CHAN_VOICE, "npc/grenade3.wav", 1, ATTN_NORM);
	
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

void(entity attacker, float damage)	monster_heavy_pain =
{
	local float r;
	
	//if (self.pain_finished > time)
	//	return;

	r = random();
    if (self.duck == 1)
    {
        self.pain_finished = time + 0.1;
        monster_heavy_paina1 ();
    }
    else
    {
		if (r < 0.333)
		{
			self.pain_finished = time + 0.1;
			monster_heavy_painb1 ();
			sound (self, CHAN_VOICE, "player/pain2.wav", 1, ATTN_NORM);
		}
		if ( (r < 0.666) && (r >= 0.333) )
		{
			self.pain_finished = time + 0.1;
			monster_heavy_painc1 ();
			sound (self, CHAN_VOICE, "player/pain3.wav", 1, ATTN_NORM);
		}
		else
		{
			self.pain_finished = time + 0.1;
			monster_heavy_paind1 ();
			sound (self, CHAN_VOICE, "player/pain4.wav", 1, ATTN_NORM);
		}
    }
};

/*
void(float shotcount, vector dir, vector spread) monster_heavyFire =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
      ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
            traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
              if (trace_ent.classname != "player")
                {
                  return;
                }
              else
                {
			TraceAttack (4, direction); 
                }
		shotcount = shotcount - 1;
	}
      ApplyMultiDamage ();

};
*/

void(float damage, vector dir) monster_heavyFire =
{
	if(self.duck == 1) pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -21 , self.velocity*50, 1);
	else pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -10, self.velocity*50, 1);
	local vector src;

	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;        
	traceline (src, src + dir * 1024, FALSE, self);
	if (trace_fraction != 1.0)
	{
		if (trace_ent.takedamage) T_Damage (trace_ent, self, self, damage);
		else
		{
			CreateHitSound(trace_endpos);
			WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST,TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST,trace_endpos_x);
			WriteCoord (MSG_BROADCAST,trace_endpos_y);
			WriteCoord (MSG_BROADCAST,trace_endpos_z);
			//particle (trace_endpos,'3 2 7',192,TE_WIZSPIKE);
			//particle (trace_endpos,'7 6 8',192,TE_WIZSPIKE);
			//sound (self.enemy,CHAN_AUTO,"weapons/mp5ric1.wav",TRUE,ATTN_NORM);   
				
		}    
	}
};

void() monster_heavy_fire =
{
	local	vector	dir;
	local	entity	en;
	
	ai_face();
	
	sound (self, CHAN_WEAPON, "weapons/rifle/m4.wav", 1, ATTN_NORM);	

// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	
	dir = (en.origin - '0 0 8') - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	monster_heavyFire(12,dir);
    self.rifleClip = self.rifleClip - 1;
};

void()      monster_heavy_melee1 = [   $melee1,   monster_heavy_melee2 ] {ai_face();};
void()      monster_heavy_melee2 = [   $melee2,   monster_heavy_melee3 ] {ai_face();};
void()      monster_heavy_melee3 = [   $melee3,   monster_heavy_melee4 ] {ai_face();};
void()      monster_heavy_melee4 = [   $melee4,   monster_heavy_melee5 ] {ai_face();};
void()      monster_heavy_melee5 = [   $melee5,   monster_heavy_melee6 ] {ai_face();};
void()      monster_heavy_melee6 = [   $melee6,   monster_heavy_melee7 ] {ai_face();monster_heavy_Melee ();};
void()      monster_heavy_melee7 = [   $melee7,   monster_heavy_melee8 ] {ai_face();monster_heavy_Melee ();};
void()      monster_heavy_melee8 = [   $melee8,   monster_heavy_melee9 ] {ai_face();};
void()      monster_heavy_melee9 = [   $melee9,   monster_heavy_melee10 ] {ai_face();};
void()      monster_heavy_melee10 = [   $melee10,   monster_heavy_run1 ] {ai_face();};

void()	monster_heavy_died1	=[	$deathd1,	monster_heavy_died2	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died2	=[	$deathd2,	monster_heavy_died3	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died3	=[	$deathd3,	monster_heavy_died4	] 
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  self.ammoRifle = ceil(self.rifleClip * 0.5);
//  Drop_Clip();
};
void()	monster_heavy_died4	=[	$deathd4,	monster_heavy_died5	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died5	=[	$deathd5,	monster_heavy_died6	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died6	=[	$deathd6,	monster_heavy_died7	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died7	=[	$deathd7,	monster_heavy_died8	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died8	=[	$deathd8,	monster_heavy_died9	] {self.nextthink = time + 0.03;};
void()	monster_heavy_died9	=[	$deathd9,	monster_heavy_died9	] {};


void()	monster_heavy_diea1	=[	$deatha1,	monster_heavy_diea2	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea2	=[	$deatha2,	monster_heavy_diea3	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea3	=[	$deatha3,	monster_heavy_diea4	] 
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  self.ammoRifle = ceil(self.rifleClip * 0.5);
  //Drop_Clip();
};
void()	monster_heavy_diea4	=[	$deatha4,	monster_heavy_diea5	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea5	=[	$deatha5,	monster_heavy_diea6	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea6	=[	$deatha6,	monster_heavy_diea7	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea7	=[	$deatha7,	monster_heavy_diea8	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea8	=[	$deatha8,	monster_heavy_diea9	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea9	=[	$deatha9,	monster_heavy_diea10	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diea10	=[	$deatha10,	monster_heavy_diea10	] {};


void()	monster_heavy_dieb1	=[	$deathb1,	monster_heavy_dieb2	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb2	=[	$deathb2, monster_heavy_dieb3] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb3	=[	$deathb3, monster_heavy_dieb4]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  self.ammoRifle = ceil(self.rifleClip * 0.5);
 // Drop_Clip();
};
void()	monster_heavy_dieb4	=[	$deathb4,	monster_heavy_dieb5	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb5	=[	$deathb5,	monster_heavy_dieb6	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb6	=[	$deathb6,	monster_heavy_dieb7	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb7	=[	$deathb7,	monster_heavy_dieb8	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb8	=[	$deathb8,	monster_heavy_dieb9	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb9	=[	$deathb9,	monster_heavy_dieb10	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb10	=[	$deathb10,	monster_heavy_dieb11	] {self.nextthink = time + 0.03;};
void()	monster_heavy_dieb11	=[	$deathb11,	monster_heavy_dieb11	] {};

void()	monster_heavy_diec1	=[	$deathc1,	monster_heavy_diec2	] { self.nextthink = time + 0.03; };
void()	monster_heavy_diec2	=[	$deathc2,	monster_heavy_diec3	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec3	=[	$deathc3,	monster_heavy_diec4	]
{
  self.nextthink = time + 0.03;
  self.solid = SOLID_NOT;
  self.ammoRifle = ceil(self.rifleClip * 0.5);
 // Drop_Clip();
  ai_back(4);
};
void()	monster_heavy_diec4	=[	$deathc4,	monster_heavy_diec5	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec5	=[	$deathc5,	monster_heavy_diec6	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec6	=[	$deathc6,	monster_heavy_diec7	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec7	=[	$deathc7,	monster_heavy_diec8	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec8	=[	$deathc8,	monster_heavy_diec9	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec9	=[	$deathc9,	monster_heavy_diec10	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec10	=[	$deathc10,	monster_heavy_diec11	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec11	=[	$deathc11,	monster_heavy_diec12	] {self.nextthink = time + 0.03;};
void()	monster_heavy_diec12	=[	$deathc12,	monster_heavy_diec12	] {self.nextthink = time + 0.03;};


void() monster_heavy_die =
{

      local float temp;

// check for gib
	// if (self.health < 10)
	// {
            // sound (self,CHAN_VOICE,"player/death3.wav",TRUE,ATTN_NORM);
            // ThrowHead ("progs/h_monster_heavy.mdl",self.health);
            // ThrowGib ("models/gib1.bsp",self.health);
            // ThrowGib ("models/gib2.bsp",self.health);
            // ThrowGib ("models/gib3.bsp",self.health);
            // return ;
	// }


      temp = random();
 
      if (self.duck == 1)
       {
		monster_heavy_diea1 ();
		self.flags = self.flags + FL_ONGROUND;
       	sound (self, CHAN_VOICE, "player/death2.wav", 1, ATTN_NORM);     
       }
     else
      {
	if (temp < 0.333)
       {
		monster_heavy_dieb1 ();
       	sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
        self.flags = 32;
        self.velocity_z = self.velocity_z + 70;

       }
	if ( (temp < 0.666) && (temp >= 0.333) )
       {
		monster_heavy_diec1 ();
       	sound (self, CHAN_VOICE, "player/death2.wav", 1, ATTN_NORM);     
        self.flags = 32;
        self.velocity_z = self.velocity_z + 70;
       }
      if (temp >= 0.666)
       {
            monster_heavy_died1 ();
            sound (self, CHAN_VOICE, "player/death2.wav", 1 , ATTN_NORM);
       }
      }
};


/*QUAKED monster_heavy_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/

void() monster_heavy =
{	
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("models/npc/heavy.md3");
    precache_sound2 ("weapons/rifle/m4.wav");
	precache_sound2 ("npc/grenade1.wav");
	precache_sound2 ("npc/grenade2.wav");
	precache_sound2 ("npc/grenade3.wav");
	

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;


	setmodel (self, "models/npc/heavy.md3");

	setsize (self, '-9 -9 -24', '9 9 34');
	self.health = 75;
    self.rifleClip = 30;
	self.th_stand = monster_heavy_stand1;
	self.th_walk = monster_heavy_walk1;
	self.th_run = monster_heavy_run1;
	self.th_missile = monster_heavy_drawa1;
    self.th_melee = monster_heavy_melee1;
	self.th_pain = monster_heavy_pain;
	self.th_die = monster_heavy_die;

	walkmonster_start ();
};


