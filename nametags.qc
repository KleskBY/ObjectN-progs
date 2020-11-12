void() Sight_Touch =
{
	
	//centerprint(self.owner, other.netname);
	if (other.classname != "player") return;
	if (other == self.owner) return;
	centerprint(self.owner, other.netname);
}

void() Sight_Think =
{
	if(self.owner.health < 0) remove(self);
	local vector src;
	makevectors (self.owner.v_angle);
	src = (self.owner.origin + (v_forward * TE_LAVASPLASH));
	src_z = (self.owner.absmin_z + (self.owner.size_z * 0.800));
	src_y = (self.owner.absmin_y + (self.owner.size_y * 0.500));
	traceline (src,(src + (v_forward * 2048)),FALSE,self.owner);

	//self.lrange = vlen(self.owner.origin - trace_endpos);
	self.origin = (trace_endpos - (v_forward*10) );
	
	self.nextthink = time;
	self.think = Sight_Think;
};

void () DrawLaser =
{
	
	local entity sight;
    sight = spawn ();
	sight.owner = self;
    sight.movetype = MOVETYPE_NOCLIP;
	sight.solid = SOLID_TRIGGER;
	setmodel (sight, "");
	sight.classname = "laser_sight";
	sight.touch = Sight_Touch;
    sight.think = Sight_Think;
    sight.nextthink = time;
};