import vectors

# Matrices don't need to be more than 2D hahaha
type
  RowVector* = Vector
  ColumnVector* = Vector
  Matrix* = seq[RowVector]

## Matrix Addition
func `+`*(A, B: Matrix): Matrix =
  assert A.len() == B.len()
  for i, row in A:
    assert A[i].len() == A[i].len()
  for i, row in A:
    var C: seq[int]
    for j, element in row:
      C.add(A[i][j] + B[i][j])
    result.add(C)

## Matrix Subtraction
func `-`(A, B: Matrix): Matrix =
  assert A.len() == B.len()
  for i, row in A:
    assert A[i].len() == B[i].len()
  for i, row in A:
    var C: seq[int]
    for j, element in row:
      C.add(A[i][j] - B[i][j])
    result.add(C)

## Scalar-Matrix Multiplication
func `*`(A: int, B: Matrix): Matrix =
  for row in B:
    var foo: Vector
    for element in row:
      foo.add(A * element)
    result.add(foo)

## Scalar-Matrix Multiplication
func `*`(A: Matrix, B: int): Matrix =
  return B * A
