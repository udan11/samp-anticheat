/**
 * <author>Slice</author>
 * <remarks>http://forum.sa-mp.com/showthread.php?p=1606781</remarks>
 */
stock memset(aArray[], iValue, iSize = sizeof(aArray)) {
	new iAddress;
	// Store the address of the array
	#emit LOAD.S.pri 12
	#emit STOR.S.pri iAddress
	// Convert the size from cells to bytes
	iSize *= 4;
	// Loop until there is nothing more to fill
	while (iSize > 0) {
		// I have to do this because the FILL instruction doesn't accept a dynamic number.
		if (iSize >= 4096) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 4096
			iSize    -= 4096;
			iAddress += 4096;
		} else if (iSize >= 1024) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 1024
			iSize    -= 1024;
			iAddress += 1024;
		} else if (iSize >= 256) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 256
			iSize    -= 256;
			iAddress += 256;
		} else if (iSize >= 64) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 64
			iSize    -= 64;
			iAddress += 64;
		} else if (iSize >= 16) {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 16
			iSize    -= 16;
			iAddress += 16;
		} else {
			#emit LOAD.S.alt iAddress
			#emit LOAD.S.pri iValue
			#emit FILL 4
			iSize    -= 4;
			iAddress += 4;
		}
	}
	// aArray is used, just not by its symbol name
	#pragma unused aArray
}