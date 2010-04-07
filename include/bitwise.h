#pragma once
#ifndef _BITWISE_H
#define _BITWISE_H

/**
 * \file
 *
 * \brief Specific byte‐order integer types.
 */

#include <types.h>

#ifdef __CHECKER__
#define __bitwise __attribute__((bitwise))
#else
#define __bitwise
#endif

#ifndef __ASSEMBLY__

/**
 * \brief Big‐endian 16‐bit integer type.
 */
typedef u16 __bitwise be16;

/**
 * \brief Little‐endian 16‐bit integer type.
 */
typedef u16 __bitwise le16;

/**
 * \brief Big‐endian 32‐bit integer type.
 */
typedef u32 __bitwise be32;

/**
 * \brief Little‐endian 32‐bit integer type.
 */
typedef u32 __bitwise le32;

/**
 * \brief Big‐endian 64‐bit integer type.
 */
typedef u64 __bitwise be64;

/**
 * \brief Little‐endian 32‐bit integer type.
 */
typedef u64 __bitwise le64;

#endif /* __ASSEMBLY__ */

#endif /* _BITWISE_H */
