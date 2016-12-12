/*
** TestADPCM - Test adpcm coder and decoder against reference samples.
** It reads pcm refrence samples runs the coder on them and checks if 
** the smaples were compressed correctly by comparing them with adpcm 
** reference samples.
**
** Then it reads adpcm reference samples runs the decoder on them to
** check if they were decoded correctly. This is done by comparing them
** with 
** pcm reference samples.
*/

#ifdef C
#include <stdio.h>
#else
#include "printf.h"
#endif

#define DATASIZE 10 	/* Data block size: 10 samples */

/* Swap bytes in 16 bit value.  */
#define __bswap_constant_16(x) \
     ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8))


short pcmdata[DATASIZE] = {0, 0, 16, 16, 16, 24, 24, 24, 32, 32};
char adpcmdata[DATASIZE/2];
short pcmdata_2[DATASIZE];

char adpcmdata_ref[DATASIZE/2] = {0, 0x71, 0x82, 0x0, 0x38};
short pcmdata_2_ref[DATASIZE] = {0, 0, 11, 17, 16, 23, 24, 25, 33, 32};


struct adpcm_state {
    short valprev;	/* Previous output value */
    char index;		/* Index into stepsize table */
};

/* Intel ADPCM step variation table */
static int indexTable[16] = {
    -1, -1, -1, -1, 2, 4, 6, 8,
    -1, -1, -1, -1, 2, 4, 6, 8,
};

static int stepsizeTable[89] = {
    7, 8, 9, 10, 11, 12, 13, 14, 16, 17,
    19, 21, 23, 25, 28, 31, 34, 37, 41, 45,
    50, 55, 60, 66, 73, 80, 88, 97, 107, 118,
    130, 143, 157, 173, 190, 209, 230, 253, 279, 307,
    337, 371, 408, 449, 494, 544, 598, 658, 724, 796,
    876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066,
    2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358,
    5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899,
    15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767
};


struct adpcm_state coder_state, decoder_state;


void adpcm_decoder(char indata[], short outdata[], int len, struct adpcm_state *state)
{
    signed char *inp;	/* Input buffer pointer */
    short *outp;	/* output buffer pointer */
                        /* int sign;Current adpcm sign bit */
    int delta;		/* Current adpcm output value */
    int step;		/* Stepsize */
    int valpred;	/* Next predicted value */
    int vpdiff;		/* Current change to valpred */
    int index;		/* Current step change index */
    int inputbuffer;	/* place to keep next 4-bit value */
    int bufferstep;	/* toggle between inputbuffer/input */

    outp = outdata;
    inp = (signed char *)indata;

    valpred = state->valprev;	 /** restore previous values of the prdeicted sample and quantizer step size index**/
    index = state->index;
    step = stepsizeTable[index]; /** find quantizer step size from table lookup using quantizer step size index**/

    bufferstep = 0;
    
    for ( ; len > 0 ; len-- ) {
		/* Step 1 - get the delta value */
		if ( bufferstep ) {
		    delta = inputbuffer & 0xf;
		} else {
		    inputbuffer = *inp++;
		    delta = (inputbuffer >> 4) & 0xf;
		}
		bufferstep = !bufferstep;
		
		//printf("i: %d, v: %d  ", index, valpred);
		
		/* Step 2 - Compute difference and new predicted value */
		/** Computes 'vpdiff = (delta+0.5)*step/4', but see comment in adpcm_coder.*/
		/** inverse quantize the ADPCM code into a predicted difference using the quantizer step size**/
		vpdiff = step >> 3;
		if ( delta & 4 ) vpdiff += step;
		if ( delta & 2 ) vpdiff += step>>1;
		if ( delta & 1 ) vpdiff += step>>2;
		/** Step 3 predictor computes new predicted sample by adding old predicted sample to predicted difference**/
                if (delta & 8){
		  valpred -= vpdiff;
                }
		else {
		  valpred += vpdiff;
                }	
		/* Step 4 - clamp output value */
		if ( valpred > 32767 )
		  valpred = 32767;
		else if ( valpred < -32768 )
		  valpred = -32768;
                /* Step 5 - Find new index value  */
		index += indexTable[delta];
		if ( index < 0 ) index = 0;
		if ( index > 88 ) index = 88;
	
		/* Step 6 - Update step value */
		step = stepsizeTable[index];
		
		//printf("%d -> decoder -> %d\n", (int)delta, (int)valpred);

		/* Step 7 - Output value */
		*outp++ = valpred;
    }

    state->valprev = valpred;
    state->index = index;
}
