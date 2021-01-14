/*
	==============================================================================
	
	PLAYER
	
	==============================================================================
*/

$cd id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 // 0
$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12 run13 run14 run15 run16 run17 run18	//1-18
$frame crouch1 //19
$frame crouchrun1 crouchrun2 crouchrun3 crouchrun4 crouchrun5 crouchrun6 crouchrun7 crouchrun8 crouchrun9
$frame crouchrun10 crouchrun11 crouchrun12 crouchrun13 crouchrun14 crouchrun15 crouchrun16 crouchrun17
$frame crouchrun18 crouchrun19 crouchrun20 crouchrun21 crouchrun22 crouchrun23 crouchrun24 crouchrun25 //20-42
$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8 deatha9 deatha10 deatha11	//43-53				
$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8 deathb9 deathb10 deathb11	//54-64
$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8 deathc9 deathc10 deathc11	//57

/*
	==============================================================================
	PLAYER
	==============================================================================
*/
void() playerAnim =
{
	if (self.velocity_x || self.velocity_y)
	{
		if(self.anim_finished + 0.06 < time)
		{
			if(self.duck)
			{
				if (self.walkframe >= $crouchrun25 || self.walkframe < $crouchrun1) self.walkframe = $crouchrun1;
				self.walkframe = self.walkframe + 1;
			}
			else
			{
				if (self.walkframe >= 17) self.walkframe = 1;
				if(self.button3) self.walkframe = self.walkframe + 1;	//walk
				else self.walkframe = self.walkframe + 1.5;
			}
			self.anim_finished = time;
		}
		self.frame = self.walkframe;
	}
	else
	{
		if(self.duck == 1) self.frame = $crouch1;
		else self.frame = $stand1;
	}
}

void() shell_touch = 
{
	//bprint("debug shell_touch()\n");
	if ((other.classname == "door")) 
	{
		SUB_Remove ();
		return ;
	}
	
	if (self.owner.weaponmodel == "models/v_shot.md3" || self.weaponmodel == "models/v_shot_usa.md3") sound (self,CHAN_WEAPON,"weapons/shell2.wav",0.5,ATTN_NORM);
	else sound (self,CHAN_WEAPON,"weapons/shell1.wav",0.5,ATTN_NORM);
};

void (vector org, vector dir) eject_shell = 
{
	//bprint("debug eject_shell()\n");
	local float r;
	
	makevectors (self.v_angle);
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_BOUNCE;
	r = random ();
	if (r < 0.5) newmis.solid = SOLID_BBOX;
	else newmis.solid = SOLID_NOT;
	newmis.angles = v_forward * (r + 1);
	newmis.classname = "shellcasing";
	newmis.touch = shell_touch;
	newmis.think = SUB_Remove;
	newmis.owner = self;
	newmis.nextthink = time + 1.5;
	
	if (self.weapon == WP_SHOTGUN) setmodel (newmis,"models/shells/shotgunShell.md3");
	else if (self.weapon == WP_PISTOL) setmodel (newmis,"models/shells/pistolShell.md3");
	else if (self.weapon == WP_SNIPER) setmodel (newmis,"models/shells/sniperShell.md3");
	else setmodel (newmis,"models/shells/rifleShell.md3");
	
	setsize (newmis,VEC_ORIGIN,VEC_ORIGIN);
	setorigin (newmis,org);
	newmis.avelocity_x = (r * 6000);
	newmis.avelocity_y = (r * 6000);
	
	if (r < 0.100 && r >= MSG_BROADCAST) newmis.velocity = (((v_forward * 20) + (v_right * 60)) + (v_up * 80));
	if (r < 0.200 && r >= 0.100) newmis.velocity = (((v_forward * SVC_INTERMISSION) + (v_right * 65)) + (v_up * 90));
	if (r < 0.300 && r >= 0.200) newmis.velocity = (((v_forward * 25) + (v_right * 70)) + (v_up * 100));
	if (r < 0.400 && r >= 0.300) newmis.velocity = (((v_forward * 15) + (v_right * 75)) + (v_up * 110));
	if (r < 0.500 && r >= 0.400) newmis.velocity = (((v_forward * 25) + (v_right * 80)) + (v_up * 130));
	if (r < 0.600 && r >= 0.500) newmis.velocity = (((v_forward * 20) + (v_right * 85)) + (v_up * 150));
	if (r < 0.700 && r >= 0.600) newmis.velocity = (((v_forward * TE_LAVASPLASH) + (v_right * 90)) + (v_up * 120));
	if (r < 0.800 && r >= 0.700) newmis.velocity = (((v_forward * 20) + (v_right * 100)) + (v_up * 200));
	if (r < 0.900 && r >= 0.800) newmis.velocity = (((v_forward * SVC_INTERMISSION) + (v_right * 110)) + (v_up * 130));
	if (r <= WEAPON_SHOTGUN && r >= 0.900)newmis.velocity = (((v_forward * 25) + (v_right * 105)) + (v_up * 175));
};




