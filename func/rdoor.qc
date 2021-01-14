void() func_rdoor_think =
{
	// bprint(ftos(self.absmin_x));
	// bprint(" ");
	// bprint(ftos(self.absmin_y));
	// bprint(" ");
	// bprint(ftos(self.absmin_z));
	// bprint("\n");
	
	// bprint(ftos(self.absmax_x));
	// bprint(" ");
	// bprint(ftos(self.absmax_y));
	// bprint(" ");
	// bprint(ftos(self.absmax_z));
	// bprint("\n");
	self.angles_y = self.angles_y + 1;
	if(self.angles_y > 60) 
	{
		self.angles_y = 0;
		//setorigin (self, self.origin);
	}
	//setorigin (self, self.origin + '-3 -3 0');
	self.nextthink = time + 0.1;
	self.think = func_rdoor_think;
	
}
void() func_rdoor =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_FLY;
	self.solid = SOLID_BSP;
	setmodel (self, self.model);
	//setorigin (self, self.origin);
	//self.pos1 = self.absmin;
	
	self.think = func_rdoor_think;
	self.use =func_rdoor_think;
	self.nextthink = time + 0.1;
}