def make_odd_generator():
    x = [-1]

    def next_odd():
        x[0] += 2
        return x[0]
    return next_odd
