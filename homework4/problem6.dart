#!/usr/bin/env dart
import 'dart:io';

void main() {
    left() => stdout.write('left');
    to() => stdout.write(' to ');
    right() => stdout.write('right');
    consumer(left, to, right) => print(''); /* prints 'left to right' */
    consumer(left(), to(), right());
}
