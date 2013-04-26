// We check if no parameter was passed to the anticheat.
#if (!defined ANTICHEAT_CORE) && (!defined ANTICHEAT_API)
	#if defined FILTERSCRIPT
		#define ANTICHEAT_API
	#else
		#define ANTICHEAT_CORE
	#endif
#endif

#if defined ANTICHEAT_API
	/**
	 * <summary>API used by remote scripts (other than the core).</summary>
	 */
	#define EXTERN:%0<%1>(%2) \
		stock AC::%0 (%2) \
			return CallRemoteFunction ("JB_"#%0, #%1, %2)
	// TODO.
	#endinput // We stop here, we don't need the core.
#endif