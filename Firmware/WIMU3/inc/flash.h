#ifndef FLASH_H_
#define FLASH_H_

#include "config.h"
#include "stm32l1xx_flash.h"
#include "stm32l1xx_rcc.h"
#include <string.h>
#include <stdint.h>

#define DATA_EEPROM_BASE            0x08080000

#define DATA_EEPROM_SETTING_OFFSET  0x00000000
#define DATA_EEPROM_SETTING_BASE    (DATA_EEPROM_BASE + DATA_EEPROM_SETTING_OFFSET)

#define DATA_EEPROM_CONFIG_OFFSET   0x00000040
#define DATA_EEPROM_CONFIG_BASE     (DATA_EEPROM_BASE + DATA_EEPROM_CONFIG_OFFSET)

//------------------------
// Structure Define
//------------------------

//------------------------
// Functions Define
//------------------------

void flash_init(void);
uint8_t flash_write_settings(WIMU_SETTINGS* settings);
uint8_t flash_write_config(WIMU_CONFIG* config);
uint32_t crc_calc(uint8_t* data, uint16_t NbrOfByte);
void flash_default_settings(WIMU_SETTINGS* settings);
void flash_default_config(WIMU_CONFIG* config);
void flash_read_settings(WIMU_SETTINGS* settings);
void flash_read_config(WIMU_CONFIG* config);

//------------------------
// Variables Define
//------------------------

#endif /*FLASH_H_*/
