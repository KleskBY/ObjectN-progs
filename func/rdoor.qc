void() func_rdoor =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_FLY;	// so it doesn't get pushed by anything
	self.solid = SOLID_BSP;
	self.use = func_wall_use;
	setmodel (self, self.model);
	

	
	//self.angles_y = 20; 
	
	self.origin_x = 8;
	self.origin_y = -248;
	self.origin_z = 24;
	self.avelocity_y =100;
};
