#pragma once
#ifndef _MEMORY_H
#define _MEMORY_H

/**
 * \file
 *
 * \brief Memory layout definitions.
 */

#include <types.h>

/**
 * \brief Virtual kernel base address.
 */
#define KERN_BASE WORD(0xFFFF800000000000)

/**
 * \brief Page size
 */
#define PAGE_SIZE WORD(4096)

/**
 * \brief Word size.
 */
#define WORD_SIZE WORD(8)

#endif /* _MEMORY_H */
