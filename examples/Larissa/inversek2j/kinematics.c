/*
 * kinematics.cpp
 * 
 *  Created on: Sep. 10 2013
 *			Author: Amir Yazdanbakhsh <yazdanbakhsh@wisc.edu>
 */

#include "kinematics.h"
//#include <stdio.h>
//#include <math.h>

float l1 = 0.5 ;
float l2 = 0.5 ;



double poww(double x, int y){
	if (y == 0) return 1;
	int i;
	double result = x;
	for(i=1;i<y;i++){
		result = result * x;
	}
	return result;
}



double fat(long int x){

	int i;
	double result = 1.0f;
	for(i=0;i<x;i++){
		result = result * (x-i); 
	}

	return result;
}




double cosx(double x){
	int r = 30;
	int i;
	double cos = 0.0f;
	for(i=0;i<=r;i++){
		cos = cos + (poww(-1,i)*poww(x,2*i))/(fat(2*i));
	}

	return cos;
}




double sinx(double x){
	int r = 30;
	int i;
	float sin = 0.0f;
	for(i=0;i<=r;i++){
		sin = sin + (poww(-1,i)*poww(x,2*i+1))/(fat(2*i+1));
	}

	return sin;
}



double acosx(double x){
	int r = 30;
	int i;
	double acos = 0.0f;
	for(i=1;i<=r;i++){
		acos = acos + (poww(0.5, i-1)/(fat(i-1)*(2*i-1)))*poww(x, 2*i-1);
	}

	acos = 3.14159265359*0.5 - acos;

	return acos;
}



double asinx(double x){
	int r = 30;
	int i;
	double asin = 0.0f;
	for(i=0;i<=r;i++){
		//asin = asin + poww(0.5, i)/((2*i+1)*fat(i))*poww(x,2*i+1);
		asin = asin + (fat(2*i)/(poww(2,2*i)*poww(fat(i),2)))*(poww(x,2*i+1)/(2*i+1));
	} 

	return asin;
}



void forwardk2j(float theta[], int position) {
	theta[position + 2] = l1 * cosx(theta[position]) + l2 * cosx(theta[position] + theta[position + 1]);
	theta[position + 3] = l1 * sinx(theta[position]) + l2 * sinx(theta[position] + theta[position + 1]);
}

void inversek2j(float x, float y, float theta[], int position) {

	double dataIn[2];
	double dataOut[2];
	dataIn[0] = x;
	dataIn[1] = y;

#pragma parrot(input, "inversek2j", [2]dataIn)

	theta[position + 1] = (float)acosx(((x * x) + (y * y) - (l1 * l1) - (l2 * l2))/(2 * l1 * l2));
	theta[position] = (float)asinx((y * (l1 + l2 * cosx(theta[position + 1])) - x * l2 * sinx(theta[position + 1]))/(x * x + y * y));

	dataOut[0] = theta[position];
	dataOut[1] = theta[position + 1];

#pragma parrot(output, "inversek2j", [2]<0.0; 2.0>dataOut)


	theta[position] = dataOut[0];
	theta[position + 1] = dataOut[1];
}
