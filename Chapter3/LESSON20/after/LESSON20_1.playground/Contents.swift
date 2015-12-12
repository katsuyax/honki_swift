protocol SampleProtocol {
    func method1(value: Int)
}

class SampleClass: SampleProtocol {
    func method1(value: Int) {
        print(value)
    }
}

var mySampleClass:SampleClass = SampleClass()
mySampleClass.method1(100)
