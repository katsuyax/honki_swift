enum SampleError: ErrorType {
  case NilValue
  case IllegalValue(Int)
}

func example(num: Int?) throws {
  guard let value = num else {
    throw SampleError.NilValue
  }

  if value < 0 {
    throw SampleError.IllegalValue(value)
  }
}

do {
  try example(-1)
}
catch SampleError.NilValue {
  print("Nil")
}
catch SampleError.IllegalValue(let value) {
  print("Illegal \(value)")
}