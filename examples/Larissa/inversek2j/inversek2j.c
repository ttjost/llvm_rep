/*
 * inversek2j.cpp
 * 
 *  Created on: Sep. 10 2013
 *			Author: Amir Yazdanbakhsh <yazdanbakhsh@wisc.edu>
 */

#include <stdio.h>
#include <string.h>
#include "kinematics.h"
#include "data.h"
#define PI 3.141592653589
char inputFileName[32], outputFileName[32], string[64];
float t1t2xy[9 * 2 * 2]; 

int main(int argc, const char* argv[])
{

	int n, i, j, curr_index1;

	FILE *outputfile;


	strcpy(outputFileName, argv[1]);

	// prepare the output file for writting the theta values
	outputfile = fopen(outputFileName, "w");

	// first line defins the number of enteries
	n = entry_number;



	// start
	curr_index1 = 0;
	j = 0;		
	for(i = 0 ; i < n * 2 * 2 ; i += 2*2)
	{
		t1t2xy[i] = theta1[j];
		t1t2xy[i + 1] = theta2[j];

		forwardk2j(t1t2xy, i);
		j++;
	}


	for(i = 0 ; i < n * 2 * 2 ; i += 2 * 2)
	{
		inversek2j(t1t2xy[i + 2], t1t2xy[i + 3], t1t2xy, i);
		//fprintf(outputfile, "%f\n", t1t2xy[i]);
	}


	for(i = 0 ; i < n * 2 * 2 ; i += 2 * 2)
	{

		fprintf(outputfile, "%f\n", t1t2xy[i]);

		//fprintf(outputfile, "%d => %f\n", i+1, t1t2xy[i+1]);
	}

	fclose(outputfile);

	return 0 ;
}
