/*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*Contains Level 5 Admin commands*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*/

#include <YSI_Coding\y_hooks>

CMD:setlevel(playerid, params[])
{
    if(pInfo[playerid][Admin] >=5 || IsPlayerAdmin(playerid)){
        if(sscanf(params, "ui", targetplayer, level)) return SendClientMessage(playerid, COLOR_RED, "SYNTAX: /setlevel [target] [level]")
        else{
            pInfo[targetplayer][Admin] = level;
        }
        return 1;
    }
    else return 0;
}
CMD:saveall(playerid, params[])
{
    #pragma unused params
    if(pInfo[playerid][Admin])>=5 || IsPlayerAdmin(playerid){
        SaveAllPlayers();
    }
    else return 0;
}