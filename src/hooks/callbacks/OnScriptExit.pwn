// Killing watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptExit() {
		KillTimer(AC::watchguardTimer);
		if (funcidx(#AC_OnFilterScriptExit) != -1) {
			CallLocalFunction(#AC_OnFilterScriptExit, "");
		}
		return 1;
	}
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit AC_OnFilterScriptExit
	forward AC_OnFilterScriptExit();
#else
	public OnGameModeExit() {
		KillTimer(AC::watchguardTimer);
		if (funcidx(#AC_OnGameModeExit) != -1) {
			CallLocalFunction(#AC_OnGameModeExit, "");
		}
		return 1;
	}
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit AC_OnGameModeExit
	forward AC_OnGameModeExit();
#endif