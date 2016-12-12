/*
 * kinematics.hpp
 * 
 *  Created on: Sep. 10 2013
 *			Author: Amir Yazdanbakhsh <yazdanbakhsh@wisc.edu>
 */



extern float l1 ;
extern float l2 ;

void forwardk2j(float theta[], int position);
void inversek2j(float x, float y, float theta[], int position);

