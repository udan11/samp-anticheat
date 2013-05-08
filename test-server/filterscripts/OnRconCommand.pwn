/**
 * Copyright (C) 2012-2013 - Dan
 * All rights reserved.
 */

#define FILTERSCRIPT

#include <a_samp>

public OnFilterScriptInit() {
	return 1;
}

public OnFilterScriptExit() {
	return 1;
}

public OnRconCommand(cmd[]) {
	// BUGFIX.
	return 0;
}