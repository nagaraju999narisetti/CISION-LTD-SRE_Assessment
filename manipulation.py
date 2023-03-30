#!/usr/bin/python

with open("numbers.txt", "r") as f:
    numbers = f.read().split()
    even_numbers = [int(n) for n in numbers if int(n) % 2 == 0]

with open("even_numbers.txt", "w") as f:
    f.write(" ".join(str(n) for n in even_numbers))
