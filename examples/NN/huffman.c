
/*
 * huffman.c
 * 
 * Created on: Sep 9, 2013
 * 			Author: Amir Yazdanbakhsh <a.yazdanbakhsh@gatech.edu>
 */

#include "datatype.h"
#include "jpegconfig.h"
#include "prototype.h"
#include "huffdata.h"
#include <stdio.h>

#define PUTBITS	\
{	\
	bits_in_next_word = (INT16) (bitindex + numbits - 32);	\
	if (bits_in_next_word < 0)	\
	{	\
		lcode = (lcode << numbits) | data;	\
		bitindex += numbits;	\
	}	\
	else	\
	{	\
		lcode = (lcode << (32 - bitindex)) | (data >> bits_in_next_word);	\
		if ((output_ptr[k++] = (UINT8)(lcode >> 24)) == 0xff)	\
			output_ptr[k++] = 0;	\
		if ((output_ptr[k++] = (UINT8)(lcode >> 16)) == 0xff)	\
			output_ptr[k++] = 0;	\
		if ((output_ptr[k++] = (UINT8)(lcode >> 8)) == 0xff)	\
			output_ptr[k++] = 0;	\
		if ((output_ptr[k++] = (UINT8) lcode) == 0xff)	\
			output_ptr[k++] = 0;	\
		lcode = data;	\
		bitindex = bits_in_next_word;	\
	}	\
}

int huffman (UINT16 component, UINT8 output_ptr[], int k)
{
	UINT16 i;
	UINT16 *DcCodeTable, *DcSizeTable, *AcCodeTable, *AcSizeTable;

	INT16 *Temp_Ptr, Coeff, LastDc;
	UINT16 AbsCoeff, HuffCode, HuffSize, RunLength=0, DataSize=0, index;

	INT16 bits_in_next_word;
	UINT16 numbits;
	UINT32 data;

	// printf("huffman: %d\n",k);

	Temp_Ptr = Temp;
	Coeff = *Temp_Ptr++;

	// printf("Coeff: %d\n",Coeff);	

	if (component == 1)
	{
		// printf("Component1\n");
		DcCodeTable = luminance_dc_code_table;
		DcSizeTable = luminance_dc_size_table;
		AcCodeTable = luminance_ac_code_table;
		AcSizeTable = luminance_ac_size_table;

		LastDc = global_ldc1;
		global_ldc1 = Coeff;
	}
	else
	{
			// printf("Component2\n");
		DcCodeTable = chrominance_dc_code_table;
		DcSizeTable = chrominance_dc_size_table;
		AcCodeTable = chrominance_ac_code_table;
		AcSizeTable = chrominance_ac_size_table;

		if (component == 2)
		{
			LastDc = global_ldc2;
			global_ldc2 = Coeff;
		}
		else
		{
			LastDc = global_ldc3;
			global_ldc3 = Coeff;
		}
	}

	Coeff -= LastDc;


	AbsCoeff = (Coeff < 0) ? -Coeff-- : Coeff;

	while (AbsCoeff != 0)
	{
		AbsCoeff >>= 1;
		DataSize++;
	}

	HuffCode = DcCodeTable [DataSize];
	HuffSize = DcSizeTable [DataSize];

	Coeff &= (1 << DataSize) - 1;
	data = (HuffCode << DataSize) | Coeff;
	numbits = HuffSize + DataSize;

	// printf("Huffsize: %d\n",HuffSize);
	// printf("DataSize: %d\n",DataSize);

	// printf("before putbits: %d\n",k);
	// printf("before bitindex: %d\n",bitindex);
	// printf("before numbits: %d\n",numbits);
	PUTBITS
	// printf("after putbits: %d\n\n",k);
	// printf("after bitindex: %d\n",bitindex);
	// printf("after numbits: %d\n",numbits);

	for (i=63; i>0; i--)
	{
		if ((Coeff = *Temp_Ptr++) != 0)
		{
			while (RunLength > 15)
			{
				RunLength -= 16;
				data = AcCodeTable [161];
				numbits = AcSizeTable [161];
				PUTBITS
			}

			AbsCoeff = (Coeff < 0) ? -Coeff-- : Coeff;

			if (AbsCoeff >> 8 == 0)
				DataSize = bitsize [AbsCoeff];
			else
				DataSize = bitsize [AbsCoeff >> 8] + 8;

			index = RunLength * 10 + DataSize;
			HuffCode = AcCodeTable [index];
			HuffSize = AcSizeTable [index];

			Coeff &= (1 << DataSize) - 1;
			data = (HuffCode << DataSize) | Coeff;
			numbits = HuffSize + DataSize;

			PUTBITS
			RunLength = 0;
		}
		else
			RunLength++;
	}

	if (RunLength != 0)
	{
		data = AcCodeTable [0];
		numbits = AcSizeTable [0];
		PUTBITS
	}
	return k;
}

 //For bit Stuffing and EOI marker 
int closeBitstream (UINT8 outputBuffer[], int k)
{
	UINT16 i, count;
	UINT8 *ptr;

	if (bitindex > 0)
	{
		lcode <<= (32 - bitindex);
		count = (bitindex + 7) >> 3;

		ptr = (UINT8 *) &lcode + 3;

		for (i=count; i>0; i--)
		{
			if ((outputBuffer[k++] = *ptr--) == 0xff)
				outputBuffer[k++] = 0;
		}
	}

	// End of image marker
	//outputBuffer[k++] = 0xFF;
	//outputBuffer[k++] = 0xD9;
	return k;
}
