#pragma once
#ifndef _MULTIBOOT_H
#define _MULTIBOOT_H

/**
 * \file
 *
 * \brief Multiboot definitions.
 */

#include <types.h>

/**
 * \brief Multiboot header magic.
 */
#define MULTIBOOT_HEADER_MAGIC U32(0x1BADB002)

/**
 * \brief Multiboot header flags.
 *
 * Align modules to page boundary.
 */
#define MULTIBOOT_HEADER_FLAGS U32(0x00000001)

/**
 * \brief Multiboot boot loader magic.
 */
#define MULTIBOOT_LOADER_MAGIC U32(0x2BADB002)

#endif /* _MULTIBOOT_H */
