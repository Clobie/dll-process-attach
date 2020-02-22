var ingame = false;

while(ingame == false)
{
	if(GetClientState() == 2)
	{
		ingame = true;
	}
	
	SetTitle(GetOOGLocation());
	
	switch(GetOOGLocation())
	{
		case 18: // Splash Screen
			ClickScreen(0, 10, 10);
			Sleep(1000);
			break;
		case 8: // Main Menu
			ClickScreen(0, 295, 315);
			Sleep(1000);
			break;
		case 12: // Char Select
			SelectChar("test_char");
			Sleep(1000);
			break;
		default:
			//MsgBox(GetOOGLocation(), "OOG Location Unknown");
			//Sleep(1000);
			break;
	}
}