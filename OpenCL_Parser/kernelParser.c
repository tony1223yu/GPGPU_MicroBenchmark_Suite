#include <stdio.h>
#include <stdlib.h>
extern int  yyparse();
extern FILE *yyin;

int main(int argc, char *argv[])
{
    if(argc<2)
    {
        printf("Please select an input file\n");
        exit(0);
    }
    FILE *fp=fopen(argv[1],"r");
    if(!fp)
    {
        printf("couldn't open file for reading\n");
        exit(0);
    }

    yyin=fp;
    yyparse();
    fclose(fp);
}
