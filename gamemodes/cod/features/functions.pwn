forward LogAdminAction(playerid, toplayerid, action, action_id);
public LogAdminAction(playerid, toplayerid, action, action_id){
    new query[256];
    mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `ADMIN_LOG` (`ISSUER`, `ADMIN_LEVEL`, `ACTION`, `ACTION_ID`, `TARGET`) VALUES ('%e', '%d', '%e', '%d', '%e') LIMIT 1", pInfo[playerid][User_ID], pInfo[playerid][Admin], action, action_id, pInfo[toplayerid][User_ID]);
    mysql_tquery(dbHandle, query);
}
forward LogNameChange(playerid, toplayerid, old_name, new_name);
public LogNameChange(playerid, toplayerid, old_name, new_name){
    new query[256];
    mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `NAME_CHANGES` (`USER_ID`, `ADMIN_NAME`, `FROM_NAME`, `TO_NAME`) VALUES ('%d', '%e', '%e', '%e')", pInfo[toplayerid][User_ID], pInfo[playerid][User_ID], old_name, new_name);
    mysql_tquery(dbHandle, query);
}
forward LogTransaction(playerid, toplayerid, amount, nature);
public LogTransaction(playerid, toplayerid, amount, nature){
    new query[128];
    mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `TRANSACTIONS` (`TO_ID`, `FROM_ID`, `CASH`, `NATURE`) VALUES ('%d', '%d', '%d' '%e'", pInfo[toplayerid][User_ID], pInfo[playerid][User_ID], amount, nature);
    mysql_tquery(dbHandle, query);
}
forward SaveAllPlayers();
public SaveAllPlayers(){
    return 1;
}
forward DelayedKick(playerid);
public DelayedKick(playerid){
    Kick(playerid);
    return 1;
}

stock SetPlayerMoney(playerid, money){
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, money);
    return 1;
}