package main

import "fmt"
import "math"

func main() {
    var array = []int{1, 2, 3}
    fmt.Println(arrayMinimum(array, math.MaxInt32))
}

func arrayMinimum(minArray []int, minimumNumber int) int {
    minArrayLength := len(minArray)
    smallestNumber := minimumNumber
    if minArrayLength == 0 {
        return minimumNumber
    } else if minArray[0] < smallestNumber {
        smallestNumber = minArray[0]
    }
    return arrayMinimum(minArray[1:], smallestNumber)
}
