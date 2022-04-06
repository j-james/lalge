type
  # Any generic Vector is assumed to be a column vector.
  Vector* = seq[int]
  RowVector* = Vector # can this be distinct?
  Matrix* = seq[RowVector]

type
  Radian* = float
