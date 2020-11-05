void() bomb_side_touch;

void RespawnBomb()
{
	local entity e;
	e = find(world, classname, "weapon_bomb");
	if(e) 
	{
		e.mdl = "models/w_bomb.md3";
		e.model = "models/w_bomb.md3";
		setmodel(e, "models/w_bomb.md3");
		e.nextthink = time + 0.1;
		e.think = SUB_regen;
	}
}

void EndRound()
{
	local entity e;
	local entity spot;
	local entity thing;
	local entity backup;
	local float  pcount;
	local float USSRPlayers;
	local float USAPlayers;
	for (e = findchain(classname, "weapon_bomb_dropped"); e; e = e.chain) 
	{
		remove(e);
	}
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		if(e.team == TEAM_USSR) USSRPlayers = USSRPlayers + 1;
		else if(e.team == TEAM_USA) USAPlayers = USAPlayers + 1;
	}
	RespawnBomb();
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		if(USSRPlayers + USAPlayers > 2)	//auto team balance
		{
			if(USSRPlayers < USAPlayers -1)
			{
				if(e.team == TEAM_USA)
				{
					USAPlayers = USAPlayers -1;
					e.team = TEAM_USSR;
				}
			}
			if(USAPlayers < USSRPlayers -1)
			{
				if(e.team == TEAM_USSR)
				{
					USSRPlayers = USSRPlayers -1;
					e.team = TEAM_USA;
				}
			}
		}
		//spot = self;
		//self = e;
		
		if(e.class == CLASS_SHTORMTROOPER) SetNewParmsStormtrooper();
		else if(e.class == CLASS_BREACHER) SetNewParmsBreacher();
		else if(e.class == CLASS_MARKSMAN) SetNewParmsMarksman();
		else if(e.class == CLASS_ENGINEER) SetNewParmsEngineer();
		else if(e.class == CLASS_ASSASSIN) SetNewParmsAssassin();
		else SetNewParms();
		
		//spot = SelectSpawnPoint ();
		spot = lastspawn;	
		while (1)
		{
			if(e.team == TEAM_USSR) spot = find(spot, classname, "info_player_ussr"); 
			else if(e.team == TEAM_USA) spot = find(spot, classname, "info_player_usa"); 
			if (spot != world)
			{
				if (spot == lastspawn) break;
				pcount = 0;
				thing = findradius(spot.origin, 32);
				while(thing)
				{
					if (thing.classname == "player") pcount = pcount + 1;
					thing = thing.chain;
				}
				if (pcount == 0)
				{
					lastspawn = spot;
					break;
				}
			}
		}
		
		e.classname = "player";
		e.health = 100;
		e.takedamage = DAMAGE_AIM;
		e.solid = SOLID_SLIDEBOX;
		e.movetype = MOVETYPE_WALK;
		e.show_hostile = 0;
		e.max_health = 100;
		e.flags = FL_CLIENT;
		e.air_finished = time + 12;
		e.dmg = 2;   		// initial water damage
		e.super_damage_finished = 0;
		e.radsuit_finished = 0;
		e.invisible_finished = 0;
		e.invincible_finished = 0;
		e.effects = 0;
		e.invincible_time = 0;
		
		e.items = parm1;
		e.health = parm2;
		e.armorvalue = parm3;
		e.ammo_9x18 = parm4;
		e.ammo545x39 = parm5;
		e.ammo_rockets = parm6;
		e.ammo_shells = parm7;
		e.ammo_762x54 = parm17;
		e.weapon = parm8;
		e.armortype = parm9 * 0.01;
		e.weapons = parm10;
		e.PMclip = parm11;
		e.mossclip = parm12;
		e.AKMclip = parm13;
		e.psg1clip = parm15;
		e.m60clip = parm16;
		
		backup = self;
		self = e;
		W_SetCurrentAmmo();
		e = self;
		self = backup;
		
		e.attack_finished = time;
		e.th_pain = player_pain;
		e.th_die = PlayerDie;
		e.deadflag = DEAD_NO;
		
		e.pausetime = 0;
		e.origin = e.oldorigin = spot.origin + '0 0 1';	// 1998-07-21 Respawning where player died fix by Robert Field
		e.angles = spot.angles;
		e.fixangle = TRUE;		// turn this way immediately

		if(e.weapon == WP_PM) 
		{
			if(e.team == TEAM_USA) setmodel (e, "models/usa_glock.md3");
			else setmodel (e, "models/ussr_aps.md3");
		}
		else if(e.weapon == WP_ONE) 
		{
			if (deathmatch == MODE_HNS) setmodel (e, "models/runner_blue.md3");
			else
			{
				if(e.team == TEAM_USA) setmodel (e, "models/usa_knife.md3");
				else setmodel (e, "models/ussr_knife.md3");
			}
		}
		else if(e.weapon == WP_TOZ)
		{
			if(e.team == TEAM_USA) setmodel (e, "models/usa_xm.md3");
			else setmodel (e, "models/ussr_toz.md3");
		}
		else if(e.weapon == WP_AKM)
		{
			if(e.team == TEAM_USA) setmodel (e, "models/usa_m4.md3");
			else setmodel (e, "models/ussr_ak74.md3");
		}
		else if(e.weapon == WP_MOSIN)
		{
			if(e.team == TEAM_USA) setmodel (e, "models/usa_awp.md3");
			else setmodel (e, "models/ussr_mosin.md3");
		}
		else setmodel (e, "models/runner_red.md3");
		
		modelindex_ussr_aps = e.modelindex;

		setsize (e, VEC_HULL_MIN, VEC_HULL_MAX);
		e.view_ofs = '0 0 22';
		e.velocity = '0 0 0';

		if (deathmatch || coop)
		{
			makevectors(e.angles);
			spawn_tfog (e.origin + v_forward*20);
		}
		spawn_tdeath (e.origin, e);
		
		// if(self.class == CLASS_SHTORMTROOPER) SetNewParmsStormtrooper();
		// else if(self.class == CLASS_BREACHER) SetNewParmsBreacher();
		// else if(self.class == CLASS_MARKSMAN) SetNewParmsMarksman();
		// else SetNewParms();
		// PutClientInServer (); // respawn	
	}
	// bprint("USSR: ");
	// bprint(ftos(USSRPlayers));
	// bprint(" USA: ");
	// bprint(ftos(USAPlayers));
	// bprint("\n");
	
	//self = spot;
}

