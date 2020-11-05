$cd data / models / npc / shotgunner
$origin 0 - 6 - 24
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
void() shotgunner_fire;
void() shotgunnerFireGrenade;

void()      shotgunner_grenade1 = [$grenade1, shotgunner_grenade2] {ai_face(); };
void()      shotgunner_grenade2 = [$grenade2, shotgunner_grenade3] {ai_face(); };
void()      shotgunner_grenade3 = [$grenade3, shotgunner_grenade4] {ai_face(); };
void()      shotgunner_grenade4 = [$grenade4, shotgunner_grenade5] {ai_face(); };
void()      shotgunner_grenade5 = [$grenade5, shotgunner_grenade6] {ai_face(); };
void()      shotgunner_grenade6 = [$grenade6, shotgunner_grenade7] {ai_face(); };
void()      shotgunner_grenade7 = [$grenade7, shotgunner_grenade8] {ai_face(); };
void()      shotgunner_grenade8 = [$grenade8, shotgunner_grenade9] {ai_face(); };
void()      shotgunner_grenade9 = [$grenade9, shotgunner_grenade10] {ai_face(); };
void()      shotgunner_grenade10 = [$grenade10, shotgunner_grenade11] {ai_face(); };
void()      shotgunner_grenade11 = [$grenade11, shotgunner_grenade12] {ai_face(); };
void()      shotgunner_grenade12 = [$grenade12, shotgunner_grenade13] {ai_face(); shotgunnerFireGrenade(); };
void()      shotgunner_grenade13 = [$grenade13, shotgunner_grenade14] {ai_face(); };
void()      shotgunner_grenade14 = [$grenade14, shotgunner_grenade15] {ai_face(); };
void()      shotgunner_grenade15 = [$grenade15, shotgunner_grenade16] {ai_face(); };
void()      shotgunner_grenade16 = [$grenade16, shotgunner_run1] {ai_face(); };

void()      shotgunner_straferight1 = [$rstrafe1, shotgunner_straferight2] {ai_face(); ai_straferight(5); shotgunner_fire(); };
void()      shotgunner_straferight2 = [$rstrafe2, shotgunner_straferight3] {ai_face(); ai_straferight(7); };
void()      shotgunner_straferight3 = [$rstrafe3, shotgunner_straferight4] {ai_face(); ai_straferight(6); };
void()      shotgunner_straferight4 = [$rstrafe4, shotgunner_straferight5] {ai_face(); ai_straferight(6); };
void()      shotgunner_straferight5 = [$rstrafe5, shotgunner_straferight6] {ai_face(); ai_straferight(5); };
void()      shotgunner_straferight6 = [$rstrafe6, shotgunner_straferight7] {ai_face(); ai_straferight(5); };
void()      shotgunner_straferight7 = [$rstrafe7, shotgunner_straferight8] {ai_face(); ai_straferight(3); shotgunner_fire(); };
void()      shotgunner_straferight8 = [$rstrafe1, shotgunner_straferight9] {ai_face(); ai_straferight(5); };
void()      shotgunner_straferight9 = [$rstrafe2, shotgunner_straferight10] {ai_face(); ai_straferight(7); };
void()      shotgunner_straferight10 = [$rstrafe3, shotgunner_straferight11] {ai_face(); ai_straferight(6); };
void()      shotgunner_straferight11 = [$rstrafe4, shotgunner_straferight12] {ai_face(); ai_straferight(6); };
void()      shotgunner_straferight12 = [$rstrafe5, shotgunner_straferight13] {ai_face(); ai_straferight(5); };
void()      shotgunner_straferight13 = [$rstrafe6, shotgunner_straferight14] {ai_face(); ai_straferight(5); };
void()      shotgunner_straferight14 = [$rstrafe7, shotgunner_run1] {ai_face(); ai_straferight(3); shotgunner_fire(); };

