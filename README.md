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

### 01_hello_world

A basic "Hello, World" program that demonstrates:

- Printing a string to standard output
- Basic memory operations
- System calls
- Program sections (text, data, bss)

Key concepts:

- `syscall` instruction for system calls
- Text, data, and BSS sections
- Basic register usage (rax, rdi, rsi, rdx)

### 02_extern

An example showing how to interface with C standard library functions:

- Using `printf` and `scanf` from the C library
- Implementing a do-while loop in assembly
- Managing the stack frame and local variables

Key concepts:

- Calling external C functions
- Stack frame setup and tear down
- Comparison and conditional jumps
- Local variable allocation

### 03_user_input

A program that demonstrates:

- Reading user input from standard input
- Processing and storing that input
- Custom subroutines in assembly
- Printing the input back to the user

Key concepts:

- Reading from stdin using system calls
- Implementing and calling custom subroutines
- Managing memory buffers
- Register preservation across function calls

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

### Example Session

Here's what you might see when running the examples:

```bash
# For the Hello World example
$ cd 01_hello_world
$ make
$ ./bin/main
Hello, World

# For the extern example
$ cd ../02_extern
$ make
$ ./bin/main
Enter a number: 3
Looping 0 of 3
Looping 1 of 3
Looping 2 of 3
Looping 3 of 3

# For the user input example
$ cd ../03_user_input
$ make
$ ./bin/main
Hey, what is your name? John
Hello, John
```

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
