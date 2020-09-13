/*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*Contains  player things*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*/

enum pData{
    //General
    User_ID,
	Playername[MAX_PLAYER_NAME],
	Password[61],
	IP[16],
	FailedLogins,
	LoginTimer,
	Cache: Cache_ID,
	bool: IsLoggedIn,

    //Game Data
    Team,
	Score,
	Rank,
	Class,
	Money,
	Kills,
	Deaths,
	KDR,
	Headshots,
	Captures,
	Admin,
	VIP,
	Fightstyle,

    //Deathmatch
    DM_Active,
    DM_Kills,
    DM_Deaths,
    DM_Headshots,
    DM_KDR,

    //Punishments
    bool:Muted,
	MuteTime,
	Warns,
	bool:Frozen,
	FrozenTime,
}
new pInfo[MAX_PLAYERS][pData];

new g_disconnect_check[MAX_PLAYERS];

hook OnPlayerConnect(playerid){
	g_disconnect_check[playerid]++;

	static const empty_player[pData];
	pInfo[playerid] = empty_player;
	GetPlayerName(playerid, pInfo[playerid][Playername], MAX_PLAYER_NAME);
	GetPlayerIp(playerid, pInfo[playerid][IP], 16);
	PlayerBanCheck(playerid);
	new query[256];
	mysql_format(dbHandle, query, sizeof(query), "SELECT * FROM `USERS` WHERE `NAME` EQUALS '%e' LIMIT 1", pInfo[playerid][Playername]);
	mysql_tquery(dbHandle, query, "OnPlayerDataLoaded", "dd", playerid, g_disconnect_check[playerid]);
	
}

hook OnPlayerDisconnect(playerid, reason){
	g_disconnect_check[playerid]++;

	if(cache_is_valid(pInfo[playerid][Cache_ID]))
	{
		cache_delete(pInfo[playerid][Cache_ID]);
		pInfo[playerid][Cache_ID] = MYSQL_INVALID_CACHE;
	}
	if(pInfo[playerid][LoginTimer])
	{
		KillTimer(pInfo[playerid][LoginTimer]);
		pInfo[playerid][LoginTimer] = 0;
	}
	pInfo[playerid][IsLoggedIn] = false;
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
	switch(dialogid){
		case DIALOG_LOGIN:
		{
			if (!response) return Kick(playerid);
			if(pInfo[playerid][FailedLogins] >= MAX_FAIL_LOGINS)
			{
				SendClientMessage(playerid, COLOR_RED, "You've exceeded the maximum amount of failed logins.");
				SetTimerEx("DelayedKick", 3000, false, "i", playerid);
			}
			bcrypt_check(inputtext, pInfo[playerid][Password], "OnPasswordChecked", "d", playerid);
			return 1;
		}
		case DIALOG_REGISTER:
		{
			if(!response) return Kick(playerid);
			if(!(5<strlen(inputtext) <= 60)){
				SendClientMessage(playerid, COLOR_RED, "[ERROR]: Your password was too short, please choose a password between 5 and 60 characters.");
				new string[128];
				format(string, sizeof(string), "Welcome to the server %s!\n\r Please register by entering a Password in the following dialog", pInfo[playerid][Playername]);
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", string, "Register", "Abort");
			}
			else{
				bcrypt_hash(inputtext, BCRYPT_COST, "OnPasswordHashed", "d", playerid);
			}
			return 1;
		}
		case DIALOG_UNUSED:
			return 1;
	}
	return 1;
}

stock PlayerBanCheck(playerid){
	new query[128];
	mysql_format(dbHandle, query, sizeof(query), "SELECT * FROM `BANS` WHERE `IP` EQUALS '%e' OR `USER_NAME` EQUALS '%e'", pInfo[playerid][IP], pInfo[playerid][Playername]);
	mysql_tquery(dbHandle, query);
	if(cache_num_rows() > 0){

	}
	return 1;
}
forward OnPlayerDataLoaded(playerid, disconnect_check);
public OnPlayerDataLoaded(playerid,disconnect_check){
	if(disconnect_check != g_disconnect_check[playerid]) return Kick(playerid);
	new string[128];
	if(cache_num_rows() > 0){ // User exists
		cache_get_value(0, "password", pInfo[playerid][Password],61);
		pInfo[playerid][Cache_ID] = cache_save();

		format(string, sizeof(string), "%s is a registered Account.\n\r Please login by entering your password below in order to continue", pInfo[playerid][Playername]);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Abort");

	}
	else{ // User is new to the server
		format(string, sizeof(string), "Welcome to the server %s!\n\r Please register by entering a Password in the following dialog", pInfo[playerid][Playername]);
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", string, "Register", "Abort");
	}
	return 1;
}
forward OnPasswordHashed(playerid);
public OnPasswordHashed(playerid){
	bcrypt_get_hash(pInfo[playerid][Password]);
	new query[256];
	mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `USERS` (NAME, PASSWORD, LAST_IP) VALUES ('%e', '%s', '%s')", pInfo[playerid][Playername],pInfo[playerid][Password],pInfo[playerid][IP]);
	mysql_tquery(dbHandle, query);
	pInfo[playerid][IsLoggedIn] = true;
	return 1;
}
forward OnPasswordChecked(playerid);
public OnPasswordChecked(playerid){
	new bool:match = bcrypt_is_equal();
	new string[128];
	if(!match){
		format(string, sizeof(string), "[ERROR]: Incorrect Password, please re-try. (%d/%d)", pInfo[playerid][FailedLogins], MAX_FAIL_LOGINS);
		SendClientMessage(playerid, COLOR_RED, string);
		format(string, sizeof(string), "%s is a registered Account.\n\r Please login by entering your password below in order to continue", pInfo[playerid][Playername]);
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Abort");
	}
	format(string, sizeof(string), "Successfully Logged in as %s.", pInfo[playerid][Playername]);
	SendClientMessage(playerid, COLOR_GREEN, string);
	pInfo[playerid][IsLoggedIn] = true;
	AssignPData(playerid);
	return 1;
}
stock AssignPData(playerid){
	cache_get_value_int(0, "id", pInfo[playerid][User_ID]);
	cache_get_value_int(0, "score", pInfo[playerid][Score]);
	cache_get_value_int(0, "rank", pInfo[playerid][Rank]);
	cache_get_value_int(0, "cash", pInfo[playerid][Money]);
	cache_get_value_int(0, "kills", pInfo[playerid][Kills]);
	cache_get_value_int(0, "deaths", pInfo[playerid][Deaths]);
	cache_get_value_int(0, "headshots", pInfo[playerid][Headshots]);
	cache_get_value_int(0, "fightstyle", pInfo[playerid][Fightstyle]);
	cache_get_value_int(0, "captures", pInfo[playerid][Captures]);
	cache_get_value_int(0, "admin_level", pInfo[playerid][Admin]);
	cache_get_value_int(0, "VIP_Level", pInfo[playerid][VIP]);
	cache_get_value_int(0, "dm_kills", pInfo[playerid][DM_Kills]);
	cache_get_value_int(0, "dm_deaths", pInfo[playerid][DM_Deaths]);
	cache_get_value_int(0, "mute_time", pInfo[playerid][MuteTime]);
	cache_get_value_int(0, "frozen_time", pInfo[playerid][FrozenTime]);
	SetPlayerMoney(playerid, pInfo[playerid][Money]);
}


                                                 