void()      shotgunner_strafeleft1 = [$lstrafe1, shotgunner_strafeleft2] {ai_face(); ai_strafeleft(5); shotgunner_fire(); };
void()      shotgunner_strafeleft2 = [$lstrafe2, shotgunner_strafeleft3] {ai_face(); ai_strafeleft(7); };
void()      shotgunner_strafeleft3 = [$lstrafe3, shotgunner_strafeleft4] {ai_face(); ai_strafeleft(6); };
void()      shotgunner_strafeleft4 = [$lstrafe4, shotgunner_strafeleft5] {ai_face(); ai_strafeleft(6); };
void()      shotgunner_strafeleft5 = [$lstrafe5, shotgunner_strafeleft6] {ai_face(); ai_strafeleft(5); };
void()      shotgunner_strafeleft6 = [$lstrafe6, shotgunner_strafeleft7] {ai_face(); ai_strafeleft(5); };
void()      shotgunner_strafeleft7 = [$lstrafe7, shotgunner_strafeleft8] {ai_face(); ai_strafeleft(3); shotgunner_fire(); };
void()      shotgunner_strafeleft8 = [$lstrafe1, shotgunner_strafeleft9] {ai_face(); ai_strafeleft(5); };
void()      shotgunner_strafeleft9 = [$lstrafe2, shotgunner_strafeleft10] {ai_face(); ai_strafeleft(7); };
void()      shotgunner_strafeleft10 = [$lstrafe3, shotgunner_strafeleft11] {ai_face(); ai_strafeleft(6); };
void()      shotgunner_strafeleft11 = [$lstrafe4, shotgunner_strafeleft12] {ai_face(); ai_strafeleft(6); };
void()      shotgunner_strafeleft12 = [$lstrafe5, shotgunner_strafeleft13] {ai_face(); ai_strafeleft(5); };
void()      shotgunner_strafeleft13 = [$lstrafe6, shotgunner_strafeleft14] {ai_face(); ai_strafeleft(5); };
void()      shotgunner_strafeleft14 = [$lstrafe7, shotgunner_run1] {ai_face(); ai_strafeleft(3); shotgunner_fire(); };

void()	shotgunner_stand1 = [$stand1, shotgunner_stand2] {ai_stand(); };
void()	shotgunner_stand2 = [$stand2, shotgunner_stand3] {ai_stand(); };
void()	shotgunner_stand3 = [$stand3, shotgunner_stand4] {ai_stand(); };
void()	shotgunner_stand4 = [$stand4, shotgunner_stand5] {ai_stand(); };
void()	shotgunner_stand5 = [$stand5, shotgunner_stand6] {ai_stand(); };
void()	shotgunner_stand6 = [$stand6, shotgunner_stand7] {ai_stand(); };
void()	shotgunner_stand7 = [$stand7, shotgunner_stand8] {ai_stand(); };
void()	shotgunner_stand8 = [$stand8, shotgunner_stand9] {ai_stand(); };
void()	shotgunner_stand9 = [$stand9, shotgunner_stand10] {ai_stand(); };
void()	shotgunner_stand10 = [$stand10, shotgunner_stand11] {ai_stand(); };
void()	shotgunner_stand11 = [$stand11, shotgunner_stand12] {ai_stand(); };
void()	shotgunner_stand12 = [$stand12, shotgunner_stand13] {ai_stand(); };
void()	shotgunner_stand13 = [$stand13, shotgunner_stand14] {ai_stand(); };
void()	shotgunner_stand14 = [$stand14, shotgunner_stand15] {ai_stand(); };
void()	shotgunner_stand15 = [$stand15, shotgunner_stand16] {ai_stand(); };
void()	shotgunner_stand16 = [$stand16, shotgunner_stand17] {ai_stand(); };
void()	shotgunner_stand17 = [$stand17, shotgunner_stand18] {ai_stand(); };
void()	shotgunner_stand18 = [$stand18, shotgunner_stand19] {ai_stand(); };
void()	shotgunner_stand19 = [$stand19, shotgunner_stand20] {ai_stand(); };
void()	shotgunner_stand20 = [$stand20, shotgunner_stand21] {ai_stand(); };
void()	shotgunner_stand21 = [$stand21, shotgunner_stand22] {ai_stand(); };
void()	shotgunner_stand22 = [$stand22, shotgunner_stand1] {ai_stand(); };

