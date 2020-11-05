void() flash_update =
{
	// local vector vec;
	// local vector org;
	// makevectors(self.owner.v_angle);
    // v_forward = normalize (v_forward) * 32;
	// self.origin = self.owner.origin + v_forward;
	// setorigin (self, self.origin);
	// vec = aim (self.owner, 10000);
	// vec = normalize (vec);
	// self.angles = vectoangles (vec);
	
	makevectors(self.owner.v_angle);
	traceline(self.owner.origin , (self.owner.origin+(v_forward * 6)), FALSE , self);
	setorigin (self, trace_endpos + '0 0 10' /*+ (v_forward * - 6)*/); //4
	self.angles_x = -(((self.owner.angles_x) * -3) - 180);
	self.angles_y = self.owner.angles_y - 3 ;
	self.angles_z = self.owner.angles_z;
	self.pflags = PFLAGS_FULLDYNAMIC|PFLAGS_NOSHADOW;
	self.light_lev = 250 - random(-6,6);
	self.skin = 237;
	
	if(self.classname == "observer") self.think = SUB_Remove;
	self.nextthink = time + 0.02;
};

void() flash_on =
{
	local entity myflash;
	
	if(self.classname != "observer")
	{
		myflash = spawn ();
		myflash.movetype = MOVETYPE_NONE;
		myflash.solid = SOLID_NOT;
		setmodel (myflash, ""); 
		setsize (myflash, '0 0 0', '0 0 0');
		myflash.pflags = PFLAGS_FULLDYNAMIC;
		myflash.light_lev = 350;
		//myflash.scale = 200;
		myflash.color = '1 1 1.5';
		myflash.skin = 237; 
		myflash.owner = self;
		myflash.classname = "flash";
		
		// Set Start Position
		makevectors (self.v_angle);
		traceline (self.origin , (self.origin+(v_forward * 6) +(v_up*20)) , FALSE , self);
		setorigin (myflash, trace_endpos);
		self.angles = self.owner.angles;

		// Start Flashlight Update
		myflash.think = flash_update;
		myflash.nextthink = time + 0.02;
	}
};


void () flash_toggle =
{
	if (self.flash_flag == FALSE)
	{       
		self.flash_flag = TRUE;
		flash_on();
	}
	else
	{
		local entity flash;
		flash = find(self, classname, "flash");
		if (flash)
		{
			if (flash.owner == self)
			{
			   self.flash_flag = FALSE;
			   remove(flash);
			   return;
			}
		}
	}
};