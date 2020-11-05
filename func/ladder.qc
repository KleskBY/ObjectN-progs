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

void() ladder_touch =
{
	if (other.classname != "player") return;
	//if (self.owner.attack_finished > time) return;
	//self.owner.attack_finished = time + 2;

	// if (self.owner.message != "")
	// {
		// centerprint (other, self.owner.message);
		// sound (other, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	// }
	//other.velocity = '0 0 300';
	if(other.button2)
	{
		other.velocity = '0 0 0';
		other.origin_z = other.origin_z+2;
		setorigin (other, other.origin);
		ladder_sound();
	}	
	else if(other.button3 || other.button4)
	{
		other.velocity = '0 0 0';
		other.origin_z = other.origin_z-2;
		setorigin (other, other.origin);
		ladder_sound();
	}	
	else
	{
		other.velocity = '0 0 0';
		other.origin_z = other.origin_z+0.076;
		setorigin (other, other.origin);
	}
	other.lasttouch = time+0.3;
	//other.movetype = MOVETYPE_FLY;
	
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