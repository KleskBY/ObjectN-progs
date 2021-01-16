
//Observer mode, you start out as this if you don't have a team
//Basically modified PutClientInServer to be more like an observer mode

void() PutObserverInServer =
{
	if (self.team != NO_TEAM && self.class != NO_TEAM) // if you already have a team 
	{ 
		PutClientInServer();
		return;
	}
	//bprint("shit\n");
	local entity spot;

	spot = SelectSpawnPoint ();

	self.classname = "observer";
	self.health = 666;			
	self.takedamage = DAMAGE_NO;  
	self.solid = SOLID_NOT;       	
	self.movetype = MOVETYPE_NOCLIP;
	self.show_hostile = 0;			
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
	self.pausetime = 0; 	// pausetime is set by teleporters to keep the player from moving a while
	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = TRUE;		// turn this way immediately

	setcolor(self, 255);
	setmodel (self, ""); 

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	self.view_ofs = '0 0 23';

	player_stand1 ();
	
	// if (deathmatch || coop)
	// {
		// makevectors(self.angles);
		// spawn_tfog (self.origin + v_forward*20); //You can uncomment this if you want the normal fog to apear
	// }

	//spawn_tdeath (self.origin, self);
	if(!coop) centerprint(self, "PRESS M TO SELECT TEAM");
};