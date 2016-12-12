/*
 * marker.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include "datatype.h"
#include "jpegconfig.h"
#include "markdata.h"


// Header for JPEG Encoder

int writeMarkers(
	UINT8 outoutBuffer[], UINT32 imageFormat, UINT32 width, UINT32 height
) {
	int j =0;
	UINT16 i, headerLength;
	UINT8 numberOfComponents;
		outoutBuffer[j++]=0xFF;
		outoutBuffer[j++]=0xD8;
		outoutBuffer[j++]=0xFF;
		outoutBuffer[j++]=0xDB;
		outoutBuffer[j++]=0x00;
		outoutBuffer[j++]=0x84;
		outoutBuffer[j++]=0x00;

	// Lqt table
	for (i = 0; i < 64; i++)
		outoutBuffer[j++] = Lqt[i];

	// Pq, Tq
	outoutBuffer[j++] = 0x01;

	// Cqt table
	for (i = 0; i < 64; i++)
		outoutBuffer[j++] = Cqt[i];

	// huffman table(DHT)
	for (i = 0; i < 210; i++) {
		outoutBuffer[j++] = (UINT8) (markerdata[i] >> 8);
		outoutBuffer[j++] = (UINT8) markerdata[i];
	}

	if (imageFormat == GRAY)
		numberOfComponents = 1;
	else
		numberOfComponents = 3;

	// Frame header(SOF)

	// Start of frame marker
	outoutBuffer[j++] = 0xFF;
	outoutBuffer[j++] = 0xC0;

	headerLength = (UINT16) (8 + 3 * numberOfComponents);

	// Frame header length
	outoutBuffer[j++] = (UINT8) (headerLength >> 8);
	outoutBuffer[j++] = (UINT8) headerLength;

	// Precision (P)
	outoutBuffer[j++] = 0x08;

	// image height
	outoutBuffer[j++] = (UINT8) (height >> 8);
	outoutBuffer[j++] = (UINT8) height;

	// image width
	outoutBuffer[j++] = (UINT8) (width >> 8);
	outoutBuffer[j++] = (UINT8) width;

	// Nf
	outoutBuffer[j++] = numberOfComponents;

	if (imageFormat == GRAY) {
		outoutBuffer[j++] = 0x01;
		outoutBuffer[j++] = 0x11;
		outoutBuffer[j++] = 0x00;
	} else {
		outoutBuffer[j++] = 0x01;

		outoutBuffer[j++] = 0x21;

		outoutBuffer[j++] = 0x00;

		outoutBuffer[j++] = 0x02;
		outoutBuffer[j++] = 0x11;
		outoutBuffer[j++] = 0x01;

		outoutBuffer[j++] = 0x03;
		outoutBuffer[j++] = 0x11;
		outoutBuffer[j++] = 0x01;
	}

	// Scan header(SOF)

	// Start of scan marker
	outoutBuffer[j++] = 0xFF;
	outoutBuffer[j++] = 0xDA;

	headerLength = (UINT16) (6 + (numberOfComponents << 1));

	// Scan header length
	outoutBuffer[j++] = (UINT8) (headerLength >> 8);
	outoutBuffer[j++] = (UINT8) headerLength;

	// Ns
	outoutBuffer[j++] = numberOfComponents;

	if (imageFormat == GRAY) {
		outoutBuffer[j++] = 0x01;
		outoutBuffer[j++] = 0x00;
	} else {
		outoutBuffer[j++] = 0x01;
		outoutBuffer[j++] = 0x00;

		outoutBuffer[j++] = 0x02;
		outoutBuffer[j++] = 0x11;

		outoutBuffer[j++] = 0x03;
		outoutBuffer[j++] = 0x11;
	}

	outoutBuffer[j++] = 0x00;
	outoutBuffer[j++] = 0x3F;
	outoutBuffer[j++] = 0x00;

	return j;
}
