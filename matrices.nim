import sugar
import vectors

# Matrices don't need to be more than 2D hahaha
type
  RowVector* = Vector
  ColumnVector* = Vector
  Matrix* = seq[RowVector]

## Apply an arbitrary function to every element of a matrix
func map*(A: Matrix, op: proc(A: Matrix, i, j: int): int): Matrix =
  result.setLen(A.len()) # At some point, I need to find out if setLen is the convention
  for i in 0 ..< A.len():
    result[i].setLen(A[i].len())
    for j in 0 ..< A[i].len():
      result[i][j] = op(A, i, j) # Note that the position is _actively_ provided

## Apply an arbitrary function to every element of a matrix
func map*(A, B: Matrix, op: (Matrix, Matrix, int, int) -> int): Matrix =
  result.setLen(A.len())
  for i in 0 ..< A.len():
    result[i].setLen(A[i].len())
    for j in 0 ..< A[i].len():
      result[i][j] = op(A, B, i, j)

## Matrix Addition
func `+`*(A, B: Matrix): Matrix =
  return map(A, B, (a, b, i, j) => a[i][j] + b[i][j])

## Matrix Subtraction
func `-`*(A, B: Matrix): Matrix =
  return map(A, B, (a, b, i, j) => a[i][j] - b[i][j])

## Scalar-Matrix Multiplication
func `*`*(A: int, B: Matrix): Matrix =
  return map(B, (b, i, j) => A * b[i][j])

## Scalar-Matrix Multiplication
func `*`*(A: Matrix, B: int): Matrix =
  return B * A
