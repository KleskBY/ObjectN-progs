//float	modelindex_player, modelindex_eyes; //Stores your player model
float	modelindex_ussr_knife, modelindex_ussr_aps, modelindex_ussr_toz, modelindex_ussr_ak74,modelindex_ussr_mosin;

void ()SetNewParmsStormtrooper;
void ()SetNewParmsBreacher;
void ()SetNewParmsMarksman;

void ()SelectTeamUSSR =
{
	T_Damage (self, self, self, 100);
	bprint (self.netname); //Shows your name to everybody
	bprint (" joined USSR team\n"); //And a nice little text to show what team you're joining
	self.skin = 0; 			     //Default skin
	modelindex_ussr_aps = self.modelindex; //This is a special trick I'll explain below
	setsize (self, '-16 -16 -24', '16 16 32'); //Sets size to standard player size, putclientinserver does this too but it doesn't hurt
	self.menu = MENU_OFF;  			//turn the menu off
	centerprint (self, "");               //Remove the menu
	setcolor(self, 0);
}
void ()SelectTeamUSA =
{
	T_Damage (self, self, self, 100);
	bprint (self.netname);
	bprint (" joined USA team\n");
	self.skin = 0;
	modelindex_ussr_aps = self.modelindex;
	setsize (self, '-16 -16 -24', '16 16 32');
	self.menu = MENU_OFF;
	centerprint (self, "");
	setcolor(self, 1);
}

void(float pcolor) SV_ChangeTeam =
{
	T_Damage(self, world, world, 200);
	//stuffcmd (self, "kill\n");
}