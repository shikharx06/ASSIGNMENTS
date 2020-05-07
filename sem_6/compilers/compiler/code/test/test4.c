#include <stdio.h>
void main()
{
    //data type
    int a,b;
    float ;  //syntax error
    double d; // syntax error
    char c;
    //c=a;

    // I/O statements
    scanf("%d"a);   //syntax error
    printf("d",);  //syntax error

    //assignment operations
    c=a+b;

    // conditional statement
    if(a>b)
    {
        printf("%d",a);
        printf("Meow");
    }
    else 
    {
        printf("Meow2");
        printf("Meow3");
    }

    switch(a)    //syntax error
    {
        case 1:printf("one");
        break;
    }

    //array declaration and definition
    int arr[a][b]= {1,2,3,4,5,6};       //syntax error
    float arr[a][b];                   //syntax error

    //loop statements
    while(               //syntax error
    {
        printf("Infinite");
    }
    
     
    for(int i= i<10; i--)    //syntax error
    {
        a=i;
        b=a+i;
    }
}