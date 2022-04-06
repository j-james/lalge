import std/math
import types, vectors, matrices

let A: Matrix = @[
  @[10, 2, 3, 5, 6],
  @[8, 7, 6, 4, 3],
  @[4, 6, 0, 9, 0],
  @[6, 7, 9, 3, 9],
  @[3, 0, 7, 9, 9],
]
let B: Matrix = @[
  @[1, 2, 3, 4, 5],
  @[5, 3, 1, 22, 3],
  @[5, 21, 4, 6, 3],
  @[12, 1, 5, 0, 9],
  @[6, 7, 1, 3, 5],
]

let L: Matrix = @[
  @[1, 0, 0, 0, 0, 0],
  @[-1, 1, 0, 0, 0, 0],
  @[0, -1, 1, 0, 0, 0],
  @[0, 0, -1, 1, 0, 0],
  @[0, 0, 0, -1, 1, 0],
  @[0, 0, 0, 0, -1, 1],
]
let U: Matrix = @[
  @[1, -1, 0, 0, 0, 0],
  @[0, 1, -1, 0, 0, 0],
  @[0, 0, 1, -1, 0, 0],
  @[0, 0, 0, 1, -1, 0],
  @[0, 0, 0, 0, 1, -1],
  @[0, 0, 0, 0, 0, 1],
]

let
  P13: Matrix = @[
    @[0, 0, 1],
    @[0, 1, 0],
    @[1, 0, 0],
  ]
  P23: Matrix = @[
    @[1, 0, 0],
    @[0, 0, 1],
    @[0, 1, 0],
  ]

let foo = @[
  @[1, 1, 1],
  @[3, 4, 5],
  @[40, 51, 12]
]

let eliminationMatrix: Matrix = @[
  @[1, 0, 0],
  @[-2, 1, 0],
  @[0, 0, 1]
]

let
  ones: Matrix = @[
    @[1,2,3],
    @[4,5,6]
  ]
  twos: Matrix = @[
    @[7,8],
    @[9,10],
    @[11,12]
  ]

# Addition and subtraction
assert I2 + I2 == 2 * I2
assert I3-I3 == gen(3, 3, 0)

# Num. of rows / columns
assert rows(I2) == 2
assert I2.rows() == 2
assert I2.rows == 2
assert cols(I3) == 3
assert I3.cols() == 3
assert I3.cols == 3

# Identity Matrices
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

assert det(@[
  @[2, -1, 0, -1],
  @[-1, 2, -1, 0],
  @[0, -1, 2, -1],
  @[-1, 0, -1, 2],
]) == 0

assert det(A * B) == (det(A) * det(B))
assert det(I3) == 1
assert det(2*I4) == 16

# Vectors

let
  alice: Vector = @[1, 1, 1]
  bob = @[3, 4, 5]
  carol = @[40, 51, 12]
  dan: Vector = @[10, 20, 30, 40]
  eve = @[2, 3, 4]

assert alice + bob == bob + alice
assert alice + carol == carol + alice
assert carol - eve != eve - carol
assert alice.length() == sqrt(3.0)

# echo transpose(ones)
# echo P13 * 8
# echo P13 + P23
# echo ones * twos
# assert col(eliminationMatrix, 0) == col(eliminationMatrix, 0)
# echo identity(0)
# echo identity(2)
# echo (1/0)
# echo L*U
# echo U*L
