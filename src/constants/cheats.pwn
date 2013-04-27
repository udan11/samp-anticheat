/**
 * <summary>Maximum length of a cheat's name.</summary>
 */
#define AC_MAX_CHEAT_NAME				32

/**
 * <summary>An enumeration with the basic definitons of the cheats.</summary>
 */
enum _:AC_eCheats {

	/**
	 * <summary>Unknown hack (used for internal purpose).</summary>
	 */
	AC_cUnknown,
	
	/**
	 * <summary>Not an actual hack. Used for desynced players.</summary>
	 */
	AC_cSync, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with high ping usually spoils other players' gameplay.</summary>
	 */
	AC_cPing, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with low FPS usually spoils other players' gameplay.</summary>
	 */
	AC_cFPS, // TODO
	
	/**
	 * <summary>Not an actual hack. Used for AFK players.</summary>
	 */
	AC_cAFK, // TODO
	
	/**
	 * <summary>Health hack. Restores user's health.</summary>
	 */
	AC_cHealth, // TODO
	
	/**
	 * <summary>Armour hack. Restores user's armour.</summary>
	 */
	AC_cArmour, // TODO
	
	/**
	 * <summary>Money hack.</summary>
	 */
	AC_cMoney, // TODO
	
	/**
	 * <summary>Fake kill. The user is reported to have been killed by multiple persons in short interval.</summary>
	 */
	AC_cFakeKill, // TODO
	
	/**
	 * <summary>Teleport hack. Gives the ability to teleport.</summary>
	 */
	AC_cTeleport, // TODO
	
	/**
	 * <summary>Speed hack. The user / it's vehicle moves faster.</summary>
	 */
	AC_cSpeed, // TODO
	
	/**
	 * <summary>Fly hack. The user looks like he is flying.</summary>
	 */
	AC_cFly, // TODO
	
	/**
	 * <summary>Airbreak hack.</summary>
	 */
	AC_cAirbreak, // TODO
	
	/**
	 * <summary>Weapon hack. The user has the ability to spawn weapons.</summary>
	 */
	AC_cWeapon, // TODO
	
	/**
	 * <summary>Not an actual hack. It detect the player using joypads. It's easier to aim using a joypad.</summary>
	 */
	AC_cJoypad, // TODO
	
	/**
	 * <summary>Aim bot detection. This cheat is quite new and detection methods are not very accurate.</summary>
	 */
	AC_cAimBot, // TODO
	
	/**
	 * <summary>Jetpack hack. Detects if a player has acquired a jetpack in a unscripted way.</summary>
	 */
	AC_cJetpack, // TODO
	
	/**
	 * <summary>Vehicle warp hack. The user has the ability to warp vehicles around him.</summary>
	 */
	AC_cVehicleWarp, // TODO
	
	/**
	 * <summary>Vehicle repair hack. The user has the ability to repair its vehicle without going to a repair / modding shop.</summary>
	 */
	AC_cVehicleRepair, // TODO
	
	/**
	 * <summary>Vehicle mod hack. The user adds (illegal) mods without being in a modding shop.</summary>
	 */
	AC_cVehicleMod, // TODO
	
	/**
	 * <summary>RCON bruteforces. If a player tries to find the RCON password.</summary>
	 */
	AC_cRconBruteforce, // TODO
	
	/**
	 * <summary>Checks if a player is using the famous `m0d_sa` AIO hacking tool.</summary>
	 */
	AC_cModSa, // TODO
};

/**
 * <summary>Enumeration used to define the configuration of an anti-cheat module.</summary>
 */
enum AC_eCheatConfig {
	AC_ccIsEnabled,
	AC_ccName[AC_MAX_CHEAT_NAME]
};