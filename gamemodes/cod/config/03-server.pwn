/* ** Includes ** */
#include <..\..\..\dependencies\YSI-Includes\YSI_Coding\y_hooks>

#define GAMEMODE_VERSION 		"v0.1"
#define LANGUAGE 				"English"
#define SERVER_NAME 			"Test Server"
#define SERVER_MODE 			"Modular CoD-TDM"
#define SERVER_SITE 			"example.com"
#define SERVER_MAP				"LV & SF"


#define SECONDS_TO_LOGIN	 	60
#define MAX_FAIL_LOGINS 		3
#define BCRYPT_COST				12

#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#define MAX_PLAYERS 100

hook OnScriptInit()
{
	new srv_mode[32] = SERVER_MODE;
	strcat(srv_mode, GAMEMODE_VERSION,sizeof(srv_mode));
	SetGameModeText(srv_mode);
/*
    SetServerRule("hostname", SERVER_NAME);
	SetServerRule("mapname", SERVER_MAP);
	SetServerRule("language", LANGUAGE);
*/
	/* ** Basic Rules ** */
	UsePlayerPedAnims();
	AllowInteriorWeapons(0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	return 1;
}
//Used in config/03-player.pwn
#define	 		DIALOG_REGISTER			9999 
#define 		DIALOG_LOGIN			9998
#define			DIALOG_UNUSED			0