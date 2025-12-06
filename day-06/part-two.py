import sys
import operator
import functools

lines = sys.stdin.readlines()
*problem_lines, operator_line = lines
problems = []
for line in problem_lines:
    # TODO: Problem here is that I lose alignment information
    # I assumed that they were all right/left aligned
    # Instead, the alignment changes
    # so e.g.
    # 64   21 32
    # 645 445 221
    # Here, we see both left and right alignment
    number_strings = line.split()
    numbers = [number_string for number_string in number_strings]
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

def align_numbers(numbers):
    positions = []
    for number in numbers:
        reversed_number = number[::-1]
        for index, character in enumerate(number):
            has_enough_positions = index < len(positions)
            if not has_enough_positions:
                positions.append([])
            # TODO: Here is where I use the assumption that the numbers are all right aligned
            positions[index].append(reversed_number[index])

    number_strings = [''.join(position) for position in positions]
    aligned_numbers = [int(number_string) for number_string in number_strings]
    return aligned_numbers

total_sum = 0
for operator, problem in zip(operators, problems):
    aligned_problem = align_numbers(problem)
    result = functools.reduce(operator, aligned_problem)
    print(problem, '->', aligned_problem, '->' ,result)
    total_sum += result

print("Result", total_sum)