void()	shotgunner_walk1 = [$walk1, shotgunner_walk2] {ai_walk(2); };
void()	shotgunner_walk2 = [$walk2, shotgunner_walk3] {ai_walk(4); };
void()	shotgunner_walk3 = [$walk3, shotgunner_walk4] {ai_walk(4); };
void()	shotgunner_walk4 = [$walk4, shotgunner_walk5] {ai_walk(3); };
void()	shotgunner_walk5 = [$walk5, shotgunner_walk6] {ai_walk(1); };
void()	shotgunner_walk6 = [$walk6, shotgunner_walk7] {ai_walk(2); };
void()	shotgunner_walk7 = [$walk7, shotgunner_walk8] {ai_walk(2); };
void()	shotgunner_walk8 = [$walk8, shotgunner_walk9] {ai_walk(1); };
void()	shotgunner_walk9 = [$walk9, shotgunner_walk10] {ai_walk(2); };
void()	shotgunner_walk10 = [$walk10, shotgunner_walk11] {ai_walk(4); };
void()	shotgunner_walk11 = [$walk11, shotgunner_walk12] {ai_walk(4); };
void()	shotgunner_walk12 = [$walk12, shotgunner_walk13] {ai_walk(1); };
void()	shotgunner_walk13 = [$walk13, shotgunner_walk14] {ai_walk(2); };
void()	shotgunner_walk14 = [$walk14, shotgunner_walk15] {ai_walk(3); };
void()	shotgunner_walk15 = [$walk15, shotgunner_walk16] {ai_walk(4); };
void()	shotgunner_walk16 = [$walk16, shotgunner_walk17] {ai_walk(2); };
void()	shotgunner_walk17 = [$walk17, shotgunner_walk18] {ai_walk(2); };
void()	shotgunner_walk18 = [$walk18, shotgunner_walk19] {ai_walk(4); };
void()	shotgunner_walk19 = [$walk19, shotgunner_walk20] {ai_walk(4); };
void()	shotgunner_walk20 = [$walk20, shotgunner_walk21] {ai_walk(3); };
void()	shotgunner_walk21 = [$walk21, shotgunner_walk22] {ai_walk(1); };
void()	shotgunner_walk22 = [$walk22, shotgunner_walk23] {ai_walk(2); };
void()	shotgunner_walk23 = [$walk23, shotgunner_walk24] {ai_walk(2); };
void()	shotgunner_walk24 = [$walk24, shotgunner_walk25] {ai_walk(1); };
void()	shotgunner_walk25 = [$walk25, shotgunner_walk26] {ai_walk(2); };
void()	shotgunner_walk26 = [$walk26, shotgunner_walk27] {ai_walk(4); };
void()	shotgunner_walk27 = [$walk27, shotgunner_walk28] {ai_walk(4); };
void()	shotgunner_walk28 = [$walk28, shotgunner_walk29] {ai_walk(1); };
void()	shotgunner_walk29 = [$walk30, shotgunner_walk1] {ai_walk(2); };
void()	shotgunner_walk30 = [$walk30, shotgunner_walk1] {ai_walk(3); };
// void()	shotgunner_walk31	=[	$walk31,	shotgunner_walk32	] {ai_walk(4);};
// void()	shotgunner_walk32	=[	$walk32,	shotgunner_walk1	] {ai_walk(2);};

void()	shotgunner_run1 = [$run1, shotgunner_run2] {ai_run(18); self.duck = 0; setsize(self, '-9 -9 -24', '9 9 34'); };
void()	shotgunner_run2 = [$run2, shotgunner_run3] {ai_run(14); };
void()	shotgunner_run3 = [$run3, shotgunner_run4] {ai_run(7); };
void()	shotgunner_run4 = [$run4, shotgunner_run5] {ai_run(12); };
void()	shotgunner_run5 = [$run5, shotgunner_run6] {ai_run(14); };
void()	shotgunner_run6 = [$run6, shotgunner_run7] {ai_run(14); };
void()	shotgunner_run7 = [$run7, shotgunner_run8] {ai_run(7); };
void()	shotgunner_run8 = [$run8, shotgunner_run9] {ai_run(7); };
void()	shotgunner_run9 = [$run9, shotgunner_run1] {ai_run(11); };

void()      shotgunner_load1 = [$load1, shotgunner_load2] {self.mossclip = 7; };
void()      shotgunner_load2 = [$load2, shotgunner_load3] {};
void()      shotgunner_load3 = [$load3, shotgunner_load4] {};
void()      shotgunner_load4 = [$load4, shotgunner_load5] {sound(self, CHAN_WEAPON, "weapons/ak47/ak47_clipout.wav", 1, ATTN_NORM); };
void()      shotgunner_load5 = [$load5, shotgunner_load6] {};
void()      shotgunner_load6 = [$load6, shotgunner_load7] {};
void()      shotgunner_load7 = [$load7, shotgunner_load8] {};
void()      shotgunner_load8 = [$load8, shotgunner_load9] {};
void()      shotgunner_load9 = [$load9, shotgunner_load10] {};
void()      shotgunner_load10 = [$load10, shotgunner_load11] {};
void()      shotgunner_load11 = [$load11, shotgunner_load12] {};
void()      shotgunner_load12 = [$load12, shotgunner_load13] {};
void()      shotgunner_load13 = [$load13, shotgunner_load14] {};
void()      shotgunner_load14 = [$load14, shotgunner_run1] {sound(self, CHAN_WEAPON, "weapons/ak47/ak47_clipin.wav", 1, ATTN_NORM); };

