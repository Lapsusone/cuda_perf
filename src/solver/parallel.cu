#include <iostream>
#include <stdlib.h>

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include "parallel.cuh"

using std::cout;
using std::flush;
using std::endl;

__global__ void plus100Kernel(int *input, int* output)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < 100)
    {
        output[i] = input[i] + 100;
    }
}

void plus100(int n_block, int n_thread)
{
    int *d_input = 0;
    int *d_output = 0;
    cudaMalloc((void**)&d_input, 100 * sizeof(int));
    cudaMalloc((void**)&d_output, 100 * sizeof(int));
 
    srand(time(NULL)); 

    int* matrice = (int*)malloc(sizeof(int) * 100); 

    for(int i = 0; i < 100; i++)
    {
        matrice[i] = rand() % 100;
    }

    // Copier vers le dispositif
    cudaMemcpy(d_input, matrice, 100 * sizeof(int), cudaMemcpyHostToDevice);

    // Appeler le kernel avec 100 blocs
    plus100Kernel<<<n_block, n_thread>>>(d_input, d_output);

    // Attendre que le kernel ait fini, puis copier vers l'hôte
    cudaDeviceSynchronize();
    cudaMemcpy(matrice, d_output, 100 * sizeof(int), cudaMemcpyDeviceToHost);

    for(int i = 0; i < 100; i++)
    {
        printf("%d\n", matrice[i]);
    }
} 

