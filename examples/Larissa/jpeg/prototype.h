/*
 * prototype.h
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#ifndef PROTOTYPE_H
#define PROTOTYPE_H


#include "rgbimage.h"


UINT16 dspDivision(UINT32, UINT32);

void initQuantizationTables(UINT32);

int writeMarkers(UINT8 outoutBuffer[], UINT32 imageFormat, UINT32 width, UINT32 height);
int closeBitstream (UINT8 outputBuffer[], int k);

//UINT8* encodeImage(RgbImage*, UINT8 *, UINT32, UINT32);
int encodeImage(RgbImage*, UINT8 *, UINT32, UINT32);
//UINT8* encodeMcu(UINT32, UINT8*);
int encodeMcu(UINT32 imageFormat, UINT8 outputBuffer[], int k);

void levelShift(INT16 *);
void dct(INT16 *);
void quantization(INT16 *, UINT16 *);
int huffman (UINT16 component, UINT8 output_ptr[], int k);

#endif
