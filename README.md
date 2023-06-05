# Yotta 
A basic linear algebra compiler. As of today, 6/5/23 it compiles a simple linear algebra language to C and Lisp; right now, this compiler is more of a proof of concept or experiment and consequently, this is a work in progress. I will probably rewrite it and extend the language and actually generate the C code. Right now, it compiles to calls to C functions and then these generated function calls get appended to a string consisting of the C linear algebra functions. Something like this is actually done in practice but with actual performant C code; I believe Google's XLA compiler has an option to compile to Eigen calls; but there's also the option of building just a library instead of a compiler and the other option is to build a compiler that does not compile to set of bindings but to actually generate code.

Some inspiration for this project include TACO, a tensor algebra compiler built by an MIT professor and XLA. I am getting a better idea of how these systems work in practice. TVM is also an interesting compiler to look at.

I am building this compiler just out of curiosity; I want to build compilers but I am not entirely sure what type of compilers to focus on; I think linear algebra compilers are very interesting and could potentially be useful for scientific purposes; moreover, linear algebra compilers can also be useful for compiling neural networks. For these reasons, I would like to build a simplified version of a linear algebra compiler such XLA or TACO.

## Getting Started
### Dependencies: 
- SBCL
   * MacOS:`brew install sbcl`
   * Ubuntu: `sudo apt-get install sbcl`
   * Arch Linux: `sudo pacman -S sbcl`
- [Quicklisp](https://www.quicklisp.org/beta/)
- GCC
   * Ubuntu: `sudo apt install build-essential gcc`
   * Arch Linux: `sudo pacman -S gcc`
     

### Install:
- Clone the repo into `~/quicklisp/local-projects/`: `git clone git@github.com:Jobhdez/Yotta.git`

## Usage:
```
(ql:quickload :yotta)

(in-package :yotta)
```
To compile a vector addition expression such as `[2 3 4] + [4 5 6]` use:
```
(create-c-file "[2 3 4] + [4 5 6]" <filename.c>)
```

To compile a matrix addition use:
```
(create-c-file "[[3 4 5][5 6 7]] + [[4 5 6][6 7 8]]" <filename.c>)
```
This will in turn create a `c` file  which you then can compile it further with gcc:
```
gcc <filename.c>
./a.out
```
Vector addition and subtraction and matrix addition and subtraction compiles to C that compiles with GCC.

## Test
```
(ql:quickload :yotta/tests)

(asdf:test-system :yotta)

```

## Acknowledgements
[Robert Smith](https://github.com/stylewarning) is helping me design this compiler.