void() player_run;
void() player_stand1 =[ $run1, player_stand1 ]
{
	if(fabs(self.punchangle_x) < 1 && !self.button0) self.ShootsFired = 0;
	if (vlen(self.velocity) >= 20)
	{
		self.walkframe = 0;
		player_run();
		return;
	}
	if (self.zoomlevel == 1 && self.weapon != WP_SNIPER) self.zoomlevel = 0;
	self.weaponframe = 0;
	self.walkframe = 0;
	if(self.duck == 1) self.frame = $crouch1;
	else self.frame = $stand1;
	
};

void()	player_run =[ $run1, player_run ]
{
	if(fabs(self.punchangle_x) < 1 && !self.button0) self.ShootsFired = 0;
	if (self.zoomlevel == 1 && self.weapon != WP_SNIPER) self.zoomlevel = 0;
	self.weaponframe = 0;
	self.reload = 0;
	if (vlen(self.velocity) < 20)
	{
		self.walkframe = 0;
		player_stand1();
		return;
	}
	
	playerAnim();
};
	
void (vector position, vector direction) Shoot_Blood = 
{
	SpawnBlood(position, direction, 10);
};
	

void() PainSound =
{
	//bprint("debug PainSound()\n");
	local float		rs;
	if (self.health < 0) return;
	
	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
		return;
	}
	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.1; // don't make multiple pain sounds right after each other
		
	// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, CHAN_VOICE, "weapons/knife/hit.wav", 1, ATTN_NORM);
		return;
	}
	
	rs = rint((random() * 7) + 1);
	switch(rs)
	{
		case 1:
			self.noise = "player/pain1.wav";
			break;
		case 2:
			self.noise = "player/pain2.wav";
			break;
		case 3:
			self.noise = "player/pain3.wav";
			break;
		case 4:
			self.noise = "player/pain4.wav";
			break;
		case 5:
			self.noise = "player/pain5.wav";
			break;
		case 6:
			self.noise = "player/pain6.wav";
			break;
		default:
			self.noise = "player/pain7.wav";
			break;
	}
			
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
};

// void()	player_pain1 =	[	$pain1,	player_pain2	] {};
// void()	player_pain2 =	[	$pain2,	player_pain3	] {};
// void()	player_pain3 =	[	$pain3,	player_pain4	] {};
// void()	player_pain4 =	[	$pain4,	player_pain5	] {};
// void()	player_pain5 =	[	$pain5,	player_run		] {};

// void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();};
// void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
// void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
// void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
// void()	player_axpain5 =	[	$axpain5,	player_run	] {};

void() player_pain =
{
	//bprint("debug player_pain()\n");
	PainSound();
	if (self.weaponframe) return;
	//if (self.invisible_finished > time) return;		// eyes don't have pain frames
	//if (self.weapon == WP_ONE) player_axpain1 ();
	//else player_pain1 ();
};
	
void() player_diea1;
void() player_dieb1;
void() player_diec1;

void() DeathSound =
{
	//bprint("debug DeathSound()\n");
	local float		rs;
	rs = rint ((random() * 2) + 1);
	if (rs == 1) self.noise = "player/death1.wav";
	else if (rs == 2) self.noise = "player/death2.wav";
	else self.noise = "player/death3.wav";
	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
};


void() PlayerDead =
{
	//bprint("debug PlayerDead()\n");
	self.nextthink = -1;
	// allow respawn after a certain time
	self.deadflag = DEAD_DEAD;
};

vector(float dm) VelocityForDamage =
{
	//bprint("debug VelocityForDamage()\n");
	local vector v;

	v_x = 100 * crandom();
	v_y = 100 * crandom();
	v_z = 200 + 100 * random();

	if (dm > -50)
	{
		//		dprint ("level 1\n");
		v = v * 0.7;
	}
	else if (dm > -200)
	{
		//		dprint ("level 3\n");
		v = v * 2;
	}
	else v = v * 10;
	return v;
};

void(string gibname, float dm) ThrowGib =
{
	//bprint("debug ThrowGib()\n");
	local	entity new;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, gibname);
	setsize (new, '0 0 0', '0 0 0');
	new.scale = 0.8;
	new.velocity = VelocityForDamage (dm);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_NOT;
	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;
	new.think = SUB_Remove;
	new.ltime = time;
	new.nextthink = time + 10 + random()*10;
	new.frame = 0;
	new.flags = 0;
};

