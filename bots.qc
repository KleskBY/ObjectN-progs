string() RandomName 
{
	local float rand;
	local string name;
	rand = rint(random() * 32);	
	switch(rand)
	{
		case 1:
			name = "Klesk";
			break;
		case 2:
			name = "NiceL";
			break;
		case 3:
			name = "Snow";
			break;
		case 4:
			name = "Sown";
			break;
		case 5:
			name = "Volot";
			break;
		case 6:
			name = "Cringe";
			break;
		case 7:
			name = "PussyHunter42";
			break;
		case 8:
			name = "DarkLord";
			break;
		case 9:
			name = "Killer228";
			break;
		case 10:
			name = "Sige";
			break;
		case 11:
			name = "007";
			break;
		case 12:
			name = "Over";
			break;
		case 13:
			name = "8=====D";
			break;
		case 14:
			name = "LordHavoc";
			break;
		case 15:
			name = "LadyHavoc";
			break;
		case 16:
			name = "Vinylka";
			break;
		case 17:
			name = "Nya";
			break;
		case 18:
			name = "Noir";
			break;
		case 19:
			name = "Oxxxy";
			break;
		case 20:
			name = "BadBoy";
			break;
		case 21:
			name = "Crystal";
			break;
		case 22:
			name = "Prince";
			break;
		case 23:
			name = "CobraBuster";
			break;
		case 24:
			name = "ArmyBoots";
			break;
		case 25:
			name = "GasGun";
			break;
		case 26:
			name = "Yank";
			break;
		case 27:
			name = "Xaero";
			break;
		case 28:
			name = "Ranger";
			break;
		case 29:
			name = "Crash";
			break;
		case 30:
			name = "Orb";
			break;
		case 31:
			name = "Splash";
			break;
		case 32:
			name = "dumptruck";
			break;
			

		default:
			name = "Wall-E";
			break;
			
	}
	return name;
}

float() GetCurrentClip =
{
	local float clip;
	if(self.weapon == WP_ONE) clip = 0;
	else if(self.weapon == WP_GRENADE) clip = self.ammoGrenades;
	else if(self.weapon == WP_PISTOL) clip = self.pistolClip;
	else if(self.weapon == WP_SHOTGUN) clip = self.shotgunClip;
	else if(self.weapon == WP_RIFLE) clip = self.rifleClip;
	else if(self.weapon == WP_SNIPER) clip = self.sniperClip;
	else if(self.weapon == WP_HAMMER) clip = self.ammoBarricades;
	return clip;
}
vector(vector angle) NormalizeAngle =
{
	while (angle_x < -180) angle_x += 360;
	while (angle_x > 180) angle_x -= 360;

	while (angle_y < -180) angle_y += 360;
	while (angle_y > 180) angle_y -= 360;

	while (angle_z < -180) angle_z += 360;
	while (angle_z > 180) angle_z -= 360;

	return angle;
}
vector(vector angle) ClampAngle =
{
	while (angle_y > 180) angle_y -= 360;
	while (angle_y < -180) angle_y += 360;

	if (angle_x > 89.0) angle_x = 89.0;
	if (angle_x < -89.0) angle_x = -89.0;

	angle_z = 0;

	return angle;
}

void() PickClass =
{
	local float rand;
	rand = rint(random() * 7);	
	if(rand == 1 || rand == 2) self.impulse = 20;
	else if(rand == 3) self.impulse = 21;
	else if(rand == 4) self.impulse = 22;
	else if(rand == 5) self.impulse = 26;
	else if(rand == 6) self.impulse = 27;
	else if(rand == 7) self.impulse = 28;
	self.lastTouch = time;
}

