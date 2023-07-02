from math import *
import json


def do_nothing_3_parameters(a, b, c):
    pass


def mark_squares(sieve, r, limit):
    for i in range(r * r, limit + 1, r * r):
        sieve[i] = False


def do_nothing_2_parameters(a, b):
    pass


def add_to_primes(x, primes):
    primes.append(x)


def find_primes(limit):
    sieve = [False] * (limit + 1)
    xor_with_1 = [False] * 12
    xor_with_1[1] = True
    xor_with_1[5] = True
    xor_with_2 = [False] * 12
    xor_with_2[7] = True
    xor_with_3 = [False] * 12
    xor_with_3[11] = True
    for x in range(1, int(sqrt(limit)) + 1):
        for y in range(1, int(sqrt(max(0, limit - 4 * x * x))) + 1):
            n = 4 * x * x + y * y
            sieve[n] ^= xor_with_1[n % 12]
        for y in range(1, int(sqrt(max(0, limit - 3 * x * x))) + 1):
            n = 3 * x * x + y * y
            sieve[n] ^= xor_with_2[n % 12]
        for y in range(x - 1, ceil(sqrt(max(1, min(3 * x * x - limit, x * x)))) - 1, -1):
            n = 3 * x * x - y * y
            sieve[n] ^= xor_with_3[n % 12]
    do = {False: do_nothing_3_parameters, True: mark_squares}
    for r in range(5, int(sqrt(limit)) + 1):
        do[sieve[r]](sieve, r, limit)
    primes = [2, 3]
    sieve[2] = True
    sieve[3] = True
    do = {False: do_nothing_2_parameters, True: add_to_primes}
    for i in range(5, limit + 1):
        do[sieve[i]](i, primes)
    return primes, sieve


def exists_value_between(arr, a, b):  # binary search for efficency
    low = 0
    high = len(arr) - 1
    res = False
    while low <= high and not res:
        mid = (low + high) // 2
        new_low_val = {False: low, True: mid + 1}
        low = new_low_val[arr[mid] < a]
        new_high_val = {False: high, True: mid - 1}
        high = new_high_val[arr[mid] > b]
        new_res_val = {False: res, True: True}
        res = new_res_val[arr[mid] >= a and arr[mid] <= b]
    return res


def return_false_3_parameters(a, b, c):
    return False


config_file = open("configuration.json", "r")
configuration = json.load(config_file)
limit = configuration["limit"]
dividedBy = configuration["DividedBy"]
dividing = configuration["Dividing"]
next_primes = configuration["Primes"]["NextMultiples"]
primes_text = configuration["Primes"]["Text"]

limit_find_primes = 100
for p in next_primes:
    limit_find_primes = max(limit_find_primes, limit + p - limit % p)

dividedByRemainders = {}

for text, num in dividedBy.items():
    cur = [""] * num
    cur[0] = text
    dividedByRemainders[num] = cur

dividingRemainders = {}

for text, num in dividing.items():
    cur = [""] * num
    cur[0] = text
    dividingRemainders[num] = cur

prime_text = {False: {False: "", True: ""}, True: {False: primes_text, True: ""}}
primes, is_prime = find_primes(limit_find_primes)
for num in range(1, limit + 1):
    text = ""
    for mod, remainders in dividedByRemainders.items():
        text += remainders[num % mod]
    for mod, remainders in dividingRemainders.items():
        text += remainders[mod % num]
    max_next_multiple = num
    for p in next_primes:
        max_next_multiple = max(max_next_multiple, num + p - num % p)
    second_parameter = {False: return_false_3_parameters, True: exists_value_between}[is_prime[num]](primes, num + 1,
                                                                                                     max_next_multiple)
    text += prime_text[is_prime[num]][exists_value_between(primes, num + 1, max_next_multiple)]
    print(num, text)  # TODO fix