void() USA_Win =
{
	local entity e;
	e = find(self, classname, "bomb");
	if(e) remove(e);
	bprint("USA WON\n");
	self.wait = time;
	self.touch = bomb_side_touch;
	if(self.classname == "bomb_sideB")
	{
		e = find(world, classname, "bomb_side");
		if(e) 
		{
			e.touch = bomb_side_touch;
			e.wait = time;
		}
	}
	else 
	{
		e = find(world, classname, "bomb_sideB");
		if(e) 
		{
			e.touch = bomb_side_touch;
			e.wait = time;
		}
	}
	EndRound();
	if(random() < 0.5) sound (self, CHAN_VOICE, "usa/win1.wav", 1, ATTN_NONE);
	else sound (self, CHAN_VOICE, "usa/win2.wav", 1, ATTN_NONE);
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		centerprint(e, "USA WON");
	}
}

void() USSR_Win =
{
	local entity e;
	e = find(self, classname, "bomb");
	if(e) remove(e);
	bprint("USSR WON\n");
	self.wait = time;
	self.touch = bomb_side_touch;
	if(self.classname == "bomb_sideB")
	{
		e = find(world, classname, "bomb_side");
		if(e) 
		{
			e.touch = bomb_side_touch;
			e.wait = time;
		}
	}
	else 
	{
		e = find(world, classname, "bomb_sideB");
		if(e) 
		{
			e.touch = bomb_side_touch;
			e.wait = time;
		}
	}
	EndRound();
	
	local float r;
	r = random();
	if(r < 0.333) sound (self, CHAN_VOICE, "ussr/win1.wav", 1, ATTN_NONE);
	else if(r > 0.333 && r < 0.666) sound (self, CHAN_VOICE, "ussr/win2.wav", 1, ATTN_NONE);
	else sound (self, CHAN_VOICE, "ussr/win3.wav", 1, ATTN_NONE);
	
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		centerprint(e, "USSR WON");
	}
}