void()      shotgunner_firea1 = [$firea1, shotgunner_firea2]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firea2 = [$firea2, shotgunner_firea3]
{
	ai_face();
};

void()      shotgunner_firea3 = [$firea3, shotgunner_firea4]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firea4 = [$firea4, shotgunner_firea5]
{
	ai_face();
};

void()      shotgunner_firea5 = [$firea5, shotgunner_firea6]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firea6 = [$firea6, shotgunner_firea7]
{
	ai_face();
};

void()      shotgunner_firea7 = [$firea7, shotgunner_firea8]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firea8 = [$firea8, shotgunner_run1]
{
	ai_face();
	self.nextthink = time + 0.5;
	SUB_CheckRefire(shotgunner_firea1);
};


void() shotgunner_drawb1;
void() shotgunner_drawc1;

void()      shotgunner_drawa1 = [$drawa1, shotgunner_drawa2]
{
	local float temp;

	temp = random();
	ai_face();
	if (temp < 0.25)
	{
		self.think = shotgunner_drawb1;
		self.nextthink = time + 0.03;
	}
	if ((temp < 0.5) && (temp >= 0.25))
	{
		self.think = shotgunner_drawc1;
		self.nextthink = time + 0.03;
	}
	if (temp >= 0.5)
	{
		self.think = shotgunner_drawa2;
		self.nextthink = time + 0.03;
	}

};
void()      shotgunner_drawa2 = [$drawa2, shotgunner_drawa3] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawa3 = [$drawa3, shotgunner_drawa4] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawa4 = [$drawa4, shotgunner_drawa5] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawa5 = [$drawa5, shotgunner_drawa6] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawa6 = [$drawa6, shotgunner_drawa7] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawa7 = [$drawa7, shotgunner_firea1]
{
	ai_face();
	if (random() < 0.65)
	{
		if (random() < 0.5)
		{
			self.think = shotgunner_strafeleft1;
		}
		else
		{
			self.think = shotgunner_straferight1;
		}
	}
	if (self.health <= 30)
	{
		if (random() < 0.75)
		{
			if (random() < 0.5)
			{
				self.think = shotgunner_strafeleft1;
			}
			else
			{
				self.think = shotgunner_straferight1;
			}
		}
	}
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

	if (((self.absmax_z - self.enemy.absmax_z) > -50)
		&& ((vlen(self.enemy.origin - self.origin)) > 500)
		/*&& (self.firstgrenade != 23)*/)

	{
		if (random() < 0.8)
		{
			self.think = shotgunner_grenade1;
			self.attack_finished = time + 1.3;
			/* self.firstgrenade = 23;*/
		}
	}

};

/************************* END OF DRAWA  ************************/

void()      shotgunner_fireb1 = [$fireb1, shotgunner_fireb2]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}
};

void()      shotgunner_fireb2 = [$fireb2, shotgunner_run1]
{
	ai_face();
	self.nextthink = time + 0.5;
	SUB_CheckRefire(shotgunner_fireb1);
};

void()      shotgunner_drawb1 = [$drawb1, shotgunner_drawb2] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb2 = [$drawb2, shotgunner_drawb3] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb3 = [$drawb3, shotgunner_drawb4] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb4 = [$drawb4, shotgunner_drawb5] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb5 = [$drawb5, shotgunner_drawb6] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb6 = [$drawb6, shotgunner_drawb7] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb7 = [$drawb7, shotgunner_drawb8] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb8 = [$drawb8, shotgunner_drawb9] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawb9 = [$drawb9, shotgunner_fireb1]
{
	ai_face();

	if (((self.absmax_z - self.enemy.absmax_z) > -50)
		&& ((vlen(self.enemy.origin - self.origin)) > 500)
		/* && (self.firstgrenade != 23)*/)
	{
		if (random() < 0.7)
		{
			self.think = shotgunner_grenade1;
			self.attack_finished = time + 1.3;
			/*self.firstgrenade = 23;*/
		}
	}

	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

/************************** END OF DRAWB *******************************/

void()      shotgunner_firec1 = [$firec1, shotgunner_firec2]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}
};

