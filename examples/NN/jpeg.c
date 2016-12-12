/*
 * jpeg.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "datatype.h"
#include "jpegconfig.h"
#include "prototype.h"
#include "loadimage.h"

UINT8 outputBuffer[500000], outputBufferPtr[500000];
RgbImage srcImage;

#include "rgbimage.h"


#define OUT_BUFFER_SIZE 500000 // in bytes


int main (int argc, const char* argv[]) {
	// char outputFileName[32];
	UINT32 qualityFactor;
	UINT32 imageFormat;
	FILE *fp;

	// strcpy(outputFileName, argv[1]);

	qualityFactor = 1024;
	imageFormat = GRAY;



	
	srcImage.w = 512;
	srcImage.h = 512; 
	int f = 0, i,j;
	for(i = 0; i < 512; i++) {
		for(j = 0; j < 512; j++)
		{
			srcImage.r[i][j] = load_image[f];
			srcImage.g[i][j] = load_image[f+1];
			srcImage.b[i][j] = load_image[f+2];
			f = f+3;
		}
	}


	makeGrayscale(&srcImage);


	int size = encodeImage(
		&srcImage, outputBuffer, qualityFactor, imageFormat
	);



	
	// i = 0;
	// // printf("%d",size);
	// fp = fopen(outputFileName, "wb");
	// if (fp != NULL) {
		
	// 	for(i=0;i<size;i++){
		
	// 		// printf("%d ", outputBuffer[i]);
	// 		//fprintf(fp, "%c" ,outputBuffer[i]);
	// 		//fprintf(fp, "%02x", outputBuffer[i]);
	// 		fputc(outputBuffer[i],fp);
	// 		//fwrite(outputBuffer, 1, 17898, fp);
	// 	}
	// 	fclose(fp);
	// }
	
	return 0;
}
