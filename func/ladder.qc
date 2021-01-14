void() ladder_sound =
{
	//if(!other.button4)
	{
		if(time+random(0,0.2) >other.footstep_finished || other.footstep_finished == 0) 
		{
			local float r;
			r=random();
			if (r <=0.25) sound(other, CHAN_BODY, "player/ladder1.wav", 0.2, ATTN_NORM);
			else if (r <=0.5 && r>0.25) sound(other, CHAN_BODY, "player/ladder2.wav", 0.2, ATTN_NORM);
			else if (r <=0.75 && r>0.5) sound(other, CHAN_BODY, "player/ladder3.wav", 0.2, ATTN_NORM);
			else sound(other, CHAN_BODY, "player/ladder4.wav", 0.2, ATTN_NORM);
			other.footstep_finished = time +0.5;
		}
	}
}
float sv_accelerate;
float sv_friction;
float sv_maxspeed;

void() ladder_touch =
{
	local vector wishvel, wishdir;
	local float wishspeed, f;
	if (other.classname != "player") return;
	sv_maxspeed = cvar("sv_maxspeed");
	sv_friction = cvar("sv_friction");
	sv_accelerate = cvar("sv_accelerate");
	
	if(vlen(other.velocity) > 200) ladder_sound();
	
	if(!(other.flags & FL_LADDERJUMP) && !(other.flags & FL_JUMPRELEASED))
	{
		other.flags = other.flags | FL_LADDERJUMP;
	}
	else if((other.flags & FL_LADDERJUMP) && (other.flags & FL_JUMPRELEASED))
	{
		other.flags = other.flags - (other.flags & FL_LADDERJUMP);
	}
	
	if(other.lastTouch > time) return;
	if(other.button2 && !(other.flags & FL_LADDERJUMP) && !(other.flags & FL_ONGROUND)) 
	{ 
		makevectors(self.angles);
		other.velocity = other.velocity + (v_forward * 200);
		other.velocity_z = other.velocity_z + 100;
		other.lastTouch = time + 0.2;
		return;
	}

	
	other.velocity = other.velocity * (1 - frametime * sv_friction);
	makevectors(other.v_angle);
	wishvel = v_forward * other.movement_x + v_right * other.movement_y + '0 0 1' * other.movement_z;
	
	// acceleration
	wishdir = normalize(wishvel);
	wishspeed = vlen(wishvel);
	if (wishspeed > sv_maxspeed) wishspeed = sv_maxspeed;
	if(other.button3 || other.button4) wishspeed = wishspeed *0.7;
	if (time >= other.teleport_time)
	{
		f = wishspeed - (other.velocity * wishdir);
		if (f > 0)
		{
			other.velocity = other.velocity + wishdir * min(f, sv_accelerate * frametime * wishspeed);

		}
	}
	//if(other.angles_x > 0.5) 
	other.velocity_z  = other.velocity_z + 5.71;
	other.velocity_x = other.velocity_x * 0.7;
	other.velocity_y = other.velocity_y * 0.7;
		//if (self.owner.attack_finished > time) return;
	//self.owner.attack_finished = time + 2;

	// if (self.owner.message != "")
	// {
		// centerprint (other, self.owner.message);
		// sound (other, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	// }
	//other.velocity = '0 0 300';
	
	// if(other.button2)
	// {
		// other.velocity = '0 0 0';
		// other.origin_z = other.origin_z+2;
		// setorigin (other, other.origin);
		// ladder_sound();
	// }	
	// else if(other.button3 || other.button4)
	// {
		// other.velocity = '0 0 0';
		// other.origin_z = other.origin_z-2;
		// setorigin (other, other.origin);
		// ladder_sound();
	// }	
	// else
	// {
		// other.velocity = '0 0 0';
		// other.origin_z = other.origin_z+0.076;
		// setorigin (other, other.origin);
	// }
	// other.lastTouch = time+0.3;
	
};


void() func_ladder =
{
	self.solid = SOLID_TRIGGER;
	setorigin (self, self.origin);	
	setmodel (self, self.model);
	self.classname = "ladder";
	
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);
		
	self.touch = ladder_touch;
};