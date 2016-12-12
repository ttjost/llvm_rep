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

//#include<stdio.h>

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
	

double poww(double x, double y){
	int end = (int)y;
	int i;
	double result = x;
	for(i=1;i<end;i++){
		result = result * x;
	}
	return result;
}




double fat(long int x){

	int i;
	double result = 1.0;
	for(i=0;i<x;i++){
		result = result * (x-i); 
	}

	return result;
}

double expp(double x){
	int r = 10;
	int i;
	double exp1 = 1.0;
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
	
	int k;
	UINT16 i, j;
	global_ldc1 = 0;
	global_ldc2 = 0;
	global_ldc3 = 0;


	/** Quantization Table Initialization */
	initQuantizationTables(qualityFactor);



	
	/* Writing Marker Data */
	k = writeMarkers(outputBuffer, imageFormat, srcImage->w, srcImage->h);


	
	for (i = 0; i < srcImage->h; i += 8) {
		for (j = 0; j <srcImage->w; j += 8) {
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
	int steepness = 1;
	int q = 0;
	int i,j;
	levelShift(Y1);


	for (i = 0; i < BLOCK_SIZE; ++i)
	{
		dataIn[i] = Y1[i] / 256.;
	
	}

	//bool isNN = true;
	
	dataIn[BLOCK_SIZE] = 1; //bias = 1 

	


	for(i=0;i<32; i++)
	{
		it_1[i] = 0; 
		for(j = 0; j < 65; j++)
		{
			it_1[i] = it_1[i] + dataIn[j] * weights[j + q];

		}
		it_1[i] = it_1[i] * activation[steepness];
		steepness = steepness + 2;
		it_1[i] = (1.0/(1.0 + expp(-2.0 * (it_1[i]))));

		q = q + j;
	}

	it_1[layer_size[1] - 1] = 1; //bias = 1
		
	for(i=0;i<64; i++)
	{
		it_2[i] = 0; 
		for(j = 0; j < 33; j++)
		{
			it_2[i] = it_2[i] + it_1[j] * weights[j + q];
		}
		it_2[i] = it_2[i] * activation[steepness];
		steepness = steepness + 2;
		
		it_2[i] = (2.0/(1.0 + expp(-2.0 * (it_2[i]))) - 1.0f);
		q = q + j;
	}

/*
	for(i = 0; i < 64; i++)
	{	
		dataOut[i] = it_2[i];

	}*/
	dataOut[0] = it_2[0];
	dataOut[1] = it_2[1];
	dataOut[2] = it_2[2];
	dataOut[3] = it_2[3];
	dataOut[4] = it_2[4];
	dataOut[5] = it_2[5];
	dataOut[6] = it_2[6];
	dataOut[7] = it_2[7];
	dataOut[8] = it_2[8];
	dataOut[9] = it_2[9];
	dataOut[10] = it_2[10];
	dataOut[11] = it_2[11];
	dataOut[12] = it_2[12];
	dataOut[13] = it_2[13];
	dataOut[14] = it_2[14];
	dataOut[15] = it_2[15];
	dataOut[16] = it_2[16];
	dataOut[17] = it_2[17];
	dataOut[18] = it_2[18];
	dataOut[19] = it_2[19];
	dataOut[20] = it_2[20];
	dataOut[21] = it_2[21];
	dataOut[22] = it_2[22];
	dataOut[23] = it_2[23];
	dataOut[24] = it_2[24];
	dataOut[25] = it_2[25];
	dataOut[26] = it_2[26];
	dataOut[27] = it_2[27];
	dataOut[28] = it_2[28];
	dataOut[29] = it_2[29];
	dataOut[30] = it_2[30];
	dataOut[31] = it_2[31];
	dataOut[32] = it_2[32];
	dataOut[33] = it_2[33];
	dataOut[34] = it_2[34];
	dataOut[35] = it_2[35];
	dataOut[36] = it_2[36];
	dataOut[37] = it_2[37];
	dataOut[38] = it_2[38];
	dataOut[39] = it_2[39];
	dataOut[40] = it_2[40];
	dataOut[41] = it_2[41];
	dataOut[42] = it_2[42];
	dataOut[43] = it_2[43];
	dataOut[44] = it_2[44];
	dataOut[45] = it_2[45];
	dataOut[46] = it_2[46];
	dataOut[47] = it_2[47];
	dataOut[48] = it_2[48];
	dataOut[49] = it_2[49];
	dataOut[50] = it_2[50];
	dataOut[51] = it_2[51];
	dataOut[52] = it_2[52];
	dataOut[53] = it_2[53];
	dataOut[54] = it_2[54];
	dataOut[55] = it_2[55];
	dataOut[56] = it_2[56];
	dataOut[57] = it_2[57];
	dataOut[58] = it_2[58];
	dataOut[59] = it_2[59];
	dataOut[60] = it_2[60];
	dataOut[61] = it_2[61];
	dataOut[62] = it_2[62];
	dataOut[63] = it_2[63];

	for(i = 0; i < BLOCK_SIZE; ++i)
	{
		Temp[i] = dataOut[i] * 256.0;
	}
	if(1 == 1){	
		for(i = 8; i < BLOCK_SIZE; ++i)
		{
			Temp[i] = 0.0;
		}
	}
	

	k = huffman(1, outputBuffer, k);
	return k;
}
