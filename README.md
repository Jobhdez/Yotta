# Yotta 
Development of a linear algebra compiler in process.

# Getting Started
**Dependencies**: 
- SBCL: MacOS:`brew install sbcl`; Ubuntu `sudo apt-get install sbcl`
- [Quicklisp](https://www.quicklisp.org/beta/)

Note: after installing `Quicklisp` a `quicklisp` folder will be created. 
- [CL-YACC](https://github.com/jech/cl-yacc)
- [Alexa](https://github.com/quil-lang/alexa)

Note: clone `cl-yacc` and `alexa` into `quicklisp/local-projects` so it can be loaded.

**Install**:
`git clone git@github.com:Jobhdez/Yotta.git`

Note: clone this project in `quicklisp/local-projects` so you can load the project with `(ql:quickload :yotta)`.

**Use**:
- `(ql:quickload :yotta)`

- `(in-package :yotta)`

# Acknowledgements
[Robert Smith](https://github.com/stylewarning) is helping me design this compiler.
