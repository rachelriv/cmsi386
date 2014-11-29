// From http://blog.golang.org/gos-declaration-syntax and https://golang.org/ref/spec
func main() {
    a [n](*float64)
    a *([n]float64)
    a [n](func() float64)
    a func() []float64
}
