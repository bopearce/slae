// decrypter.c SLAE-1194
// Bo Pearce
#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <string.h>
#include <stdio.h>

int decrypt(unsigned char *ciphertext, int ciphertext_len, unsigned char *key, unsigned char *plaintext)
{
  EVP_CIPHER_CTX *ctx;
  int len;
  int plaintext_len;

  /* Create and initialise the context */
  if(!(ctx = EVP_CIPHER_CTX_new()))
      printf("error EVP_CIPHER_CTX_new()\n");

  if(1 != EVP_DecryptInit_ex(ctx, EVP_rc4(), NULL, key, NULL))
      printf("error EVP_DecryptInit_ex()\n");

  if(1 != EVP_DecryptUpdate(ctx, plaintext, &len, ciphertext, ciphertext_len))
      printf("error EVP_DecryptUpdate()\n");
  plaintext_len = len;

  if(1 != EVP_DecryptFinal_ex(ctx, plaintext + len, &len)) 
      printf("error EVP_DecryptFinal()\n");
  plaintext_len += len;

  //clean up
  EVP_CIPHER_CTX_free(ctx);
  return plaintext_len;
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
  unsigned char *ciphertext = (unsigned char *)"\xE2\x1C\xE9\xB5\xE8\xED\x78\x54\xAB\xD1\x51\x76\x6D\xA3\x9A\x4C\x57\x56\x3A\xBC\xCD\x7F\xA5\x31\x47\xBE\xD9\x53\x20\x31\xF4\x2B\xA2\xDD\xDB\xC7\x41\x2A\x95";
  unsigned char decryptedtext[256];

  int decryptedtext_len;

  /* Decrypt the ciphertext */
  decryptedtext_len = decrypt(ciphertext, strlen(ciphertext), key, decryptedtext);

  //decryptedtext[decryptedtext_len] = '\0';
  printf("Decrypted text:\n");
  //printf("%s", decryptedtext);
  printHex(decryptedtext, decryptedtext_len);

 //int (*ret)() = (int(*)())decryptedtext;

 //ret();
}
