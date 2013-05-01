#if defined AC_MASTER

	/**
	 * <summary>Called when the anticheat's core is being destroyed.</summary>
	 */
	stock AC_OnScriptExit() {
		KillTimer(AC_watchguardTimer);
		return 1;
	}

	// Killing watchguard timer.
	#if defined FILTERSCRIPT
		public OnFilterScriptExit() {
			AC_OnScriptExit();
			#if defined AC_OnFilterScriptExit
				return AC_OnFilterScriptExit();
			#else
				return 1;
			#endif
		}
		
		#if defined _ALS_OnFilterScriptExit
			#undef OnFilterScriptExit
		#else
			#define _ALS_OnFilterScriptExit
		#endif
		#define OnFilterScriptExit AC_OnFilterScriptExit
		
		#if defined AC_OnFilterScriptExit
			forward AC_OnFilterScriptExit();
		#endif
	#else
		public OnGameModeExit() {
			AC_OnScriptExit();
			#if defined AC_OnGameModeExit
				return AC_OnGameModeExit();
			#else
				return 1;
			#endif
		}
		
		#if defined _ALS_OnGameModeExit
			#undef OnGameModeExit
		#else
			#define _ALS_OnGameModeExit
		#endif
		#define OnGameModeExit AC_OnGameModeExit
		
		#if defined AC_OnGameModeExit
			forward AC_OnGameModeExit();
		#endif
	#endif
	
#endif