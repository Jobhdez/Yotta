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

**Test**
```
(ql:quickload :yotta/tests)

(asdf:test-system :yotta)

```

# Acknowledgements
[Robert Smith](https://github.com/stylewarning) is helping me design this compiler.