void()      shotgunner_firec2 = [$firec2, shotgunner_firec3]
{
	ai_face();
};

void()      shotgunner_firec3 = [$firec3, shotgunner_firec4]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}
};

void()      shotgunner_firec4 = [$firec4, shotgunner_firec5]
{
	ai_face();
};

void()      shotgunner_firec5 = [$firec5, shotgunner_firec6]
{
	ai_face();
};

void()      shotgunner_firec6 = [$firec6, shotgunner_firec7]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}
};

void()      shotgunner_firec7 = [$firec7, shotgunner_firec8]
{
	ai_face();
};

void()      shotgunner_firec8 = [$firec8, shotgunner_firec9]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firec9 = [$firec9, shotgunner_firec10]
{
	ai_face();
};

void()      shotgunner_firec10 = [$firec10, shotgunner_firec11]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firec11 = [$firec11, shotgunner_firec12]
{
	ai_face();
};

void()      shotgunner_firec12 = [$firec12, shotgunner_firec13]
{
	ai_face();
	shotgunner_fire();
	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};

void()      shotgunner_firec13 = [$firec13, shotgunner_run1]
{
	ai_face();
	self.nextthink = time + 0.5;
	SUB_CheckRefire(shotgunner_firec1);
};




void()      shotgunner_drawc1 = [$drawc1, shotgunner_drawc2] {self.duck = 1; ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawc2 = [$drawc2, shotgunner_drawc3] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawc3 = [$drawc3, shotgunner_drawc4] {ai_face(); self.nextthink = time + 0.03; };
void()      shotgunner_drawc4 = [$drawc4, shotgunner_drawc5] {ai_face(); self.nextthink = time + 0.03; setsize(self, '-16 -16 -24', '16 16 32'); };
void()      shotgunner_drawc5 = [$drawc5, shotgunner_drawc6] {ai_face(); self.nextthink = time + 0.03; setsize(self, '-16 -16 -24', '16 16 30'); };
void()      shotgunner_drawc6 = [$drawc6, shotgunner_drawc7] {ai_face(); self.nextthink = time + 0.03; setsize(self, '-16 -16 -24', '16 16 28'); };
void()      shotgunner_drawc7 = [$drawc7, shotgunner_drawc8] {ai_face(); self.nextthink = time + 0.03; setsize(self, '-16 -16 -24', '16 16 24'); };
void()      shotgunner_drawc8 = [$drawc8, shotgunner_drawc9] {ai_face(); self.nextthink = time + 0.03; setsize(self, '-16 -16 -24', '16 16 22'); };
void()      shotgunner_drawc9 = [$drawc9, shotgunner_firec1]
{
	setsize(self, '-16 -16 -24', '16 16 18');
	ai_face();

	if (((self.absmax_z - self.enemy.absmax_z) > -50)
		&& ((vlen(self.enemy.origin - self.origin)) > 500)
		/*&& (self.firstgrenade != 23)*/)
	{
		if (random() < 0.6)
		{
			self.think = shotgunner_grenade1;
			self.attack_finished = time + 1.3;
			/*self.firstgrenade = 23;*/
		}
	}

	if (self.mossclip <= 0)
	{
		self.think = shotgunner_load1;
	}

};




void()	shotgunner_paina1 = [$paina1, shotgunner_paina2]
{
	if (self.health < 25)
		self.skin = 1;
};
void()	shotgunner_paina2 = [$paina2, shotgunner_paina3] {};
void()	shotgunner_paina3 = [$paina3, shotgunner_paina4] {};
void()	shotgunner_paina4 = [$paina4, shotgunner_paina5] {};
void()	shotgunner_paina5 = [$paina5, shotgunner_drawc1] {};

void()	shotgunner_painb1 = [$painb1, shotgunner_painb2]
{
	if (self.health < 25)
		self.skin = 1;
};
void()	shotgunner_painb2 = [$painb2, shotgunner_painb3] {};
void()	shotgunner_painb3 = [$painb3, shotgunner_painb4] {};
void()	shotgunner_painb4 = [$painb4, shotgunner_painb5] {};
void()	shotgunner_painb5 = [$painb5, shotgunner_drawb1] {};

void()	shotgunner_painc1 = [$painc1, shotgunner_painc2]
{
	if (self.health < 25)
		self.skin = 1;
};
void()	shotgunner_painc2 = [$painc2, shotgunner_painc3] {};
void()	shotgunner_painc3 = [$painc3, shotgunner_painc4] {};
void()	shotgunner_painc4 = [$painc4, shotgunner_painc5] {};
void()	shotgunner_painc5 = [$painc5, shotgunner_painc6] {};
void()	shotgunner_painc6 = [$painc6, shotgunner_painc7] {};
void()	shotgunner_painc7 = [$painc7, shotgunner_run1] {};

void()	shotgunner_paind1 = [$paind1, shotgunner_paind2]
{
	if (self.health < 25)
		self.skin = 1;
};
void()	shotgunner_paind2 = [$paind2, shotgunner_paind3] {};
void()	shotgunner_paind3 = [$paind3, shotgunner_paind4] {};
void()	shotgunner_paind4 = [$paind4, shotgunner_paind5] {};
void()	shotgunner_paind5 = [$paind5, shotgunner_run1] {};

void()	shotgunner_Melee =
{
	local	float	ldmg;
	local vector	delta;

	ai_face();
	walkmove(self.ideal_yaw, 12);	// allow a little closing

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 90) return;
	if (!CanDamage(self.enemy, self)) return;

	sound(self, CHAN_WEAPON, "weapons/knife/knife_hit1.wav", 1, ATTN_NORM);
	ldmg = 10 + 5 * random();
	T_Damage(self.enemy, self, self, ldmg);

	makevectors(self.angles);
};



