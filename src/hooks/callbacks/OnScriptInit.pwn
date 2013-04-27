/**
 * <summary>Called when the anticheat's core is being initialized.</summary>
 */
stock AC_OnScriptInit() {
	_AC_DEBUG("[anticheat] Anticheat's timer succesfully injected!");
	AC_watchguardTimer = SetTimer(#AC_Watchguard, AC_WATCHGUARD_INTERVAL, true);
	return 1;
}

// Starting watchguard timer.
#if defined FILTERSCRIPT
	public OnFilterScriptInit() {
		AC_OnScriptInit();
		#if defined AC_OnFilterScriptInit
			return AC_OnFilterScriptInit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit AC_OnFilterScriptInit
	
	#if defined AC_OnFilterScriptInit
		forward AC_OnFilterScriptInit();
	#endif
#else
	public OnGameModeInit() {
		AC_OnScriptInit();
		#if defined AC_OnGameModeInit
			return AC_OnGameModeInit();
		#else
			return 1;
		#endif
	}
	
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit AC_OnGameModeInit
	
	#if defined AC_OnGameModeInit
		forward AC_OnGameModeInit();
	#endif
#endif