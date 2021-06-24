#include <stdio.h>
int main()
{
    int i, j, k, x, y;
    float matriz[3][4], recu[1][4], incog[3], aux0, aux1, aux2, ayuda;
    matriz[0][0] = 2;
    matriz[0][1] = -1;
    matriz[0][2] = 1;
    matriz[0][3] = 0;
    matriz[1][0] = 1;
    matriz[1][1] = 2;
    matriz[1][2] = -2;
    matriz[1][3] = 5;
    matriz[2][0] = 3;
    matriz[2][1] = -4;
    matriz[2][2] = -3;
    matriz[2][3] = -5;
    for(i=0;i<3-1;i++)
    {
        aux1 = matriz[i][i];
        for(j=i+1;j<3;j++)
        {
            aux2 = matriz[j][i];
            for(k=i;k<3+1;k++)
            {
                aux0 = matriz[i][k];
                recu[0][k] = aux0;
                aux0 = aux0*aux2*(-1);
                matriz[i][k] = aux0;
                aux0 = matriz[j][k];
                aux0 = aux0*aux1*1;
                matriz[j][k] = aux0;
            }
            for(y=0;y<3+1;y++)
            {
                aux0 = matriz[i][y] + matriz[j][y];
                matriz[j][y] = aux0;
            }
            for(x=i;x<3+1;x++)
            {
                aux0 = recu[0][x];
                matriz[i][x] = aux0;
            }
        }
    }
    k=1;
    x=0;
    for(i=3-1;i>=0;i--)
    {
        aux0 = matriz[i][i];
        aux1 = matriz[i][i+k];
        if(k==1)
        {
            aux2 = aux1/aux0;
            incog[x] = aux2;
            for(j=3-1;j>=0;j--)
            {
                ayuda = matriz[j][3-k];
                ayuda = ayuda*aux2;
                matriz[j][3-k] = ayuda;
            }
            k++;
            x++;
        }
        else
        {
            for(y=i+1;y<3;y++)
            {
                ayuda = matriz[i][y];
                aux1 = aux1-ayuda;
            }
            aux2 = aux1/aux0;
            incog[x] = aux2;
            for(j=i;j>=0;j--)
            {
                ayuda = matriz[j][3-k];
                ayuda = ayuda*aux2;
                matriz[j][3-k] = ayuda;
            }
            k++;
            x++;
        }
    }
    return 0;
}
