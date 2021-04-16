import sugar
import numbers, vectors

# Matrices don't need to be more than 2D hahaha
type
  RowVector* = Vector
  ColumnVector* = Matrix # if possible: seq[seq[1, int]]
  Matrix* = seq[RowVector]

## Overrides the echo() proc to provide more human-readable output
proc echo*(A: Matrix) =
  echo "@["
  for row in A:
    echo "  ", row
  echo "]"

## Generate a new, filled XxX Matrix
func gen*(rows, columns: int, element: int = 0): Matrix =
  result.setLen(rows)
  for i in 0 ..< rows:
    result[i].setLen(columns)
    for j in 0 ..< columns:
      result[i][j] = element

## Returns the number of rows in a matrix
func rows*(A: Matrix): int =
  return A.len()

## Returns the number of columns in a matrix
func columns*(A: Matrix): int =
  if A.rows() == 0:
    return 0
  else:
    return A[0].len()

## Apply an arbitrary function to every element of a matrix
func map*(A: Matrix, op: proc(A: Matrix, i, j: int): int): Matrix =
  result = gen(A.rows(), A.columns())
  for i in 0 ..< A.rows():
    for j in 0 ..< A.columns():
      result[i][j] = op(A, i, j) # Note that the position is _actively_ provided

## Apply an arbitrary function to every element of a matrix
func map*(A, B: Matrix, op: (Matrix, Matrix, int, int) -> int): Matrix =
  result = gen(A.rows(), A.columns())
  for i in 0 ..< A.rows():
    for j in 0 ..< A.columns():
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
  assert A.rows() == B.columns(), "Mismatched rows and columns"
  result = gen(A.rows(), B.columns())
  for i in 0 ..< A.rows():
    for j in 0 ..< B.columns():
      for k in 0 ..< B.rows():
        result[i][j] += A[i][k] * B[k][j]

## Absolute value of a matrix
func abs*(A: Matrix): Matrix =
  return map(A, (a, i, j) => abs(a[i][j]))

## Returns a "column vector" of a matrix as a Xx1 Matrix
func col*(A: Matrix, j: int): ColumnVector =
  result = gen(A.rows(), 1)
  for i in 0 ..< A.rows():
    result[i] = @[A[i][j]]

## Alternate implementation of col, cleaner but in a different style
func column*(A: Matrix, column: int): ColumnVector =
  for row in A:
    result.add(@[row[column]])

## Generate an arbitary sized identity matrix
func identity(size: NaturalInt): Matrix =
  return map(gen(size, size), (a, i, j) => (if i==j: 1 else: 0))

## Identity Matrices
let
  I1*: Matrix = identity(1)
  I2*: Matrix = identity(2)
  I3*: Matrix = identity(3)
  I4*: Matrix = identity(4)
  I5*: Matrix = identity(5)

assert I1 == @[
  @[1],
]
assert I2 == @[
  @[1, 0],
  @[0, 1],
]
assert I3 == @[
  @[1, 0, 0],
  @[0, 1, 0],
  @[0, 0, 1],
]
assert I4 == @[
  @[1, 0, 0, 0],
  @[0, 1, 0, 0],
  @[0, 0, 1, 0],
  @[0, 0, 0, 1],
]
assert I5 == @[
  @[1, 0, 0, 0, 0],
  @[0, 1, 0, 0, 0],
  @[0, 0, 1, 0, 0],
  @[0, 0, 0, 1, 0],
  @[0, 0, 0, 0, 1],
]
