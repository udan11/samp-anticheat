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
 *
 * Special thanks to:
 *	  cessil - useful anticheat tips
 *	  Slice - memset
 *	  Y_Less - very thorough research
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
 * <summary>Checks if a string is null.</summary>
 */
#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

/**
 * <summary>Macro used for debugging purposes.</summary>
 */
#if defined AC_DEBUG
	#define _AC_DEBUG(%0)				printf(%0)
#else
	#define _AC_DEBUG(%0);
#endif

/**
 * <summary>Generate forward declarations for public and stock functions.</summary>
 */
#define AC_PUBLIC%0\32;%0(%1) \
	forward %0(%1); public %0(%1)
#define AC_STOCK%0\32;%0(%1) \
	forward %0(%1); stock %0(%1)