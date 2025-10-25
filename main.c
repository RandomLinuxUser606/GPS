#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

// Por RandomLinuxUser606

int main(void)
{
  // Declarando variaveis
  char buff[20];
  char resp;
  int pacote;
  char command[50];
  char caminho[] = "/bin/";


  // menu
  printf("pakman - v0.1\n");
  printf("[I]nstalar\n");
  printf("[R]emover\n");

  resp = getchar();

  if (resp == 'I')
  {
    printf("escreva o nome do pacote desejado:\n");
    scanf("%20s", buff);
    FILE* f = fopen("pacote.txt", "w");
    fprintf(f, "%s\n", buff);
    fclose(f);
    strcpy(command, "bash verificar.sh");
    system(command);
    return 0;
  }

  if (resp == 'R') {
    printf("Escreva o nome do pacote para ser removido:\n");
    scanf("%20s", buff);
    strcat(caminho, buff);
    if (remove(caminho) == 0) {
        printf("'%s' deleted.\n", caminho);
        printf("'%s' deleted.\n", buff);
        system("bash remove.sh");
    } else {
        perror("Error:");
    }
  }
}
