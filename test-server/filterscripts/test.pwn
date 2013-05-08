#define FILTERSCRIPT

#include <a_samp>

#define AC_SLAVE
#include <Anticheat>

#include <sscanf2>

main() {}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if (IsPlayerAdmin(playerid)) {
		new cmd[64];
		if (sscanf(cmdtext, "s[64] ", cmd)) {
			return 0;
		}
		if (strcmp(cmd, "/f_sethealth", true) == 0) {
			new Float:health;
			if (sscanf(cmdtext, "{s[64]} f", health)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				SetPlayerHealth(playerid, health);
			}
			return 1;
		} else if (strcmp(cmd, "/f_setarmour", true) == 0) {
			new Float:armour;
			if (sscanf(cmdtext, "{s[64]} f", armour)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				SetPlayerArmour(playerid, armour);
			}
			return 1;
		} else if (strcmp(cmd, "/f_givemoney", true) == 0) {
			new money;
			if (sscanf(cmdtext, "{s[64]} i", money)) {
				SendClientMessage(playerid, 0xCCCCCCFF, " ** Invalid command parameters.");
			} else {
				GivePlayerMoney(playerid, money);
			}
			return 1;
		} else if (strcmp(cmd, "/f_resetmoney", true) == 0) {
			ResetPlayerMoney(playerid);
			return 1;
		}
	}
	return 0;
}

public OnFilterScriptInit() {
	return 1;
}

public OnFilterScriptExit() {
	return 1;
}