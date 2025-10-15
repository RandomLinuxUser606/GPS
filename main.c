#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>



int main(void)
{
  // Declarando variaveis
  char buff[20];
  char resp;
  int pacote;
  char command[50];

  printf("pakman - teste 1\n");
  printf("[I]nstalar\n");
  printf("[R]emover\n");
  printf("[A]tualizar\n");

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





}