void() SpawnBot =
{	
	local entity oldself;
	oldself = self;
	self = spawnclient();
	if (!self)
	{
		bprint("Can not add bot, server is full.\n");
		self = oldself;
		return;
	}
	self.netname = RandomName();
	ClientConnect();
	PutClientInServer();
	PickClass();

	self = oldself;
}
void() KickBot =
{
	self.impulse = 0;
	if(!deathmatch) return;
	local entity head;
	head = find(world, classname, "player");
	while (head)
	{
		if (clienttype(head) == CLIENTTYPE_BOT) dropclient(head);
		head = find(head, classname, "player");
	}
	head = find(world, classname, "observer");
	while (head)
	{
		if (clienttype(head) == CLIENTTYPE_BOT) dropclient(head);
		head = find(head, classname, "observer");
	}
}
void() BotPreThink =
{
	if (intermission_running) return;	
	if(self.classname == "observer" && self.lastTouch + 1 < time) PickClass();
	SelectClass();
	
	makevectors (self.v_angle);		// is this still used
	CheckRules ();
	WaterMove ();
	
	if (self.waterlevel == 2) CheckWaterJump ();
	if (self.deadflag >= DEAD_DEAD)
	{
		PlayerDeathThink ();
		return;
	}
	if (self.deadflag == DEAD_DYING) return;
	if (self.flags & FL_ONGROUND) self.flags = self.flags - (self.flags & FL_LADDERJUMP);
	if (time < self.pausetime) self.velocity = '0 0 0';
	if(time > self.attack_finished && self.currentammo == 0 && self.weapon != IT_KNIFE)
	{
		if(self.weapon == WP_RIFLE && self.rifleClip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_SHOTGUN && self.shotgunClip < 1) CycleWeaponReverseCommand();
		if(self.weapon == WP_PISTOL && self.pistolClip < 1) CycleWeaponReverseCommand();
	}
	
	local entity e, nearest;
	for (e = findchain(classname, "player"); e; e = e.chain) 
	{
		if(e != self && e.deadflag != DEAD_DEAD && e.deadflag != DEAD_DYING)
		{
			if (!nearest || !visible(nearest)) nearest = e;
			if(visible(e))
			{
				if (!nearest) nearest = e;
				else if(vlen(e.origin - self.origin) < vlen(nearest.origin - self.origin)) nearest = e;
			}
			else if (!nearest) nearest = e;
		}
	}
	local float clip;
	clip = GetCurrentClip();
	
	//if(!nearest || !visible(nearest))
	{
		local entity Waypoint;
		if(clip < 7) self.impulse = 100;
		for (e = findchain(classname, "waypoint"); e; e = e.chain) 
		{
			if(e != Waypoint && e.origin != self.lastcheckpoint && e.origin != self.pos1 && e.origin != self.pos2 && e.origin != self.pos3 && e.origin != self.pos4 && e.origin != self.pos5 && visible(e))
			{
				if(vlen(e.origin - self.origin) < vlen(Waypoint.origin - self.origin)) 
				{
					Waypoint = e;
				}
			}
		}
		
		// bprint(ftos(Waypoint.origin_x));
		// bprint(" ");
		// bprint(ftos(vlen(Waypoint.origin - self.origin)));
		// bprint("\n");
		
		if( (nearest && visible(nearest)) || !Waypoint) 
		{
			local vector newAngle, dir, dir2;
		
			if(!clip && !self.ammoRifle) self.impulse = 2;
			
			dir = normalize((nearest.origin + nearest.view_ofs * 0.5) - (self.origin + self.view_ofs *0.5));
			dir_z = 0;
			newAngle = vectoangles(dir);
			
			dir2 = normalize((self.origin + self.view_ofs *0.5) - (nearest.origin + nearest.view_ofs * 0.5));
			newAngle = vectoangles(dir2);
			newAngle_y = newAngle_y + 180;
			newAngle = NormalizeAngle(newAngle);
			newAngle = ClampAngle(newAngle);
			
			local float diff;
			diff = fabs(newAngle_y - self.v_angle_y);
			// bprint(ftos(diff));
			// bprint("\n");
			
			newAngle = newAngle - self.v_angle;
			
			self.v_angle_x =  self.v_angle_x + (newAngle_x / 20);
			self.v_angle_y = self.v_angle_y + (newAngle_y / 20);
			
			if(clip > 0 && diff < 30 /*infront(nearest)*/ && visible(nearest)) 
			{
				makevectors(self.v_angle);
				self.velocity = (v_right * 250);
				if (time > self.attack_finished) W_Attack ();
			}
			else 
			{
				if(clip < 7) self.impulse = 100;
				self.velocity = dir * 250;
			}
			self.velocity_z = -150;
		}
		else
		{
			//self.v_angle_y = ((vectoyaw(Waypoint.origin - self.origin) - self.v_angle_y) / 25) + self.v_angle_y;
			self.v_angle_x = self.v_angle_x / 1.2;
			self.v_angle_y = vectoyaw(Waypoint.origin - self.origin);
			self.velocity = v_forward * 240;
			self.velocity_z = -150;
			if(vlen(Waypoint.origin - self.origin) < 30)
			{
				self.pos5 = self.pos4;
				self.pos4 = self.pos3;
				self.pos3 = self.pos2;
				self.pos2 = self.pos1;
				self.pos1 = self.lastcheckpoint;
				self.lastcheckpoint = Waypoint.origin;
			}
		}
	}
	

}