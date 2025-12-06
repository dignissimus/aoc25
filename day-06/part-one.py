import sys
import operator
import functools

lines = sys.stdin.readlines()
*problem_lines, operator_line = lines
problems = []
for line in problem_lines:
    number_strings = line.split()
    numbers = [int(number_string) for number_string in number_strings]
    problems.append(numbers)

problems = zip(*problems)

operator_lookup = {
    "+": operator.add,
    "-": operator.sub,
    "/": operator.truediv,
    "*": operator.mul
}

operator_strings = operator_line.split()
operators = [operator_lookup[operator_string] for operator_string in operator_strings]

total_sum = 0
for operator, problem in zip(operators, problems):
    result = functools.reduce(operator, problem)
    total_sum += result

print("Result", total_sum)
