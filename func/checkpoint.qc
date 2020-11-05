void() checkpoint_touch =
{
	if (other.classname != "player") return;
	if (self.message == "start!")
	{
		other.wait = time;
	}
	if (other.lastcheckpoint == self.pos1) return;
	if (self.message == "finish!")
	{
		bprint (other.netname);
		bprint (" finished level in ");
		bprint (ftos(time - other.wait));
		bprint (" seconds!\n");
	}
	other.lastcheckpoint = self.pos1;
	centerprint (other, self.message);
	sound (other, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM);
};

void() checkpoint =
{
	if (self.angles != '0 0 0') SetMovedir ();
	self.classname = "checkpoint";
	self.solid = SOLID_TRIGGER;
	setmodel (self, self.model);
	self.alpha = 0.6;
	self.movetype = MOVETYPE_NONE;
	self.touch = checkpoint_touch;
}