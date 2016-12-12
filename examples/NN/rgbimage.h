/*
 * rgbimage.h
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#ifndef RGB_IMAGE_H_
#define RGB_IMAGE_H_

#include "datatype.h"

typedef struct {
   INT16 r;
   INT16 g;
   INT16 b;
} RgbPixel;

typedef struct {
   int w;
   int h;
   int r[512][512];
   int g[512][512];
   int b[512][512]; 
} RgbImage;

void initRgbImage(RgbImage* image);
int loadRgbImage(const char* fileName, RgbImage* image);
int saveRgbImage(RgbImage* image, const char* fileName, float grayscale);
void freeRgbImage(RgbImage* image);

void makeGrayscale(RgbImage* rgbImage);

void readMcuFromRgbImage(RgbImage* srcImage, int x, int y, INT16* data);

#endif /* RGB_IMAGE_H_ */
