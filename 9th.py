class Node:
    def __init__(self, data):
        self.data = data
        self.label = -1
        self.left = None
        self.right = None

def insert_node(tree, val):
    if tree is None:
        return Node(val)
    return tree

def insert(tree, val):
    tree = insert_node(tree, val)
    num_of_children = int(input(f"\nEnter number of children of {val}: "))
    if num_of_children == 2:
        l = input(f"\nEnter Left Child of {val}: ")
        tree.left = insert_node(tree.left, l)
        r = input(f"\nEnter Right Child of {val}: ")
        tree.right = insert_node(tree.right, r)
        tree.left = insert(tree.left, l)
        tree.right = insert(tree.right, r)
    return tree

def find_leaf_labels(tree, val):
    if tree.left and tree.right:
        find_leaf_labels(tree.left, 1)
        find_leaf_labels(tree.right, 0)
    else:
        tree.label = val

def find_interior_labels(tree):
    if tree.left and tree.left.label == -1:
        find_interior_labels(tree.left)
    elif tree.right and tree.right.label == -1:
        find_interior_labels(tree.right)
    else:
        if tree.left and tree.right:
            if tree.left.label == tree.right.label:
                tree.label = tree.left.label + 1
            else:
                tree.label = max(tree.left.label, tree.right.label)

def print_inorder(tree):
    if tree:
        print_inorder(tree.left)
        print(f"{tree.data} with Label {tree.label}")
        print_inorder(tree.right)

def swap(R, i, j):
    R[i], R[j] = R[j], R[i]

def pop(R, top):
    temp = R[top]
    top -= 1
    return temp, top

def push(R, top, temp, num_of_registers):
    if top == num_of_registers - 1:
        print("Stack overflow! Storing in temporary variable T.")
        top = num_of_registers
        if len(R) == num_of_registers:
            R.append(temp)
        else:
            R[top] = temp
    else:
        top += 1
        R[top] = temp
    return top

def operation_name(op):
    return {
        '+': "ADD",
        '-': "SUB",
        '*': "MUL",
        '/': "DIV"
    }.get(op, "")

def generate_code(tree, R, top, num_of_registers):
    if tree.left and tree.right:
        if (tree.left.label == 1 and tree.right.label == 0 and
                tree.left.left is None and tree.left.right is None and
                tree.right.left is None and tree.right.right is None):
            print(f"MOV {tree.left.data}, ", end="")
            print("T" if top == num_of_registers else f"R[{top}]")
            print(f"{operation_name(tree.data)} {tree.right.data}, ", end="")
            print("T" if top == num_of_registers else f"R[{top}]")

        elif tree.left.label >= 1 and tree.right.label == 0:
            generate_code(tree.left, R, top, num_of_registers)
            print(f"{operation_name(tree.data)} {tree.right.data}, ", end="")
            print("T" if top == num_of_registers else f"R[{top}]")

        elif tree.left.label < tree.right.label:
            swap(R, top, top - 1)
            generate_code(tree.right, R, top, num_of_registers)
            temp, top = pop(R, top)
            generate_code(tree.left, R, top, num_of_registers)
            top = push(R, top, temp, num_of_registers)
            swap(R, top, top - 1)
            print(f"{operation_name(tree.data)} R[{top - 1}], ", end="")
            print("T" if top == num_of_registers else f"R[{top}]")

        elif tree.left.label >= tree.right.label:
            generate_code(tree.left, R, top, num_of_registers)
            temp, top = pop(R, top)
            generate_code(tree.right, R, top, num_of_registers)
            top = push(R, top, temp, num_of_registers)
            print(f"{operation_name(tree.data)} R[{top - 1}], ", end="")
            print("T" if top == num_of_registers else f"R[{top}]")

    elif tree.left is None and tree.right is None and tree.label == 1:
        print(f"MOV {tree.data}, ", end="")
        print("T" if top == num_of_registers else f"R[{top}]")

def main():
    root = None
    val = input("Enter root of tree: ")
    root = insert(root, val)
    find_leaf_labels(root, 1)
    while root.label == -1:
        find_interior_labels(root)

    num_of_registers = int(input("Enter the number of registers available: "))
    R = list(range(num_of_registers - 1, -1, -1))
    print("\nInorder Display:")
    print_inorder(root)
    print("\nAssembly Code:")
    top = root.label - 1
    generate_code(root, R, top, num_of_registers)

if __name__ == "__main__":
    main()