void(string gibname, float dm) ThrowHead =
{
	//bprint("debug ThrowHead()\n");
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '0 0 0', '0 0 0');
	//setsize (self, '-16 -16 0', '16 16 56');
	//self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
};

void()	headless_corpse1	=	[0,		headless_corpse2] 
{
	//bprint("debug headless_corpse1()\n");
	self.nextthink = time + 0.09;
	Shoot_Blood (self.origin + '10 10 0',v_forward * 2000);
	Shoot_Blood (self.origin,v_forward * 2000);
	//sound (self, CHAN_VOICE, "wizard/hit.wav", 1, ATTN_NONE);
};

void()      headless_corpse2 =     [1,         headless_corpse3]{self.nextthink = time + 0.09;};    
void()      headless_corpse3 =     [2,         headless_corpse4]{self.nextthink = time + 0.09;};
void()      headless_corpse4 =     [3,         headless_corpse5]{self.nextthink = time + 0.09;};  
void()      headless_corpse5 =     [4,         headless_corpse6]{self.nextthink = time + 0.09;};
void()      headless_corpse6 =     [5,         headless_corpse7]{self.nextthink = time + 0.09;};
void()      headless_corpse7 =     [6,         headless_corpse8]{self.nextthink = time + 0.09;};   
void()      headless_corpse8 =     [7,         headless_corpse9]{self.nextthink = time + 0.09;};
void()      headless_corpse9 =     [8,         headless_corpse10]{self.nextthink = time + 0.09;};   
void()      headless_corpse10 =     [9,         headless_corpse10]{self.nextthink = time + 112;};  

void(string gibname, float dm) ThrowHeadlessCorpse =
{
	//bprint("debug ThrowHeadlessCorpse()\n");
	setmodel (self, gibname);
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 -24', '16 16 35');
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 0 0';

	headless_corpse10 ();
};

void()	blasted_corpse1	=	[0,		blasted_corpse2] 
{
	self.nextthink = time + 0.03;
	particle ((self.origin),'0 0 3',72,38);
	particle ((self.origin),'0 3 3',72,38);
	particle ((self.origin),'0 -3 3',72,38);
	particle ((self.origin),'3 0 3',72,38);
	particle ((self.origin),'-3 0 3',72,38);
};
void()	blasted_corpse2	=	[1,		blasted_corpse3] {self.nextthink = time + 0.035;};
void()	blasted_corpse3	=	[2,		blasted_corpse4] {self.nextthink = time + 0.035;};
void()	blasted_corpse4	=	[3,		blasted_corpse5] {self.nextthink = time + 0.035;};
void()	blasted_corpse5	=	[4,		blasted_corpse6] {self.nextthink = time + 0.035;};
void()	blasted_corpse6	=	[5,		blasted_corpse7] {self.nextthink = time + 0.035;};
void()	blasted_corpse7	=	[6,		blasted_corpse8] {self.nextthink = time + 0.035;};
void()	blasted_corpse8	=	[7,		blasted_corpse9] {self.nextthink = time + 0.035;};
void()	blasted_corpse9	=	[8,		blasted_corpse10] {self.nextthink = time + 0.035;};
void()	blasted_corpse10	=	[9,		blasted_corpse10] {self.nextthink = time + 112;};

void(string gibname, float dm) ThrowBlastedCorpse =
{
	//bprint("debug ThrowBlastedCorpse()\n");
	setmodel (self, gibname);
	self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
	self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 -24', '16 16 35');
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 0 0';

	blasted_corpse1 ();
};

void(string gibname, float dm) ThrowChunk =
{
	//bprint("debug ThrowChunk()\n");
	local	entity new;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, gibname);
	new.view_ofs = '0 0 8';
	setsize (new, '-16 -16 0', '16 16 56');
	new.velocity = VelocityForDamage (dm);
	new.movetype = MOVETYPE_BOUNCE;
	new.solid = SOLID_NOT;
	new.avelocity = crandom() * '0 600 0';
	new.think = SUB_Remove;
	new.ltime = time;
	new.nextthink = time + 10 + random()*10;
	new.frame = 0;
	new.flags = new.flags - (new.flags & FL_ONGROUND);
};
	
