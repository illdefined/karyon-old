#pragma once
#ifndef _TYPES_H
#define _TYPES_H

/**
 * \file
 *
 * \brief Integer type definitions.
 */

#ifndef __ASSEMBLY__

/**
 * \brief Natural width constant.
 */
#define WORD(x) x ## UL

/**
 * \brief Signed 8‐bit integer constant.
 */
#define S8(x)   x

/**
 * \brief Unsigned 8‐bit integer constant.
 */
#define U8(x)   x ## U

/**
 * \brief Signed 16‐bit integer constant.
 */
#define S16(x)  x

/**
 * \brief Unsigned 16‐bit integer constant.
 */
#define U16(x)  x ## U

/**
 * \brief Signed 32‐bit integer constant.
 */
#define S32(x)  x

/**
 * \brief Unsigned 32‐bit integer constant.
 */
#define U32(x)  x ## U

/**
 * \brief Signed 64‐bit integer constant.
 */
#define S64(x)  x ## LL

/**
 * \brief Unsigned 64‐bit integer constant.
 */
#define U64(x)  x ## ULL

/**
 * \brief Boolean type.
 */
typedef _Bool bool;

/**
 * \brief Natural width integer type.
 */
typedef unsigned long word;

/**
 * \brief Signed 8‐bit integer type.
 */
typedef signed char s8;

/**
 * \brief Unsigned 8‐bit integer type.
 */
typedef unsigned char u8;

/**
 * \brief Signed 16‐bit integer type.
 */
typedef signed short s16;

/**
 * \brief Unsigned 16‐bit integer type.
 */
typedef unsigned short u16;

/**
 * \brief Signed 32‐bit integer type.
 */
typedef signed int s32;

/**
 * \brief Unsigned 32‐bit integer type.
 */
typedef unsigned int u32;

/**
 * \brief Signed 64‐bit integer type.
 */
typedef signed long long s64;

/**
 * \brief Unsigned 64‐bit integer type.
 */
typedef unsigned long long u64;

#else /* __ASSEMBLY__ */

#define WORD(x) x

#define S8(x)   x
#define U8(x)   x

#define S16(x)  x
#define U16(x)  x

#define S32(x)  x
#define U32(x)  x

#define S64(x)  x
#define U64(x)  x

#endif /* __ASSEMBLY__ */

#endif /* _TYPES_H */
