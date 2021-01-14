float SVC_SHOWLMP = 35;
float SVC_HIDELMP = 36;

void(string indexname,string picname,float x,float y) ShowLmp=
{
	msg_entity = self;
	WriteByte (MSG_ONE, SVC_SHOWLMP);
	WriteString(MSG_ONE,indexname);
	WriteString(MSG_ONE,picname);
	WriteShort(MSG_ONE,x);
	WriteShort(MSG_ONE,y);
}
 
void(string indexname)HideLmp=
{
	msg_entity = self;
	WriteByte (MSG_ONE, SVC_HIDELMP);
	WriteString(MSG_ONE,indexname);
}