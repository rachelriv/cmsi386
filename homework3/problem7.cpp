#include <iostream>
#include <algorithm>
using namespace std;
// Generics from http://en.wikipedia.org/wiki/Template_(C%2B%2B)
// Array decay prevention from http://stackoverflow.com/questions/1863751/array-decay-to-pointers-in-templates
// Returned pointer needs to be free'd after use. 
template <typename T, int U, int V>
T *interleave(const T (&array1)[U], const T (&array2)[V]) {
    T *returnArray = (T*) malloc(sizeof(T) * (U + V));
    int returnArrayIndex = 0;
    for (int i = 0; i < max(U, V); i++) {
        if (i < U) {
           returnArray[returnArrayIndex] = array1[i]; 
           returnArrayIndex++;
        }
        if (i < V) {
           returnArray[returnArrayIndex] = array2[i]; 
           returnArrayIndex++;
        }
    }
    return returnArray;
}

int main() {
    int arr1[] = {1, 2};
    int arr2[] = {4, 5, 6};
    int *arr3 = interleave(arr1, arr2);
    cout << "[" << arr3[0];
    for (int i = 1; i < 5; i++) {
        cout << "," << arr3[i];
    }
    cout << "]" << endl;
    free(arr3);
}
