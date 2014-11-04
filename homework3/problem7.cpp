#include <iostream>
#include <algorithm>
using namespace std;
// Are we allowed to #import <array> ?
// Generics from http://en.wikipedia.org/wiki/Template_(C%2B%2B)
// Array decay prevention from http://stackoverflow.com/questions/1863751/array-decay-to-pointers-in-templates
template <typename T, int U, int V>
T (&interleave(const T (&array1)[U], const T (&array2)[V]))[U + V] {
    int sizeT = sizeof(T);
    int sizeArray1 = sizeof(array1) / sizeT;
    int sizeArray2 = sizeof(array2) / sizeT;
    T *returnArray = new T[sizeArray1 + sizeArray2];
    int returnArrayIndex = 0;
    for (int i = 0; i < max(sizeArray1, sizeArray2); i++) {
        if (i < sizeArray1) {
           returnArray[returnArrayIndex] = array1[i]; 
           returnArrayIndex++;
        }
        if (i < sizeArray2) {
           returnArray[returnArrayIndex] = array2[i]; 
           returnArrayIndex++;
        }
    }
    return returnArray;
}

int main() {
    int arr1[] = {1, 2};
    int arr2[] = {4, 5, 6};
    int arr3[] = interleave(arr1, arr2);
    cout << "[" << arr3[0];
    for (int i = 0; i < sizeof(arr3) / sizeof(int); i++) {
        cout << "," << arr3[i];
    }
    cout << "]" << endl;
}
