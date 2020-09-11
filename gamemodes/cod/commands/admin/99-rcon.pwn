CMD:makemeadmin(playerid, params[]){
    #pragma unused params
    if(IsPlayerAdmin(playerid))
    {
        pInfo[playerid][Admin] = 5;
        return 1;
    }
    else return 0;
}