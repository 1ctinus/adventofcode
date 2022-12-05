#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void)
{
	FILE *stream;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
  int output = 0;
	stream = fopen("4.txt", "r");
	if (stream == NULL)
		exit(EXIT_FAILURE);
  int start1; int start2;
    int start3; int start4;
	while ((read = getline(&line, &len, stream)) != -1) {
    //int numlength = (read-4)/4;
    int commapos = 0;
    int hyphenpos1 = 0;
    int hyphenpos2 = 0;
    for(int i = 0; i < read; i++){
    if(line[i] == '-'){
    if(hyphenpos1 == 0){
    hyphenpos1 = i;
    } else {
    hyphenpos2 = i;
    }
    } else if(line[i] == ',') {
    commapos = i;
    }
    }
    char* temp1 = malloc(hyphenpos1 + 1);
    char* temp2 = malloc(commapos - hyphenpos1 + 1);
    char* temp3 = malloc(hyphenpos2 - commapos + 1);
    char* temp4 = malloc(read - hyphenpos2 + 1);
    memcpy( temp1, &line[0], hyphenpos1  );
    memcpy( temp2, &line[hyphenpos1 + 1], commapos - hyphenpos1 );
    memcpy( temp3, &line[commapos + 1], hyphenpos2 - commapos);
    memcpy( temp4, &line[hyphenpos2 + 1], read - hyphenpos2);
    temp1[hyphenpos1 + 1] = '\0';
    temp2[commapos - hyphenpos1 + 1] = '\0';
    temp3[hyphenpos2 - commapos + 1] = '\0';
    temp4[read - hyphenpos2 + 1] = '\0';
    start1 = strtol(temp1, NULL, 10);
start2 = strtol(temp2, NULL, 10);
start3 = strtol(temp3, NULL, 10);
start4 = strtol(temp4, NULL, 10);
printf("%d,%d,%d,%d\n", start1, start2, start3, start4);
    if((start2 >= start3) && (start1 <= start4)){
      output += 1;
    }
  }
	free(line);
	fclose(stream);
  printf("%i", output);
	exit(EXIT_SUCCESS);
}
