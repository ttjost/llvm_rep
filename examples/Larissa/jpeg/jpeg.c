/*
 * jpeg.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include <stdio.h>
#include <string.h>

#include "datatype.h"
#include "jpegconfig.h"
#include "prototype.h"
#include "loadimage.h"

UINT8 outputBuffer[5000], outputBufferPtr[5000];
RgbImage srcImage;

#include "rgbimage.h"


#define OUT_BUFFER_SIZE 500000 // in bytes


int main (int argc, const char* argv[]) {
	char outputFileName[32];
	UINT32 qualityFactor;
	UINT32 imageFormat;
	int i,j,f = 145*3;/*f=0;*/
	int size; 
	FILE *fp;

	strcpy(outputFileName, argv[1]);

	qualityFactor = 1024;
	imageFormat = GRAY;



	
	srcImage.w =  32;
	srcImage.h = 32;

	for(i = 0; i < 32; i++)
	{
		for(j = 0; j < 32; j++)
		{
			srcImage.r[i][j] = load_image[f];
			srcImage.g[i][j] = load_image[f+1];
			srcImage.b[i][j] = load_image[f+2];
			f = f+3;
		}
		f = f + 480*3;
			
	}


	makeGrayscale(&srcImage);


	size = encodeImage(
		&srcImage, outputBuffer, qualityFactor, imageFormat
	);


	
	i = 0;
	fp = fopen(outputFileName, "wb");
	if (fp != NULL) {
		
		for(i=0;i<size;i++){
		
			//printf("%d ", outputBuffer[i]);
			//fprintf(fp, "%c" ,outputBuffer[i]);
			//fprintf(fp, "%02x", outputBuffer[i]);
			fputc(outputBuffer[i],fp);
			//fwrite(outputBuffer, 1, 17898, fp);
		}
		fclose(fp);
	}
	
	return 0;
}

