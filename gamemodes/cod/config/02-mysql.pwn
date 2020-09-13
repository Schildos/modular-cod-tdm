/*
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*~*~*~*~*~*~*~*~*~*~*This file is for all the mysql configuration *~*~*~*~*~*~*~*~*~* 
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
*/

/* ** MySQL Settings ** */

#define     MYSQL_HOST          ""
#define     MYSQL_USER          ""
#define     MYSQL_PASS          ""
#define     MYSQL_DATABASE      ""

/* ** Error checking ** */

#if defined FILTERSCRIPT
    #endinput
#endif

/* ** Includes ** */
#include <..\..\..\dependencies\YSI-Includes\YSI_Coding\y_hooks>

/* ** Variables ** */ 
stock MySQL:dbHandle;
stock bool:sql_error = false;

/* ** Main ** */
hook OnScriptInit()
{
    new MySQLOpt:option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true);
    if(mysql_errno((dbHandle = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATABASE, option_id))))
    {
        print("[MYSQL]: Couldn't connect to MySQL Database.");
        sql_error = true;
    }
    else{
        print("[MYSQL]: Connection to Database successful.");
        print("[MYSQL]: Preparing Database...");
        DatabaseInit();
    }
    return 1;
}

hook OnGameModeExit()
{
    db_close(DB:dbHandle);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    if(sql_error){
        SendClientMessage(playerid, 0xff0000, "The server experienced a critical Error on startup. Please contact an admin and wait patiently.");
        return /*KickTimed(playerid), */1;
    }
    return 1;
}

forward DatabaseInit();
public DatabaseInit()
{
//    new query[2700];
    mysql_tquery_file( dbHandle, "cod\\config\\tables.sql");
    print("Database initialized successfully.");
}