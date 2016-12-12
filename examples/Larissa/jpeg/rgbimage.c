/*
 * rgbimage.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include "rgbimage.h"

int IMAGE_SIZE = 32;


void makeGrayscale(RgbImage* image) {
	int i;
	int j;
	float luminance;

	float rC = 0.30;
	float gC = 0.59;
	float bC = 0.11;

	for(i = 0; i < 32; i++) {
		for(j = 0; j < 32; j++)
		{
			luminance =
				rC * image->r[i][j] +
				gC * image->g[i][j] +
				bC * image->b[i][j];

			image->r[i][j] = (INT16)luminance;
			image->g[i][j] = (INT16)luminance;
			image->b[i][j] = (INT16)luminance;
		}
	}	
}

void readMcuFromRgbImage(RgbImage* image, int x, int y, INT16* data) {
	int i, j;

	for (i = 0; i < 8; ++i) {
		for(j = 0; j < 8; ++j)
			data[i * 8 + j] = (image->r[y + i][j + x]);
	}

#if 0
	for (i = 0; (i < 8) && ((y + i) < image->h); ++i) {
		for(j = 0; (j < 8) && ((x + i) < image->w); ++j)
			data[i * 8 + j] = (image->r[x + j]);

		for(; j < 8; ++j)
			data[i * 8 + j] = (image->r[y + i]);
	}

	for (; i < 8; ++i) {
		for(j = 0; (j < 8) && ((x + i) < image->w); ++j)
			data[i * 8 + j] = (image->r[image->h - 1]);

		for(; j < 8; ++j)
			data[i * 8 + j] = (image->r[image->h - 1]);
	}
#endif
}