void() shotgunnerFireGrenade =
{
	float r;
	r = random();
	if (r < 0.2) sound(self, CHAN_VOICE, "npc/grenade1.wav", 1, ATTN_NORM);
	else if (r > 0.2 && r < 0.4) sound(self, CHAN_VOICE, "npc/grenade2.wav", 1, ATTN_NORM);
	else if (r < 0.6) sound(self, CHAN_VOICE, "npc/grenade3.wav", 1, ATTN_NORM);

	local	entity missile;

	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;

	// set missile speed	
		makevectors(self.angles);

		missile.velocity = normalize(self.enemy.origin - self.origin);
		missile.velocity = missile.velocity * 400;
		missile.velocity_z = 400;

		missile.avelocity = '300 300 300';

		missile.angles = vectoangles(missile.velocity);

		missile.touch = HandGrenadeTouch;

		// set missile duration
			missile.nextthink = time + 2.5;
			missile.think = MyGrenadeExplode;

			setmodel(missile, "models/w_grenade.md3");
			setsize(missile, '0 0 0', '0 0 0');
			setorigin(missile, self.origin);
};

void(entity attacker, float damage)	shotgunner_pain =
{
	local float r;
	r = random();
	if (self.duck == 1)
	{
		self.pain_finished = time + 0.1;
		shotgunner_paina1();
	}
	else
	{
		if (r < 0.333)
		{
			self.pain_finished = time + 0.1;
			shotgunner_painb1();
			sound(self, CHAN_VOICE, "player/pain2.wav", 1, ATTN_NORM);
		}
		if ((r < 0.666) && (r >= 0.333))
		{
			self.pain_finished = time + 0.1;
			shotgunner_painc1();
			sound(self, CHAN_VOICE, "player/pain3.wav", 1, ATTN_NORM);
		}
		else
		{
			self.pain_finished = time + 0.1;
			shotgunner_paind1();
			sound(self, CHAN_VOICE, "player/pain4.wav", 1, ATTN_NORM);
		}
	}
};

void(float damage, vector dir) shotgunnerFire =
{
	if (self.duck == 1) pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -21 , self.velocity * 50, 1);
	else pointparticles(particleeffectnum("double_shotgun_muzzleflash"), self.origin + self.view_ofs + v_up * -10, self.velocity * 50, 1);

	local	vector	src;

	makevectors(self.v_angle);

	src = self.origin + v_forward * 10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline(src, src + dir * 1024, FALSE, self);
	if (trace_fraction != 1.0)
	{
		if (trace_ent.takedamage) T_Damage(trace_ent, self, self, damage);
		else
		{
			WriteByte(MSG_BROADCAST,SVC_TEMPENTITY);
			WriteByte(MSG_BROADCAST,TE_GUNSHOT);
			WriteCoord(MSG_BROADCAST,trace_ent.origin_x);
			WriteCoord(MSG_BROADCAST,trace_ent.origin_y);
			WriteCoord(MSG_BROADCAST,trace_ent.origin_z);
			particle(trace_endpos,'3.000 2.000 7.000',192.000,TE_WIZSPIKE);
			particle(trace_endpos,'7.000 6.000 8.000',192.000,TE_WIZSPIKE);
			//sound (self.enemy,CHAN_AUTO,"weapons/mp5ric1.wav",TRUE,ATTN_NORM);   
			sound(self, CHAN_WEAPON, "weapons/ak47/m4.wav", 1, ATTN_NORM);
		}
	}
};

