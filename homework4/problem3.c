#include <stddef.h>
#include <stdio.h>
#include <limits.h>

int array_minimum(int* minArray, size_t arrayLength, int minimumNumber) {
    int lowNumber = minimumNumber;
    if (arrayLength == 0) {
        return minimumNumber;
    } else if (minArray[arrayLength - 1] < minimumNumber){
        lowNumber = minArray[arrayLength - 1];
    }
    return array_minimum(minArray, arrayLength - 1, lowNumber);
}

int main() {
    int array[3] = {1, 2, 3};
    printf("%d\n", array_minimum(array, 3, INT_MAX)); // prints 1
}
