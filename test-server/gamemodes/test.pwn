#include <a_samp>

#define AC_DEBUG
#define AC_MASTER
#include <Anticheat>

#include <sscanf2>

main() {}

new Text:fpsTexts[MAX_PLAYERS];

public OnPlayerConnect(playerid) {
	GameTextForPlayer(playerid, "~w~SA-MP: ~r~Anticheat Test Script", 5000, 5);
	fpsTexts[playerid] = TextDrawCreate(630.000000, 432.000000, "FPS: ?");
	TextDrawAlignment(fpsTexts[playerid], 3);
	TextDrawBackgroundColor(fpsTexts[playerid], 725113087);
	TextDrawFont(fpsTexts[playerid], 2);
	TextDrawLetterSize(fpsTexts[playerid], 0.230000, 1.299998);
	TextDrawColor(fpsTexts[playerid], 462348543);
	TextDrawSetOutline(fpsTexts[playerid], 1);
	TextDrawSetProportional(fpsTexts[playerid], 1);
	TextDrawShowForPlayer(playerid, fpsTexts[playerid]);
	return 1;
}

public OnPlayerDisconnect(playerid, reason) {
	TextDrawDestroy(fpsTexts[playerid]);
	return 1;
}

public OnPlayerUpdate(playerid) {
	new fps = AC_GetPlayerFPS(playerid), str[32];
	format(str, sizeof(str), "FPS: %d", fps);
	TextDrawSetString(fpsTexts[playerid], str);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if (IsPlayerAdmin(playerid)) {
		new cmd[64];
		if (sscanf(cmdtext, "s[64] ", cmd)) {
			return 0;
		}
		if (strcmp(cmd, "/g_sethealth", true) == 0) {
			new Float:health;
			if (sscanf(cmdtext, "{s[64]} f", health)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				SetPlayerHealth(playerid, health);
			}
			return 1;
		} else if (strcmp(cmd, "/g_setarmour", true) == 0) {
			new Float:armour;
			if (sscanf(cmdtext, "{s[64]} f", armour)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				SetPlayerArmour(playerid, armour);
			}
			return 1;
		} else if (strcmp(cmd, "/g_givemoney", true) == 0) {
			new money;
			if (sscanf(cmdtext, "{s[64]} i", money)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				GivePlayerMoney(playerid, money);
			}
			return 1;
		} else if (strcmp(cmd, "/g_resetmoney", true) == 0) {
			ResetPlayerMoney(playerid);
			return 1;
		}
	}
	return 0;
}

public OnPlayerSpawn(playerid) {
	SetPlayerInterior(playerid, 0);
	TogglePlayerClock(playerid, 0);
	return 1;
}

public OnPlayerRequestClass(playerid, classid) {
 	SetPlayerInterior(playerid, 14);
	SetPlayerPos(playerid, 258.4893, -41.4008, 1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid, 256.0815, -43.0475, 1004.0234);
	SetPlayerCameraLookAt(playerid, 258.4893, -41.4008, 1002.0234);
	return 1;
}

public OnGameModeInit() {
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	ShowNameTags(true);
	AddPlayerClass(265, 1958.3783, 1343.1572, 15.3746, 270.1425, 0, 0, 0, 0, -1, -1);
	return 1;
}

public OnGameModeExit() {
	return 1;
}