void() shotgunner_fire =
{
	local	vector	dir;
	local	entity	en;

	ai_face();

	sound(self, CHAN_WEAPON, "weapons/toz/toz-1.wav", 1, ATTN_NORM);
	// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	dir = (en.origin + '0 0 -8') - en.velocity * 0.2;
	dir = normalize(dir - self.origin);

	//guardFire(17,dir);
	FireMossberg(16, dir, '0.08 0.06 0.0');
	self.mossclip = self.mossclip - 1;
};

void()      shotgunner_melee1 = [$melee1, shotgunner_melee2] {ai_face(); };
void()      shotgunner_melee2 = [$melee2, shotgunner_melee3] {ai_face(); };
void()      shotgunner_melee3 = [$melee3, shotgunner_melee4] {ai_face(); };
void()      shotgunner_melee4 = [$melee4, shotgunner_melee5] {ai_face(); };
void()      shotgunner_melee5 = [$melee5, shotgunner_melee6] {ai_face(); };
void()      shotgunner_melee6 = [$melee6, shotgunner_melee7] {ai_face(); shotgunner_Melee(); };
void()      shotgunner_melee7 = [$melee7, shotgunner_melee8] {ai_face(); shotgunner_Melee(); };
void()      shotgunner_melee8 = [$melee8, shotgunner_melee9] {ai_face(); };
void()      shotgunner_melee9 = [$melee9, shotgunner_melee10] {ai_face(); };
void()      shotgunner_melee10 = [$melee10, shotgunner_run1] {ai_face(); };

void()	shotgunner_died1 = [$deathd1, shotgunner_died2] {self.nextthink = time + 0.03; };
void()	shotgunner_died2 = [$deathd2, shotgunner_died3] {self.nextthink = time + 0.03; };
void()	shotgunner_died3 = [$deathd3, shotgunner_died4]
{
	self.nextthink = time + 0.03;
	self.solid = SOLID_NOT;
	self.ammo545x39 = ceil(self.mossclip * 0.5);
	//  Drop_Clip();
};
void()	shotgunner_died4 = [$deathd4, shotgunner_died5]
{
	if (self.headshot == 1)  self.skin = 2;
	self.nextthink = time + 0.03;
};
void()	shotgunner_died5 = [$deathd5, shotgunner_died6] {self.nextthink = time + 0.03; };
void()	shotgunner_died6 = [$deathd6, shotgunner_died7] {self.nextthink = time + 0.03; };
void()	shotgunner_died7 = [$deathd7, shotgunner_died8] {self.nextthink = time + 0.03; };
void()	shotgunner_died8 = [$deathd8, shotgunner_died9] {self.nextthink = time + 0.03; };
void()	shotgunner_died9 = [$deathd9, shotgunner_died9] {};


void()	shotgunner_diea1 = [$deatha1, shotgunner_diea2]
{
	if (self.headshot == 1) self.skin = 2;
	self.nextthink = time + 0.03;
};
void()	shotgunner_diea2 = [$deatha2, shotgunner_diea3] {self.nextthink = time + 0.03; };
void()	shotgunner_diea3 = [$deatha3, shotgunner_diea4]
{
	self.nextthink = time + 0.03;
	self.solid = SOLID_NOT;
	self.ammo545x39 = ceil(self.mossclip * 0.5);
	//Drop_Clip();
};
void()	shotgunner_diea4 = [$deatha4, shotgunner_diea5] {self.nextthink = time + 0.03; };
void()	shotgunner_diea5 = [$deatha5, shotgunner_diea6] {self.nextthink = time + 0.03; };
void()	shotgunner_diea6 = [$deatha6, shotgunner_diea7] {self.nextthink = time + 0.03; };
void()	shotgunner_diea7 = [$deatha7, shotgunner_diea8] {self.nextthink = time + 0.03; };
void()	shotgunner_diea8 = [$deatha8, shotgunner_diea9] {self.nextthink = time + 0.03; };
void()	shotgunner_diea9 = [$deatha9, shotgunner_diea10] {self.nextthink = time + 0.03; };
void()	shotgunner_diea10 = [$deatha10, shotgunner_diea10] {};