void() bomb_post_think = 
{
	local entity e;
	local float timer;
	timer = time - self.wait;
	if(timer >= 38)
	{
		bprint("USSR WON\n");
		self.owner.wait = time;
		self.owner.touch = bomb_side_touch;
		if(self.owner.classname == "bomb_sideB")
		{
			e = find(world, classname, "bomb_side");
			if(e) 
			{
				e.touch = bomb_side_touch;
				e.wait = time;
			}
		}
		else 
		{
			e = find(world, classname, "bomb_sideB");
			if(e) 
			{
				e.touch = bomb_side_touch;
				e.wait = time;
			}
		}
		EndRound();
		
		for (e = findchain(classname, "player"); e; e = e.chain) 
		{
			centerprint(e, "USSR WON");
		}
		self.think = SUB_Remove;
		remove(self);
		
	}
		
	self.nextthink = time + 0.1;
}
void() bombexplode1 = [0, bombexplode2] {
    self.nextthink = time + 0.02;	
	sound (self, CHAN_WEAPON, "bomb/c4explode.wav", 0.8, ATTN_NONE);	// bounce sound
};
void()	bombexplode2	=	[1,	bombexplode3] {self.nextthink = time + 0.02;};
void()	bombexplode3	=	[2,	bombexplode4] {self.nextthink = time + 0.02;};
void()	bombexplode4	=	[3,	bombexplode5] {self.nextthink = time + 0.02;};
void()	bombexplode5	=	[4,	bombexplode6] {self.nextthink = time + 0.02;};
void()	bombexplode6	=	[5,	bombexplode7] {self.nextthink = time + 0.02;};
void()	bombexplode7	=	[6,	bombexplode8] {self.nextthink = time + 0.02;};
void()	bombexplode8	=	[7,	bombexplode9] {self.nextthink = time + 0.02;};
void()	bombexplode9	=	[8,	bombexplode10] {self.nextthink = time + 0.03;};
void()	bombexplode10   =   [9,	bombexplode11] {self.nextthink = time + 0.03;};
void()	bombexplode11	=	[10,bombexplode12] {self.nextthink = time + 0.03;};
void()	bombexplode12	=	[11,bombexplode13] {self.nextthink = time + 0.03;};
void()	bombexplode13	=	[12,bombexplode14] {self.nextthink = time + 0.03;};
void()	bombexplode14	=	[13,bombexplode15] {self.nextthink = time + 0.03;};
void()	bombexplode15	=	[14,bombexplode16] {self.nextthink = time + 0.03;};
void()	bombexplode16	=	[15,bombexplode17] {self.nextthink = time + 0.03;};
void()	bombexplode17	=	[16,bomb_post_think] 
{
	local float r;
	r = random();
	if(r < 0.333) sound (self, CHAN_VOICE, "ussr/win1.wav", 1, ATTN_NONE);
	else if(r > 0.333 && r < 0.666) sound (self, CHAN_VOICE, "ussr/win2.wav", 1, ATTN_NONE);
	else sound (self, CHAN_VOICE, "ussr/win3.wav", 1, ATTN_NONE);
	setmodel(self, "");
	self.light_lev = 0;
	self.nextthink = time + 0.03;
};



void(entity inflictor, entity attacker, float damage) T_BombRadiusDamage =
{
	local	float 	points;
	local	entity	head;
	local	vector	org;

	head = findradius(inflictor.origin, damage+200);

	while (head)
	{
		if (head.takedamage)
		{
			org = head.origin + (head.mins + head.maxs)*0.5;
			points = damage - (vlen (inflictor.origin - org) * 0.9);
			points = points * 0.8;
			if (points > 0)
			{
				T_Damage (head, inflictor, attacker, points);
			}
		}
		head = head.chain;
	}
};

