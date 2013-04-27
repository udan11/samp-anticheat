#define FILTERSCRIPT

#include <a_samp>
#include <Anticheat>

main() {
	print(" >> Anticheat test filterscript.");
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	new idx, cmd[256];
	cmd = strtok(cmdtext, idx);
	if (strcmp(cmd, "/fh50", true) == 0) {
		SetPlayerHealth(playerid, 50.0);
		return 1;
	} else if (strcmp(cmd, "/fh100", true) == 0) {
		SetPlayerHealth(playerid, 100.0);
		return 1;
	}
	return 0;
}

public OnFilterScriptInit() {
	return 1;
}

public OnFilterScriptExit() {
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