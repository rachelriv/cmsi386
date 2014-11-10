#include <iostream>
#include <stdlib.h>
using namespace std;

int* interleave(int a[], size_t asize, int b[], size_t bsize) {
    int* result = (int *) malloc((asize + bsize) * sizeof(int));
    int n = asize > bsize ? asize : bsize;
    for (int k = 0, i = 0; i < n; i++) {
        if (i < asize) result[k++] = a[i];
        if (i < bsize) result[k++] = b[i];
    }
    return result;
}

int main() {
    int arr1[] = {1, 2};
    int arr2[] = {4, 5, 6};
    size_t x = 2;
    size_t y = 3;
    int* result = (int *) malloc(5 * sizeof(int));
    result = interleave(arr1, x, arr2, y);
    for (int i = 0; i < 5; i++){
        cout << result[i];
    }
}