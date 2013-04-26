// Injecting watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptInit() {
		AC::watchguardTimer = SetTimer(#AC::Watchguard, AC_WATCHGUARD_INTERVAL, true);
		if (funcidx(#AC_OnFilterScriptInit) != -1) {
			CallLocalFunction(#AC_OnFilterScriptInit, "");
		}
		return 1;
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit AC_OnFilterScriptInit
	forward AC_OnFilterScriptInit();
#else
	public OnGameModeInit() {
		AC::watchguardTimer = SetTimer(#AC::Watchguard, AC_WATCHGUARD_INTERVAL, true);
		if (funcidx(#AC_OnGameModeInit) != -1) {
			CallLocalFunction(#AC_OnGameModeInit, "");
		}
		return 1;
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit AC_OnGameModeInit
	forward AC_OnGameModeInit();
#endif