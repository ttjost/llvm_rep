/*
 * encoder.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */
#include "datatype.h"
#include "jpegconfig.h"
#include "prototype.h"
#include "rgbimage.h"
#include "nnconfiguration.h"
#include <stdio.h>
#include <math.h>




UINT8	Lqt [BLOCK_SIZE];
UINT8	Cqt [BLOCK_SIZE];
UINT16	ILqt [BLOCK_SIZE];
UINT16	ICqt [BLOCK_SIZE];

INT16	Y1 [BLOCK_SIZE];
INT16	Y2 [BLOCK_SIZE];
INT16	Y3 [BLOCK_SIZE];
INT16	Y4 [BLOCK_SIZE];
INT16	CB [BLOCK_SIZE];
INT16	CR [BLOCK_SIZE];
INT16	Temp [BLOCK_SIZE];
UINT32 lcode = 0;
UINT16 bitindex = 0;

INT16 global_ldc1;
INT16 global_ldc2;
INT16 global_ldc3;
float it_1[33]; // bias
	float it_2[64]; // no bias
	float dataIn [BLOCK_SIZE + 1];
	float dataOut[BLOCK_SIZE];
	

float poww(float x, float y){
	int end = (int)y;
	int i;
	float result = x;
	for(i=1;i<end;i++){
		result = result * x;
	}
	return result;
}



float fat(long int x){

	int i;
	float result = 1.0;
	for(i=0;i<x;i++){
		result = result * (x-i); 
	}

	return result;
}

float expp(float x){
	int r = 10;
	int i;
	float exp1 = 1.0;
	for(i=1;i<=r;i++){
		exp1 = exp1 + (poww(x,i)/fat(i));
	}


	return exp1;
}




int encodeImage(
	RgbImage* srcImage,
	UINT8 outputBuffer[],
	UINT32 qualityFactor,
	UINT32 imageFormat
) {
	

	global_ldc1 = 0;
	global_ldc2 = 0;
	global_ldc3 = 0;


	/** Quantization Table Initialization */
	initQuantizationTables(qualityFactor);



	UINT16 i, j;
	/* Writing Marker Data */
	int k = writeMarkers(outputBuffer, imageFormat, srcImage->w, srcImage->h);


	
	for (i = 0; i < srcImage->h; i += 8) {
		for (j = 0; j < srcImage->w; j += 8) {
			readMcuFromRgbImage(srcImage, j, i, Y1);
			/* Encode the data in MCU */
			//outputBuffer = encodeMcu(imageFormat, outputBuffer);
			k = encodeMcu(imageFormat, outputBuffer, k);
		}
	}

	k = closeBitstream(outputBuffer,k);

	return k;
}


int encodeMcu(UINT32 imageFormat, UINT8 outputBuffer[], int k) 
{
	int i,j;
	levelShift(Y1);


	for (i = 0; i < BLOCK_SIZE; ++i)
	{
		dataIn[i] = Y1[i] / 256.;
	}

	//bool isNN = true;
	


	
	dataIn[BLOCK_SIZE] = 1; //bias = 1 
	int steepness = 1;
	int q = 0;
	


	for(i=0;i<layer_size[1] - 1; i++)
	{
		it_1[i] = 0; 
		for(j = 0; j < layer_size[0]; j++)
		{
			it_1[i] = it_1[i] + dataIn[j] * weights[j + q];
		}
		it_1[i] = it_1[i] * activation[steepness];
		steepness = steepness + 2;
		it_1[i] = (1.0/(1.0 + exp(-2.0 * (it_1[i]))));
		q = q + j;
	}

	it_1[layer_size[1] - 1] = 1; //bias = 1
		
	for(i=0;i<layer_size[2] - 1; i++)
	{
		it_2[i] = 0; 
		for(j = 0; j < layer_size[1]; j++)
		{
			it_2[i] = it_2[i] + it_1[j] * weights[j + q];
		}
		it_2[i] = it_2[i] * activation[steepness];
		steepness = steepness + 2;
		printf("%d,%f\n",i,exp(-2.0 * (it_2[i])));
		it_2[i] = (2.0/(1.0 + exp(-2.0 * (it_2[i]))) - 1.0f);
		q = q + j;
	}

	for(i = 0; i < layer_size[2] - 1; i++)
	{	
		dataOut[i] = it_2[i];

	}

/*original
	dct(Y1);
	quantization(Y1, ILqt);

	for (i = 0; i < BLOCK_SIZE; ++i)
	{
		dataOut[i] = Temp[i] / 256.;
	}
	isNN = false;

**/



	for(i = 0; i < BLOCK_SIZE; ++i)
	{
		
		Temp[i] = (INT16)(dataOut[i] * 256.0);
		
	}
	if(1 == 1)
	{
		for(i = 8; i < BLOCK_SIZE; ++i)
		{
			Temp[i] = 0.0;
		}
	}


	k = huffman(1, outputBuffer, k);
	return k;
}
