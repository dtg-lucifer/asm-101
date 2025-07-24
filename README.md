# x86 Assembly Language Examples

This repository contains a collection of x86-64 assembly language examples to help you get started with assembly programming. Each example demonstrates different concepts and gradually increases in complexity.

![Assembly Language](https://img.shields.io/badge/language-Assembly-brightgreen)
![Architecture](https://img.shields.io/badge/architecture-x86__64-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Requirements

To build and run these examples, you need:

- **Linux environment**: All examples are designed to run on Linux operating systems
- **NASM**: The Netwide Assembler (version 2.14 or later recommended)
- **LD**: The GNU linker
- **GCC**: The GNU Compiler Collection (needed for the extern example)

You can install these requirements on Debian/Ubuntu with:

```bash
sudo apt-get update
sudo apt-get install nasm gcc build-essential gdb
```

On Fedora/RHEL/CentOS:

```bash
sudo dnf install nasm gcc gdb
```

On Arch Linux:

```bash
sudo pacman -S nasm gcc gdb
```

The `gdb` debugger is optional but recommended for debugging assembly code.

## Repository Structure

The repository contains the following examples:

### [01_hello_world](01_hello_world/README.md)

A basic "Hello, World" program that demonstrates printing a string to standard output, basic memory operations, and system calls.

### [02_extern](02_extern/README.md)

An example showing how to interface with C standard library functions, implementing a do-while loop in assembly, and managing the stack frame.

### [03_user_input](03_user_input/README.md)

A program that demonstrates reading user input from standard input, processing that input, and using custom subroutines.

### [04_number_to_ascii_char](04_number_to_ascii_char/README.md)

A program that demonstrates converting numeric values to ASCII characters and printing them to the console.

### [05_basic_math](05_basic_math/README.md)

A program that demonstrates various arithmetic operations including addition, subtraction, multiplication, and division, with formatted output.

### [06_stack_memory](06_stack_memory/README.md)

A program that demonstrates proper memory access techniques, handling different data sizes, and register operations in x86-64 assembly.

### [07_char_string](07_char_string/README.md)

A program that demonstrates working with character data, traversing arrays/lists, and converting numbers to ASCII representations.

Each example directory contains its own detailed README with a line-by-line explanation of the code.

## Building and Running

Each example directory contains its own Makefile. To build any example:

1. Navigate to the example directory

    ```bash
    cd x86/01_hello_world
    ```

2. Run make

    ```bash
    make
    ```

3. Run the compiled program
    ```bash
    ./bin/main
    ```

To clean up the build artifacts:

```bash
make clean
```

### Building and Running Examples

Each example can be built and run using the Makefile provided in its directory:

```bash
# Navigate to the example directory
cd 01_hello_world

# Build the example
make

# Run the example
./bin/main
```

For expected outputs and detailed explanations, see the README.md file in each example directory.

## Warning

These examples require NASM, LD, and a Linux environment. They are specifically designed for x86-64 architecture and will not work on different architectures without modifications.

⚠️ **Important notes**:

- The code uses x86-64 Linux syscall conventions
- The examples won't work on Windows without significant modifications
- They may not work on non-x86-64 architectures like ARM or RISC-V
- Make sure your system is 64-bit (use `uname -m` to check, should return `x86_64`)

## Understanding the Code

Each assembly file (.asm) is thoroughly commented to explain:

- The purpose of the program
- Register usage
- System calls
- Memory operations
- Control flow

### Common x86-64 Registers

For those new to x86-64 assembly:

| Register | Purpose                                       | System Call Convention               |
| -------- | --------------------------------------------- | ------------------------------------ |
| RAX      | Accumulator, syscall number, function results | System call number & return value    |
| RBX      | Base, callee-saved                            | Preserved across function calls      |
| RCX      | Counter, 4th argument                         | 4th argument, may be clobbered       |
| RDX      | Data, 3rd argument                            | 3rd argument, size/count parameter   |
| RSI      | Source index, 2nd argument                    | 2nd argument, source/buffer pointer  |
| RDI      | Destination index, 1st argument               | 1st argument, file descriptor/target |
| RBP      | Base pointer for stack frame                  | Preserved across function calls      |
| RSP      | Stack pointer                                 | Stack pointer, managed by CPU        |

## Debugging Assembly Code

To debug these examples:

1. Build with the included Makefiles (they already include `-g` flag for debugging symbols)
2. Run GDB:
    ```bash
    gdb ./bin/main
    ```
3. Common GDB commands for assembly:
    ```
    (gdb) layout asm       # Display assembly code
    (gdb) break _start     # Set breakpoint at _start
    (gdb) info registers   # View register values
    (gdb) stepi            # Step one instruction
    (gdb) continue         # Continue execution
    ```

## Learning Resources

- [NASM Documentation](https://www.nasm.us/doc/)
- [x86-64 System Call Table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Intel x86 Software Developer Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)

## Contributing

Feel free to contribute additional examples or improvements to existing ones through pull requests!

## License

This project is open source and available for educational purposes.
