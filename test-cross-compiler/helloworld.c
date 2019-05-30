#include <stdio.h>

#include <stdlib.h>
#include <string.h> 
#include "lifting.h"

struct PTRs {
	int inpbuf[65536];
	 
	int flag;
	int w;
	int h;
	 
	 int *red;
	
	 int *grn;
	 int *blu;
	 int *alt;
	//int *fwd_inv;
} ptrs;

void split(int ff, int loop, int *ibuf,  int *obuf) {
        
    int	*ip = ibuf;
     int *op = obuf;
    int i,sp,x,y,z;
	for(i=0;i<loop;i++) {
		x = *ip;
		if (ff == 0) y = 0x1ff00000;
		if (ff == 1) y = 0x7fc00;
		if (ff == 2) y = 0x1ff;
		z = x & y;
		printf("x = 0x%x z = 0x%x y = 0x%x \n",x,z,y);
		if (ff == 0) sp = z>>20;
		if (ff == 1) sp = z>>8;
		if (ff == 2) sp = z;
		*op = sp;
		if (i <= 3) printf("x = 0x%x sp = 0x%x z = 0x%x\n",x,sp,z);
		if (i > 65532) printf("x = 0x%x sp = 0x%x z = 0x%x\n",x,sp,z);
		ip++;
		op++;
	}
		
}	


int main() {
	int *buf_red;
	int *fwd_inv;
	int i;
	
	FILE *inptr,*outptr;
	
	printf("helloworld\n");
	ptrs.w = 256;
	ptrs.h = 256;
	printf("x = %d y = %d \n",ptrs.w,ptrs.h);
	buf_red = ( int *)malloc(sizeof( int)* ptrs.w*ptrs.h*2);
	fwd_inv = (int *)malloc(1);
	
	printf("buf_red = 0x%x\n",buf_red);
	
	inptr = fopen("rgb_pack.bin","rb");
    if (!inptr)
	{
		printf("Unle to open file!");
		return 1;
	}
	else fread(ptrs.inpbuf,sizeof(int),65536,inptr);
 
	fclose(inptr);
	
	i = 65535;
	split(ptrs.flag, i, ptrs.inpbuf,buf_red);
}
