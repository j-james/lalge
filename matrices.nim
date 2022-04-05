import sugar, math
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
func gen*(rows, columns: Natural, element: int = 0): Matrix =
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
func map*(A: Matrix, op: proc(i, j: int): int): Matrix =
  result = gen(A.rows(), A.columns())
  for i in 0 ..< A.rows():
    for j in 0 ..< A.columns():
      result[i][j] = op(i, j) # Note that the position is _actively_ provided

# TODO: check if this meets assert requirements
## Matrix addition
func `+`*(A, B: Matrix): Matrix =
  return map(A, (i, j) => A[i][j] + B[i][j])

## Matrix subtraction
func `-`*(A, B: Matrix): Matrix =
  return map(A, (i, j) => A[i][j] - B[i][j])

## Scalar-Matrix multiplication
func `*`*(a: int, B: Matrix): Matrix =
  return map(B, (i, j) => a * B[i][j])

## Scalar-Matrix multiplication
func `*`*(A: Matrix, b: int): Matrix =
  return b * A

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
  return map(A, (i, j) => abs(A[i][j]))

## Returns a "column vector" of a matrix as a Xx1 Matrix
func col*(A: Matrix, j: int): ColumnVector =
  result = gen(A.rows(), 1)
  for i in 0 ..< A.rows():
    result[i] = @[A[i][j]]

## Alternate implementation of col, cleaner but in a different style
func column*(A: Matrix, column: int): ColumnVector =
  for row in A:
    result.add(@[row[column]])

func diag*(A: Matrix): Vector =
  assert A.rows() == A.columns(), "The matrix is not square"
  for i in 0 ..< A.rows():
    result.add(A[i][i])

func transpose*(A: Matrix): Matrix =
  result = gen(A.columns(), A.rows())
  return map(result, (i, j) => (A[j][i]))

func transpose*(a: Vector): Matrix =
  result = gen(a.len(), 1)
  return map(result, (i, j) => (a[j]))

## Generate an arbitary sized identity matrix
func identity*(size: Natural): Matrix =
  return map(gen(size, size), (i, j) => (if i==j: 1 else: 0))

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

## Calculates the determinant of a matrix through Laplace expansion
func det*(A: Matrix): int =
  assert A.rows() == A.columns(), "The matrix is not square"
  if A.rows() == 2:
    return (A[0][0]*A[1][1]) - (A[0][1]*A[1][0])
  for i in 0 ..< A.rows():
    var sub: Matrix
    for a in 0 ..< A.rows():
      if a == 0: continue
      var row: RowVector
      for b in 0 ..< A.columns():
        if b == i: continue
        row.add(A[a][b])
      sub.add(row)
    result += (-1)^i * A[0][i] * det(sub)
