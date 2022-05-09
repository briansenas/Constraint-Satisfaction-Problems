import numpy as np
import sys

def randomgraph(N,M,seed):
    print("% semilla =", seed)
    print("NUM_NODOS =", N, ";")
    print("NUM_ARISTAS =", M,";")
    print("aristas =\n[|", end='')

    np.random.seed(seed)
    for i in range(M):
        n1 = np.random.randint(0,N)+1
        n2 = np.random.randint(0,N)+1

        while n1 == n2:
            n2 = np.random.randint(0,N)+1

        if n1<10:
            print(" {} , ".format(n1), end='')
        else:
            print(" {}, ".format(n1), end='')
        if n2<10:
            print("{} ".format(n2),end='')
        else:
            print("{}".format(n2),end='')
        if((i+1) % 5 == 0 and i > 0 and i!=M-1):
            print("\n",end='')
        print(" |",end='')

    print("];");
    print("");


if(len(sys.argv) <= 1):
    N = int(input("Inserte el número de Nodos N:"))
    M = int(input("Inserte el número de Nodos M:"))
    seed = int(input("Inserte la semilla a utilizar:"))
else:
    N = int(sys.argv[1])
    M = int(sys.argv[2])
    seed = int(sys.argv[3])

randomgraph(N,M,seed)