void() GibPlayer =
{
	//bprint("debug GibPlayer()\n");
	ThrowHead ("models/gib1.bsp", self.health);
	ThrowGib ("models/gib1.bsp", self.health);
	ThrowGib ("models/gib2.bsp", self.health);
	ThrowGib ("models/gib3.bsp", self.health);

	self.deadflag = DEAD_DEAD;

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
		return;
	}

	sound (self, CHAN_VOICE, "player/death3.wav", 1, ATTN_NORM);
};
	

	
void() DropBomb =
{
	//bprint("debug DropBomb()\n");
	local entity	item;

	item = spawn();
	item.origin = self.origin - '0 0 24';

	item.items = IT_BOMB;
	item.netname = "explosive charge";
	item.classname = "weapon_bomb_dropped";

	item.velocity_z = 300;
	item.velocity_x = -100 + (random() * 200);
	item.velocity_y = -100 + (random() * 200);

	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	setmodel (item, "models/w_bomb.md3");
	setsize (item, '-16 -16 0', '16 16 56');
	item.touch = BackpackTouch;

	item.nextthink = time + 120;	// remove after 2 minutes
	item.think = SUB_Remove;
};

void() W_FireHandGrenade;
void() PlayerDie =
{
	//bprint("debug PlayerDie()\n");
	local	float	i;
	
	self.items = self.items - (self.items & IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.invincible_finished = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	
	//if (deathmatch || coop) DropBackpack();
	if(deathmatch && self.items & IT_BOMB)  DropBomb();
	if(self.grenadetime > 10) { self.grenadetime = 1; W_FireHandGrenade (); }
	
	self.weaponmodel = "";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10) self.velocity_z = self.velocity_z + random()*300;
	
	if (self.health < -40)
	{
		GibPlayer ();
		return;
	}
	
	DeathSound();
	
	self.angles_x = 0;
	self.angles_z = 0;
	
	// if (self.weapon == WP_ONE)
	// {
	// player_die_ax1 ();
	// return;
	// }
	
	i = cvar("temp1");
	//if (!i) i = 1 + floor(random()*2);
	i = random();
	if (i <= 0.5) player_diea1();
	else player_dieb1();
	// else if (i <= 1) player_diec1();

};
	
void() set_suicide_frame =
{	
	//bprint("debug set_suicide_frame()\n");
	// used by klill command and diconnect command
	//if (self.model != "progs/player.mdl") return;	// allready gibbed
	self.frame = $deatha11;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_TOSS;
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
};
	
void()	player_diea1	=	[	$deatha1,	player_diea2	] {};
void()	player_diea2	=	[	$deatha2,	player_diea3	] {};
void()	player_diea3	=	[	$deatha3,	player_diea4	] {};
void()	player_diea4	=	[	$deatha4,	player_diea5	] {};
void()	player_diea5	=	[	$deatha5,	player_diea6	] {};
void()	player_diea6	=	[	$deatha6,	player_diea7	] {};
void()	player_diea7	=	[	$deatha7,	player_diea8	] {};
void()	player_diea8	=	[	$deatha8,	player_diea9	] {};
void()	player_diea9	=	[	$deatha9,	player_diea10	] {};
void()	player_diea10	=	[	$deatha10,	player_diea11 	] {};
void()	player_diea11	=	[	$deatha11,	player_diea11 ] {PlayerDead();};

void()	player_dieb1	=	[	$deathb1,	player_dieb2	] {};
void()	player_dieb2	=	[	$deathb2,	player_dieb3	] {};
void()	player_dieb3	=	[	$deathb3,	player_dieb4	] {};
void()	player_dieb4	=	[	$deathb4,	player_dieb5	] {};
void()	player_dieb5	=	[	$deathb5,	player_dieb6	] {};
void()	player_dieb6	=	[	$deathb6,	player_dieb7	] {};
void()	player_dieb7	=	[	$deathb7,	player_dieb8	] {};
void()	player_dieb8	=	[	$deathb8,	player_dieb9	] {};
void()	player_dieb9	=	[	$deathb9,	player_dieb10	] {};
void()	player_dieb10	=	[	$deathb10,	player_dieb11	] {};
void()	player_dieb11	=	[	$deathb11,	player_dieb11	] {PlayerDead();};

void()	player_diec1	=	[	$deathc1,	player_diec2	] {};
void()	player_diec2	=	[	$deathc2,	player_diec3	] {};
void()	player_diec3	=	[	$deathc3,	player_diec4	] {};
void()	player_diec4	=	[	$deathc4,	player_diec5	] {};
void()	player_diec5	=	[	$deathc5,	player_diec6	] {};
void()	player_diec6	=	[	$deathc6,	player_diec7	] {};
void()	player_diec7	=	[	$deathc7,	player_diec8	] {};
void()	player_diec8	=	[	$deathc8,	player_diec9	] {};
void()	player_diec9	=	[	$deathc9,	player_diec10	] {};
void()	player_diec10	=	[	$deathc10,	player_diec11 ] {};
void()	player_diec11	=	[	$deathc11,	player_diec11 ] {PlayerDead();};	