/*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*Contains  player things*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*/

enum pData{
    //General
    User_ID,
	Playername[MAX_PLAYER_NAME],
	Password[129],
	Salt[65],
	IP[16],
	FailedLogins,

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
	Admin,
	VIP,

    //Deathmatch
    DM_Active
    DM_Kills
    DM_Deaths
    DM_Headshots
    DM_KDR

    //Punishments
    bool:Muted,
	MuteTime,
	Warns,
	bool:Frozen,
	FrozenTime,
}
new pInfo[playerid][pData]