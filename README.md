# Yotta 
work in progress.

# Getting Started
**Dependencies**: 
- SBCL: MacOS:`brew install sbcl`; Ubuntu `sudo apt-get install sbcl`
- [Quicklisp](https://www.quicklisp.org/beta/)

**Install**:
`git clone git@github.com:Jobhdez/Yotta.git`

Note: clone this project in `quicklisp/local-projects` so you can load the project with `(ql:quickload :yotta)`.

**Use**:
```
(ql:quickload :yotta)

(in-package :yotta)
```
To compile an vector addition expression such as `[2 3 4] + [4 5 6]` use:
```
(create-c-file "[2 3 4] + [4 5 6]")
```
This will create a file `test2.c` which you then can compile it further with gcc:
```
gcc test2.c
./a.out
```
Vector addition and subtraction and matrix addition and subtraction compiles to C that compiles with GCC.

**Test**
```
(ql:quickload :yotta/tests)

(asdf:test-system :yotta)

```

# Acknowledgements
[Robert Smith](https://github.com/stylewarning) is helping me design this compiler.
