/*
 * jpegconfig.h
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#ifndef CONFIG_H
#define CONFIG_H

#define BLOCK_SIZE 64

#define GRAY 0
#define RGB  1

  UINT8 Lqt [BLOCK_SIZE];
  UINT8 Cqt [BLOCK_SIZE];
  UINT16 ILqt [BLOCK_SIZE];
  UINT16 ICqt [BLOCK_SIZE];

  INT16 Y1 [BLOCK_SIZE];
  INT16 CB [BLOCK_SIZE];
  INT16 CR [BLOCK_SIZE];
  INT16 Temp [BLOCK_SIZE];

  INT16 global_ldc1;
  INT16 global_ldc2;
  INT16 global_ldc3;

  UINT32 lcode;
  UINT16 bitindex;

#endif
