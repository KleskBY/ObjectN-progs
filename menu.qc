void() SetNewParmsStormtrooper;
void() SetNewParmsBreacher;
void() SetNewParmsMarksman;
void() SetNewParmsEngineer;
void() SetNewParmsAssassin;

void() SelectTeamUSSR =
{
	T_Damage (self, self, self, 100);
	bprint (self.netname); 						
	bprint (" joined USSR team\n"); 			
	self.skin = 0; 			     				
	setsize (self, '-16 -16 -24', '16 16 32'); 	
	self.menu = MENU_OFF;  						
	centerprint (self, "");               		
	setcolor(self, 0);
}
void() SelectTeamUSA =
{
	T_Damage (self, self, self, 100);
	bprint (self.netname);
	bprint (" joined USA team\n");
	self.skin = 0;
	setsize (self, '-16 -16 -24', '16 16 32');
	self.menu = MENU_OFF;
	centerprint (self, "");
	setcolor(self, 1);
}

void() SelectClass
{
	if(deathmatch)
	{
		if (self.impulse == 20) 
		{
			self.team = TEAM_USSR;
			self.class = CLASS_SHTORMTROOPER;
			SetNewParmsStormtrooper();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 21)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_BREACHER;
			SetNewParmsBreacher();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 22)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_MARKSMAN;
			SetNewParmsMarksman();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if(self.impulse == 23)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_ENGINEER;
			SetNewParmsEngineer();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if(self.impulse == 24)
		{
			self.team = TEAM_USSR;
			self.class = CLASS_ASSASSIN;
			SetNewParmsAssassin();
			SelectTeamUSSR();
			self.impulse = 0;
		}
		else if (self.impulse == 25) 
		{
			self.team = TEAM_USA;
			self.class = CLASS_SHTORMTROOPER;
			SetNewParmsStormtrooper();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if (self.impulse == 26)
		{
			self.team = TEAM_USA;
			self.class = CLASS_BREACHER;
			SetNewParmsBreacher();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if (self.impulse == 27)
		{
			self.team = TEAM_USA;
			self.class = CLASS_MARKSMAN;
			SetNewParmsMarksman();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if(self.impulse == 28)
		{
			self.team = TEAM_USA;
			self.class = CLASS_ENGINEER;
			SetNewParmsEngineer();
			SelectTeamUSA();
			self.impulse = 0;
		}
		else if(self.impulse == 29)
		{
			self.team = TEAM_USA;
			self.class = CLASS_ASSASSIN;
			SetNewParmsAssassin();
			SelectTeamUSA();
			self.impulse = 0;
		}
	}
}

void(float pcolor) SV_ChangeTeam =
{
	if(deathmatch) T_Damage(self, world, world, 100);
}