from math import *
import json

INF = 1e9


def do_nothing(*args):
    """Does nothing

    :param Any args: the arguments"""
    pass


def mark_squares(sieve, r, limit):
    """Sets all the multiplies of the square of r as 0 in the sieve

    :param list[int] sieve: The sieve to change
    :param int r: The number to mark its square multiplies
    :param int limit: The maximum number to change"""
    for i in range(r * r, limit + 1, r * r):
        sieve[i] = 0


def add_to_list(x, arr):
    """Adds a variable to a list

    :param Any x: The variable to add
    :param list arr: The list
    """
    arr.append(x)


def find_primes(limit):
    """Returns all the primes until limit using the Sieve of Atkin

    :param int limit: The number to return primes up to
    :return: A tuple of 2 lists - the list of prime numbers and a list that includes for each number up to limit whether it is prime
    :rtype: tuple[list[int], list[int]]
    """
    sieve = [0] * (limit + 1)
    xor_with_1 = [0] * 12
    xor_with_1[1] = 1
    xor_with_1[5] = 1
    xor_with_2 = [0] * 12
    xor_with_2[7] = 1
    xor_with_3 = [0] * 12
    xor_with_3[11] = 1
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
    do = [do_nothing, mark_squares]
    for r in range(5, int(sqrt(limit)) + 1):
        do[sieve[r]](sieve, r, limit)
    primes = [2, 3]
    sieve[2] = 1
    sieve[3] = 1
    do = [do_nothing, add_to_list]
    for i in range(5, limit + 1):
        do[sieve[i]](i, primes)
    return primes, sieve


def is_non_negative(x):
    """Returns 0 if the number is negative and 1 otherwise

    :param x: The number to check
    :return: 0 if the number is negative, 1 otherwise
    """
    return (x // (abs(x) + 1)) + 1


def exists_value_between(arr, a, b):
    """Checks if a sorted list contains a number between a and b (inclusive)

    :param list[int] arr: The list to check. must be sorted.
    :param int a: The lower bound of the range
    :param int b: The upper bound of the range
    :return: 0 if there is no number between a and b in arr, 1 otherwise.
    """
    low = 0
    high = len(arr) - 1
    res = 0
    while low <= high and not res:
        mid = (low + high) // 2
        new_low_val = [mid + 1, low]
        new_high_val = [mid - 1, high]
        mid_after_a = is_non_negative(arr[mid] - a)
        mid_before_b = is_non_negative(b - arr[mid])
        low = new_low_val[mid_after_a]
        high = new_high_val[mid_before_b]
        new_res_val = [res, res, 1]
        res = new_res_val[mid_after_a + mid_before_b]
    return res


def return_0(*args):
    """Returns 0

    :param Any args: the parameters
    :returns: 0
    :rtype: int"""
    return 0


config_file = open("configuration.json", "r")
configuration = json.load(config_file)
limit = configuration["limit"]
dividedBy = configuration["DividedBy"]
dividing = configuration["Dividing"]
next_primes = configuration["Primes"]["NextMultiples"]
primes_text = configuration["Primes"]["Text"]

limit_find_primes = INF
for p in next_primes:
    limit_find_primes = min(limit_find_primes, limit + p - limit % p)

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

prime_text = [["", ""], [primes_text, ""]]
primes, is_prime = find_primes(limit_find_primes)
for num in range(1, limit + 1):
    text = ""
    for mod, remainders in dividedByRemainders.items():
        text += remainders[num % mod]
    for mod, remainders in dividingRemainders.items():
        text += remainders[mod % num]
    max_next_multiple = INF
    for p in next_primes:
        max_next_multiple = min(max_next_multiple, num + p - num % p)
    second_parameter = [return_0, exists_value_between][is_prime[num]](primes, num + 1,
                                                                       max_next_multiple - 1)
    text += prime_text[is_prime[num]][second_parameter]
    output = [num] + [text] * len(text)
    print(output[len(text)], num)
