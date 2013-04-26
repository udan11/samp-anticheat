/**
 * <summary>Maximum length of a cheat's name.</summary>
 */
#define AC_MAX_CHEAT_NAME				32

/**
 * <summary>An enumeration with the basic definitons of the cheats.</summary>
 */
enum _:AC::eCheats {

	/**
	 * <summary>Unknown hack (used for internal purpose).</summary>
	 */
	AC::cUnknown,
	
	/**
	 * <summary>Not an actual hack. Used for desynced players.</summary>
	 */
	AC::cSync, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with high ping usually spoils other players' gameplay.</summary>
	 */
	AC::cPing, // TODO
	
	/**
	 * <summary>Not an actual hack. Players with low FPS usually spoils other players' gameplay.</summary>
	 */
	AC::cFPS, // TODO
	
	/**
	 * <summary>Not an actual hack. Used for AFK players.</summary>
	 */
	AC::cAFK, // TODO
	
	/**
	 * <summary>Health hack. Restores user's health.</summary>
	 */
	AC::cHealth, // TODO
	
	/**
	 * <summary>Armour hack. Restores user's armour.</summary>
	 */
	AC::cArmour, // TODO
	
	/**
	 * <summary>Money hack.</summary>
	 */
	AC::cMoney, // TODO
	
	/**
	 * <summary>Fake kill. The user is reported to have been killed by multiple persons in short interval.</summary>
	 */
	AC::cFakeKill, // TODO
	
	/**
	 * <summary>Teleport hack. Gives the ability to teleport.</summary>
	 */
	AC::cTeleport, // TODO
	
	/**
	 * <summary>Speed hack. The user / it's vehicle moves faster.</summary>
	 */
	AC::cSpeed, // TODO
	
	/**
	 * <summary>Fly hack. The user looks like he is flying.</summary>
	 */
	AC::cFly, // TODO
	
	/**
	 * <summary>Airbreak hack.</summary>
	 */
	AC::cAirbreak, // TODO
	
	/**
	 * <summary>Weapon hack. The user has the ability to spawn weapons.</summary>
	 */
	AC::cWeapon, // TODO
	
	/**
	 * <summary>Not an actual hack. It detect the player using joypads. It's easier to aim using a joypad.</summary>
	 */
	AC::cJoypad, // TODO
	
	/**
	 * <summary>Aim bot detection. This cheat is quite new and detection methods are not very accurate.</summary>
	 */
	AC::cAimBot, // TODO
	
	/**
	 * <summary>Jetpack hack. Detects if a player has acquired a jetpack in a unscripted way.</summary>
	 */
	AC::cJetpack, // TODO
	
	/**
	 * <summary>Vehicle warp hack. The user has the ability to warp vehicles around him.</summary>
	 */
	AC::cVehicleWarp, // TODO
	
	/**
	 * <summary>Vehicle repair hack. The user has the ability to repair its vehicle without going to a repair / modding shop.</summary>
	 */
	AC::cVehicleRepair, // TODO
	
	/**
	 * <summary>Vehicle mod hack. The user adds (illegal) mods without being in a modding shop.</summary>
	 */
	AC::cVehicleMod, // TODO
	
	/**
	 * <summary>RCON bruteforces. If a player tries to find the RCON password.</summary>
	 */
	AC::cRconBruteforce, // TODO
	
	/**
	 * <summary>Checks if a player is using the famous `m0d_sa` AIO hacking tool.</summary>
	 */
	AC::cModSa, // TODO
};

/**
 * <summary>Enumeration used to define the configuration of an anti-cheat module.</summary>
 */
enum AC::eCheatConfig {
	AC::ccIsEnabled,
	AC::ccName[AC_MAX_CHEAT_NAME]
};