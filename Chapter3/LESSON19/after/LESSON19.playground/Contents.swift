class Car {
  var name:String
  
  init() {
    name = ""
  }
  
  func printName() {
    print("名前は \(name) です")
  }
}

var myCar:Car = Car()
myCar.name = "ホンダ"
myCar.printName()

struct Animal {
  var foot: Int
  
  func showDetail() {
    print("足は \(foot) 本です")
  }
}

var animal = Animal(foot: 4)
animal.showDetail()

enum CoffeeSize {
  case short
  case tall
  case grande
  case venti
}

var size = CoffeeSize.tall
size = .short