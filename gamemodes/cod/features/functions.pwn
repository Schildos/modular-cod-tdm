forward LogAdminAction(playerid, toplayerid, action);
public LogAdminAction(playerid, toplayerid, action){
    new query[256],
        admin_name[24],
        target_name[24];
    target_name = GetPlayerName(toplayerid, target_name sizeof(target_name));
    mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `ADMIN_LOG` (`ISSUER`, `ADMIN_LEVEL`, `ACTION`, `ACTION_ID`, `TARGET`) VALUES ('%e', '%d', '%e', '%d', '%e') LIMIT 1", admin_name, pInfo[playerid][Admin], action, action_id, target_name);
    mysql_tquery(dbHandle, query);
}
forward LogNameChange(playerid, toplayerid, old_name, new_name);
public LogNameChange(playerid, toplayerid, old_name, new_name){
    new query[256],
        admin_name[24];
    admin_name = GetPlayerName(playerid, admin_name, sizeof(admin_name));
    mysql_format(dbHandle, query, sizeof(query), "INSERT INTO `NAME_CHANGES` (`USER_ID`, `ADMIN_NAME`, `FROM_NAME`, `TO_NAME`) VALUES ('%d', '%e', '%e', '%e')", pInfo[toplayerid][User_ID], admin_name, old_name, new_name);
    mysql_tquery(dbHandle, query);
}
forward LogTransaction(playerid, toplayerid, amount, nature)