/*
 * rgbimage.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include "rgbimage.h"
//#include <stdio.h>
//#include <string.h>
//#include <stdlib.h>

int IMAGE_SIZE = 512;

/**void initRgbImage(RgbImage* image) {
	image->w = 0;
	image->h = 0;
	image->pixels = NULL;
	image->meta = NULL;
}

int readCell(FILE *fp, char* w) {
	int c;
	int i;

	w[0] = 0;
	for (c = fgetc(fp), i = 0; c != EOF; c = fgetc(fp)) {
		if (c == ' ' || c == '\t') {
			if (w[0] != '\"')
				continue;
		}

		if (c == ',' || c == '\n') {
			if (w[0] != '\"')
				break;
			else if (c == '\"') {
				w[i] = c;
				i++;
				break;
			}
		}

		w[i] = c;
		i++;
	}
	w[i] = 0;

	return c;
}

int loadRgbImage(const char* fileName, RgbImage* image) {
	int c;
	int i;
	int j;
	char w[256];
	RgbPixel** pixels;
	FILE *fp;

	//printf("Loading %s ...\n", fileName);

	fp = fopen(fileName, "r");
	if (!fp) {
		printf("Warning: Oops! Cannot open %s!\n", fileName);
		return 0;
	}



	pixels = (RgbPixel**)malloc(IMAGE_SIZE * sizeof(RgbPixel*));

	if (pixels == NULL) {
		printf("Warning: Oops! Cannot allocate memory for the pixels!\n");

		fclose(fp);

		return 0;
	}

	c = 0;
	for(i = 0; i < IMAGE_SIZE; i++) {
		pixels[i] = (RgbPixel*)malloc(IMAGE_SIZE * sizeof(RgbPixel));
		if (pixels[i] == NULL) {
			c = 1;
			break;
		}
	}

	if (c == 1) {
		printf("Warning: Oops! Cannot allocate memory for the pixels!\n");

		for (i--; i >= 0; i--)
			free(pixels[i]);
		free(pixels);

		fclose(fp);

		return 0;
	}

	int f = 0;
	for(i = 0; i < IMAGE_SIZE;i++) {
		for(j = 0; j < IMAGE_SIZE; j++) {
			pixels[i][j].r = load_image[f];
			pixels[i][j].g = load_image[f+1];
			pixels[i][j].b = load_image[f+2];
			f = f+3;
		}
	}
	image->pixels = pixels;

	image->meta = (char*)malloc(strlen(w) * sizeof(char));
	if(image->meta == NULL) {
		printf("Warning: Oops! Cannot allocate memory for the pixels!\n");

		for (i = 0; i < IMAGE_SIZE; i++)
			free(pixels[i]);
		free(pixels);

		fclose(fp);

		return 0;

	}
	strcpy(image->meta, w);

	//printf("%s\n", image->meta);

	image->w = (IMAGE_SIZE / 8) * 8;
	image->h = (IMAGE_SIZE / 8) * 8;
	//printf("w=%d x h=%d\n", image->w, image->h);

	return 1;
}

int saveRgbImage(RgbImage* image, const char* fileName, float scale) {
	int i;
	int j;
	FILE *fp;

	//printf("Saving %s ...\n", fileName);

	fp = fopen(fileName, "w");
	if (!fp) {
		printf("Warning: Oops! Cannot open %s!\n", fileName);
		return 0;
	}

	fprintf(fp, "%d,%d\n", image->w, image->h);
	//printf("%d,%d\n", image->w, image->h);

	for(i = 0; i < 512*512; i++) {
		
		fprintf(fp, "%d,%d,%d\n", (int)(image->r[i] * scale), (int)(image->g[i] * scale), (int)(image->b[i] * scale));
	}

	fclose(fp);

	return 1;
}*/

/**void freeRgbImage(RgbImage* image) {
	int i;

	if (image->meta != NULL)
		free(image->meta);

	if (image->pixels == NULL)
		return;

	for (i = 0; i < image->h; i++)
		if (image->pixels != NULL)
			free(image->pixels[i]);

	free(image->pixels);
}**/

void makeGrayscale(RgbImage* image) {
	int i;
	int j;
	float luminance;

	float rC = 0.30;
	float gC = 0.59;
	float bC = 0.11;

	for(i = 0; i < 512; i++) {
		for(j = 0; j < 512; j++)
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