void()	shotgunner_dieb1 = [$deathb1, shotgunner_dieb2]
{
	if (self.headshot == 1) self.skin = 2;
	self.nextthink = time + 0.03;
};
void()	shotgunner_dieb2 = [$deathb2, shotgunner_dieb3] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb3 = [$deathb3, shotgunner_dieb4]
{
	self.nextthink = time + 0.03;
	self.solid = SOLID_NOT;
	self.ammo545x39 = ceil(self.mossclip * 0.5);
	// Drop_Clip();
};
void()	shotgunner_dieb4 = [$deathb4, shotgunner_dieb5] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb5 = [$deathb5, shotgunner_dieb6] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb6 = [$deathb6, shotgunner_dieb7] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb7 = [$deathb7, shotgunner_dieb8] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb8 = [$deathb8, shotgunner_dieb9] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb9 = [$deathb9, shotgunner_dieb10] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb10 = [$deathb10, shotgunner_dieb11] {self.nextthink = time + 0.03; };
void()	shotgunner_dieb11 = [$deathb11, shotgunner_dieb11] {};

void()	shotgunner_diec1 = [$deathc1, shotgunner_diec2]
{
	if (self.headshot == 1) self.skin = 2;
	self.nextthink = time + 0.03;
};
void()	shotgunner_diec2 = [$deathc2, shotgunner_diec3] {self.nextthink = time + 0.03; };
void()	shotgunner_diec3 = [$deathc3, shotgunner_diec4]
{
	self.nextthink = time + 0.03;
	self.solid = SOLID_NOT;
	self.ammo545x39 = ceil(self.mossclip * 0.5);
	// Drop_Clip();
	ai_back(4);
};
void()	shotgunner_diec4 = [$deathc4, shotgunner_diec5] {self.nextthink = time + 0.03; };
void()	shotgunner_diec5 = [$deathc5, shotgunner_diec6] {self.nextthink = time + 0.03; };
void()	shotgunner_diec6 = [$deathc6, shotgunner_diec7] {self.nextthink = time + 0.03; };
void()	shotgunner_diec7 = [$deathc7, shotgunner_diec8] {self.nextthink = time + 0.03; };
void()	shotgunner_diec8 = [$deathc8, shotgunner_diec9] {self.nextthink = time + 0.03; };
void()	shotgunner_diec9 = [$deathc9, shotgunner_diec10] {self.nextthink = time + 0.03; };
void()	shotgunner_diec10 = [$deathc10, shotgunner_diec11] {self.nextthink = time + 0.03; };
void()	shotgunner_diec11 = [$deathc11, shotgunner_diec12] {self.nextthink = time + 0.03; };
void()	shotgunner_diec12 = [$deathc12, shotgunner_diec12] {self.nextthink = time + 0.03; };


void() shotgunner_die =
{
	local float temp;
	temp = random();
	self.ammo_shells = self.mossclip;
	DropShells();
	
	if (self.duck == 1)
	{
		shotgunner_diea1();
		self.flags = self.flags + FL_ONGROUND;
		sound(self, CHAN_VOICE, "player/death2.wav", 1, ATTN_NORM);
	}
	else
	{
		if (temp < 0.333)
		{
			shotgunner_dieb1();
			sound(self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
			self.flags = 32;
			self.velocity_z = self.velocity_z + 350;
		}
		else if ((temp < 0.666) && (temp >= 0.333))
		{
			shotgunner_diec1();
			sound(self, CHAN_VOICE, "player/death2.wav", 1, ATTN_NORM);
			self.flags = 32;
			self.velocity_z = self.velocity_z + 350;
		}
		else if (temp >= 0.666)
		{
			shotgunner_died1();
			sound(self, CHAN_VOICE, "player/death2.wav", 1 , ATTN_NORM);
		}
	}
};


/*QUAKED shotgunner_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/

void() monster_shotguner =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2("models/npc/medium.md3");
	precache_sound2("npc/grenade1.wav");
	precache_sound2("npc/grenade2.wav");
	precache_sound2("npc/grenade3.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;


	setmodel(self, "models/npc/medium.md3");

	setsize(self, '-9 -9 -24', '9 9 34');
	self.health = 80;
	self.mossclip = 7;
	self.th_stand = shotgunner_stand1;
	self.th_walk = shotgunner_walk1;
	self.th_run = shotgunner_run1;
	self.th_missile = shotgunner_drawa1;
	self.th_melee = shotgunner_melee1;
	self.th_pain = shotgunner_pain;
	self.th_die = shotgunner_die;

	walkmonster_start();
};


