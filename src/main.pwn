/**
 * Copyright (c) 2013, Dan
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met: 
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer. 
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution. 
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
// #include guard
#if defined __anticheat_included
	#endinput
#endif
#define __anticheat_included

// Checking for `a_samp.inc`.
#if !defined _samp_included
	#error "Please include <a_samp> before the anticheat."
#endif

#include <foreach>

/**
 * <summary>Macro used to label variables, functions, etc. used by this anticheat.</summary>
 */
#define AC::							AC_

/**
 * <summary>Macro used to generate automatic forward declarations.</summary>
 */
#define AC_PUBLIC:%0(%1) \
	forward %0(%1); public %0(%1)
#define AC_STOCK:%0(%1) \
	forward %0(%1); stock %0(%1)

/**
 * <summary>Creates a stock that calls remote functions.</summary>
 */
#define REMOTE:%0<%1>(%2) \
	stock AC_%0(%2) return CallRemoteFunction(#AC::#%0,#%1,%2)