void() bomb_think = 
{
	local float timer;
	local entity e;
	timer = time - self.wait;
	
	if(timer >= 35)
	{
		T_BombRadiusDamage (self, self.owner, 1000);
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_EXPLOSION);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
		
		setmodel (self, "models/explode.mdl");
		self.scale = 4;
		bombexplode1();
		for (e = findchain(classname, "player"); e; e = e.chain) 
		{
			centerprint(e, "USSR WON");
			self.owner.wait = time;
		}
	}

	if(timer >= 34)
	{
		self.color_x = 0;
		self.color_y = 1;
		self.color_z = 0;
	}
	if(self.lasttouch + (2-(0.057 * timer)) < time) //0.057 * 35 =2
	{
		if(timer < 34) sound (self, CHAN_BODY, "bomb/c4beep.wav", 1, ATTN_NORM);
		else if(timer > 35) sound (self, CHAN_BODY, "misc/null.wav", 1, ATTN_NORM);
		else sound (self, CHAN_BODY, "bomb/c4pizda.wav", 1, ATTN_NORM);
		self.lasttouch = time;
		self.light_lev = 200;
	}
	if(timer < 34)self.light_lev = self.light_lev * 0.9;
	self.nextthink = time + 0.1;
	
}

void() bomb_side_defuse_touch = 
{
	local float percent;
	local string temp;
	if(other.classname == "player" && other.team == TEAM_USA)
	{
		self.wait = time;
		if(other.buttonuse)
		{
			other.reload = 1;
			other.velocity = '0 0 0';
			
			percent = ((self.lasttouch) / 5) * 100;
			temp = ftos(percent);
			temp = substring(temp,0,strstrofs(temp, ".", 0));
			temp = strcat(temp, "%");
			centerprint(other, temp);
			
			if(self.lasttouch > 5)
			{
				sound (self, CHAN_BODY, "bomb/c4disarmed.wav", 1, ATTN_NONE);
				USA_Win();
			}
			if(self.lasttouch == 0) sound (self, CHAN_BODY, "bomb/c4disarm.wav", 1, ATTN_NORM);
			self.lasttouch = self.lasttouch + 0.01;
		}
		else 
		{
			centerprint(other, "Hold E to defuse the bomb");
			self.lasttouch = 0;
			other.reload = 0;
		}
	}
}

void() bomb_side_touch = 
{
	local entity bomb;
	local float percent;
	local string temp;
	if(other.classname == "player" && other.team == TEAM_USSR && other.items & IT_BOMB)
	{
		if(other.buttonuse)
		{
			other.reload = 1;
			other.velocity = '0 0 0';
			percent = ((self.lasttouch) / 3) * 100;
			temp = ftos(percent);
			temp = substring(temp,0,strstrofs(temp, ".", 0));
			temp = strcat(temp, "%");
			centerprint(other, temp);
			
			if(self.lasttouch == 0)
			{
				sound (self, CHAN_BODY, "bomb/c4on.wav", 1, ATTN_NORM);
			}
			if(self.lasttouch  > 2.3)
			{
				sound (self, CHAN_BODY, "bomb/c4click.wav", 1, ATTN_NORM);
			}
			if(self.lasttouch > 3)
			{
				sound (self, CHAN_VOICE, "bomb/c4armed.wav", 1, ATTN_NONE);
				bomb = spawn ();
				bomb.owner = self;
				bomb.solid = SOLID_TRIGGER;
				bomb.movetype = MOVETYPE_NONE;
				setmodel(bomb, "models/w_bomb.md3");
				bomb.classname = "bomb";
				bomb.pflags = PFLAGS_FULLDYNAMIC|PFLAGS_NOSHADOW;
				bomb.light_lev = 200;
				bomb.color = '1 0 0';
				setorigin (bomb, self.pos1);
				self.lasttouch = 0;
				bomb.wait = time;
				bomb.think = bomb_think;
				bomb.nextthink = time + 0.1;
				
				self.touch = bomb_side_defuse_touch;
				self.wait = time;
				if(self.classname == "bomb_sideB")
				{
					bomb = find(world, classname, "bomb_side");
					if(bomb)
					{
						bomb.touch = SUB_Null;
						bomb.wait = time;
					}
				}
				else 
				{
					bomb = find(world, classname, "bomb_sideB");
					if(bomb)
					{
						bomb.touch = SUB_Null;
						bomb.wait = time;
					}
				}
				for (bomb = findchain(classname, "player"); bomb; bomb = bomb.chain) 
				{
					centerprint(bomb, "Bomb has been planted");
				}
			}
			self.lasttouch = self.lasttouch + 0.01;
		}
		else 
		{
			centerprint(other, "Hold E to plant the bomb");
			self.lasttouch = 0;
			other.reload = 0;
		}
	}
}

