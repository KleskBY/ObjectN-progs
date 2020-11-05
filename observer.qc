
//Observer mode, you start out as this if you don't have a team
//Basically modified PutClientInServer to be more like an observer mode

void() PutObserverInServer =		//Koolio, Just like PutClientInServer
{
	if (self.team != NO_TEAM && self.class != NO_TEAM) // if you already have a team 
	{ 
		PutClientInServer(); // And run the normal PutClientInServer
		centerprint (self, "You have a team");
		return; // and forget the rest 
	}
	//bprint("shit\n");
	local	entity spot;

	spot = SelectSpawnPoint ();

	self.classname = "observer";
	self.health = 666;				//Heh, just for fun
	self.takedamage = DAMAGE_NO;  	//You can't take damage
	self.solid = SOLID_NOT;       	//You're not solid (so you can't (be) telefrag(ged)
	self.movetype = MOVETYPE_NOCLIP;//You can move just like in noclipping mode
	self.show_hostile = 0;			//The rest is pretty much the same as in PutClientInServer
	self.max_health = 666;
	self.flags = FL_CLIENT;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
	self.invincible_time = 0;

	self.items = self.items - (IT_KNIFE | IT_PM | IT_TOZ | IT_AKM | IT_GRENADE | IT_KEY1 | IT_KEY2); // take all of their stuff
	self.weapons = 0;
	self.weapon = 0;
	self.currentammo =  0;
	self.weaponmodel = "";

	W_SetCurrentAmmo ();

	self.attack_finished = time;	
	self.deadflag = DEAD_NO;
	// pausetime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = TRUE;		// turn this way immediately

	// oh, this is no longer a hack!  =)
	//setmodel (self, "progs/eyes.mdl");
	//modelindex_eyes = self.modelindex;

	setcolor(self, 255);
	setmodel (self, ""); //We're going to replace this soon
	modelindex_ussr_aps = self.modelindex;

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	self.view_ofs = '0 0 22';

	player_stand1 ();
	
	if (deathmatch || coop)
	{
		makevectors(self.angles);
		spawn_tfog (self.origin + v_forward*20); //You can uncomment this if you want the normal fog to apear
	}

	spawn_tdeath (self.origin, self);
};