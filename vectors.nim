type Vector* = seq[int]

func `+`*(a, b: Vector): Vector =
  assert a.len() == b.len(), "Dimensional mismatch - check your vectors"
  when result is seq:
    result.setLen(a.len)
  for i, element in a:
    result[i] = (a[i] + b[i])

func `-`*(a, b: Vector): Vector =
  assert a.len() == b.len(), "Dimensional mismatch - check your vectors"
  when result is seq:
    result.setLen(a.len)
  for i, element in a:
    result[i] = (a[i] - b[i])

func `*`*(a, b: Vector): int =
  assert a.len() == b.len(), "Dimensional mismatch - check your vectors"
  for i, element in a:
    result += a[i] * b[i]

func cross*(a, b: Vector): Vector =
  assert a.len() == 3, "The first Vector is not three-dimensional"
  assert b.len() == 3, "The second Vector is not three-dimensional"
  return @[
    (a[1]*b[2]) - (b[1]*a[2]),
    (a[2]*b[0]) - (b[2]*a[0]),
    (a[0]*b[1]) - (b[0]*a[1])
  ]
