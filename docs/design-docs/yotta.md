# Yotta

## Objective
Build a linear algebra compiler that is faster than numpy's linear algebra api.
## Background/Motivation
Linear algebra is important for scientific computation. Even if Yotta does not end as a production compiler and thereby help people in industry I would like this to be out there in the open so people can use to it build their own linear algebra compilers.
## Overview
### Linear Algebra Language
#### Concrete Syntax
```
exp ::= scalar | vector | matrice | vector + vector 
     |  vector - vector | vector * vector | matrice + matrice 
     |  matrice * matrice | matrice - matrice | var | var = exp
     
scalar ::= int

vector ::= [int]

matrice ::= [[int]]
```

#### Abstract Syntax
```
exp ::= (Scalar scalar) | (Vector vector) | (Matrice matrice)
     |  (Add exp exp)   | (Sub exp exp)
     |  (Assign var exp)
```
     
#### x86
....

#### Passes
```
AST -> Loop IL -> Goto IL -> x86Goto IL -> x86

Loop IL: makes the loop associated with the linear algebra computations explicit
Goto IL: intermediate language with gotos and labels


```

## Milestones
1. Parser and Lexer by 10/18
If I have time I will implement the Loop IL.
2. Implement the Loop IL or Goto IL by 11/8
