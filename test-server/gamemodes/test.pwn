#include <a_samp>
#define AC_DEBUG
#include <Anticheat>

main() {
	print(" >> Anticheat test gamemode.");
}

public OnPlayerConnect(playerid) {
	GameTextForPlayer(playerid, "~w~SA-MP: ~r~Bare Script", 5000, 5);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	new idx, cmd[256];
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd, "/gh50", true) == 0) {
		SetPlayerHealth(playerid, 50.0);
		return 1;
	} else if (strcmp(cmd, "/gh100", true) == 0) {
		SetPlayerHealth(playerid, 100.0);
		return 1;
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

strtok(const string[], &index) {
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) {
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))) {
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public AC_OnCheatDetected(playerid, cheatid, extraid, info[]) {
	printf("[AC_OnCheatDetected] %d, %d, %d, %s", playerid, cheatid, extraid, info);
}