void() bomb_side_think =
{
	local entity e;
	local float USSRPlayersAllive;
	local float USAPlayersAllive;
	local float Players;
	local float USSRPlayers;
	local float USAPlayers;
	
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		if(e.team == TEAM_USSR && e.deadflag == DEAD_NO) USSRPlayersAllive = USSRPlayersAllive + 1;
		else if(e.team == TEAM_USA && e.deadflag == DEAD_NO) USAPlayersAllive = USAPlayersAllive + 1;
		else if(e.team == TEAM_USA) USAPlayers = USAPlayers + 1;
		else if(e.team == TEAM_USSR) USSRPlayers = USSRPlayers + 1;
		Players = Players + 1;
	}
	
	if(USAPlayersAllive == 0 && USAPlayers > 0) 
	{
		if(Players > 1) USSR_Win();
	}
	if(USSRPlayersAllive == 0 && USSRPlayers > 0) 
	{
		if(Players > 1)
		{
			e = find(self, classname, "bomb");
			if(!e) USA_Win();
		}
	}
	if(USAPlayersAllive == 0 && USSRPlayersAllive == 0) 
	{
		//bprint("Round draw\n");
		e = find(self, classname, "bomb");
		if(!e) EndRound();
	}
	
	if(self.wait + 150 < time) USA_Win();
	
	self.nextthink = time+0.1;
}

void() bomb_side =
{
	if(deathmatch != MODE_DE) return;
	precache_model2("models/w_bomb.md3");
	precache_sound2("ussr/win1.wav");
	precache_sound2("ussr/win2.wav");
	precache_sound2("ussr/win3.wav");
	precache_sound2("usa/win1.wav");
	precache_sound2("usa/win2.wav");
	precache_sound2("bomb/c4armed.wav");
	precache_sound2("bomb/c4beep.wav");
	precache_sound2("bomb/c4click.wav");
	precache_sound2("bomb/c4on.wav");
	precache_sound2("bomb/c4pizda.wav");
	precache_sound2("bomb/c4explode.wav");
	precache_sound2("bomb/c4plant.wav");
	precache_sound2("bomb/c4disarm.wav");
	precache_sound2("bomb/c4disarmed.wav");
	precache_sound2("misc/null.wav");
	if (self.angles != '0 0 0') SetMovedir ();
	self.solid = SOLID_TRIGGER;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
	self.classname = "bomb_side";
	self.wait = time;

	self.think = bomb_side_think;
	self.touch = bomb_side_touch;
	self.nextthink = time + 0.1;
}

void() bomb_sideB =
{
	if(deathmatch != MODE_DE) return;
	if (self.angles != '0 0 0') SetMovedir ();
	self.solid = SOLID_TRIGGER;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
	self.classname = "bomb_sideB";
	self.wait = time;
	
	self.think = bomb_side_think;
	self.touch = bomb_side_touch;
	self.nextthink = time + 0.1;
}