class Quadruple:
    def __init__(self, op, arg1, arg2, res):
        self.op, self.arg1, self.arg2, self.res = op, arg1, arg2, res

    def __str__(self):
        return f"{self.op}\t{self.arg1}\t{self.arg2}\t{self.res}"

def get_input():
    n = int(input("Enter number of quadruples: "))
    quads = []
    for _ in range(n):
        op = input("Operator: ")
        arg1 = input("Arg1: ")
        arg2 = input("Arg2: ")
        res = input("Result: ")
        quads.append(Quadruple(op, arg1, arg2, res))
    return quads

def constant_folding(quads):
    for q in quads:
        if q.arg1.isdigit() and q.arg2.isdigit():
            a, b = int(q.arg1), int(q.arg2)
            result = {
                '+': a + b, '-': a - b,
                '*': a * b, '/': a // b if b else 0
            }.get(q.op)
            q.op, q.arg1, q.arg2 = '=', str(result), ''
    return quads

def strength_reduction(quads):
    new_quads = []
    for q in quads:
        if q.op == '*' and q.arg2.isdigit():
            n = int(q.arg2)
            if n > 0 and (n & (n - 1)) == 0:  # Power of 2
                shift = n.bit_length() - 1
                q.op, q.arg2 = '<<', str(shift)
        elif q.op == '/' and q.arg2.isdigit():
            n = int(q.arg2)
            if n > 0 and (n & (n - 1)) == 0:
                shift = n.bit_length() - 1
                q.op, q.arg2 = '>>', str(shift)
        new_quads.append(q)
    return new_quads

def display(quads, title="Quadruples"):
    print(f"\n{title}:\nOp\tArg1\tArg2\tRes")
    for q in quads:
        print(q)

def main():
    quads = get_input()
    display(quads, "Original")
    quads = constant_folding(quads)
    display(quads, "After Constant Folding")
    quads = strength_reduction(quads)
    display(quads, "After Strength Reduction")

if __name__ == "__main__":
    main()
