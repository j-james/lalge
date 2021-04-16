import sugar
import vectors

# Matrices don't need to be more than 2D hahaha
type
  RowVector* = Vector
  ColumnVector* = Matrix # if possible: seq[seq[1, int]]
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

## Matrix addition
func `+`*(A, B: Matrix): Matrix =
  return map(A, B, (a, b, i, j) => a[i][j] + b[i][j])

## Matrix subtraction
func `-`*(A, B: Matrix): Matrix =
  return map(A, B, (a, b, i, j) => a[i][j] - b[i][j])

## Scalar-Matrix multiplication
func `*`*(A: int, B: Matrix): Matrix =
  return map(B, (b, i, j) => A * b[i][j])

## Scalar-Matrix multiplication
func `*`*(A: Matrix, B: int): Matrix =
  return B * A

## Matrix multiplication
func `*`*(A, B: Matrix): Matrix =
  assert A.len() == B[0].len(), "Mismatched rows and columns"
  result.setLen(A.len())
  for i in 0 ..< A.len():
    result[i].setLen(B[i].len())
    for j in 0 ..< B[i].len():
      for k in 0 ..< B.len():
        result[i][j] += A[i][k] * B[k][j]

## Absolute value of a Matrix
func abs*(A: Matrix): Matrix =
  return map(A, (a, i, j) => abs(a[i][j]))

## Returns a "column vector" of a Matrix as a 1xX Matrix
func col*(A: Matrix, j: int): ColumnVector =
  result.setLen(A.len())
  for i in 0 ..< A.len():
    result[i] = @[A[i][j]]

## Alternate implementation of col, cleaner but in a different style
func col2*(A: Matrix, column: int): ColumnVector =
  for row in A:
    result.add(@[row[column]])

## Overrides the echo() proc to provide more readable output
proc echo*(A: Matrix) =
  echo "@["
  for row in A:
    echo "  ", row
  echo "]"
