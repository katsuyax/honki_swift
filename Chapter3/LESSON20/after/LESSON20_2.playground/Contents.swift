extension String {
    var reverse:String {
        var result = ""
        for char in self.characters {
            result = String(char) + result
        }
        return result
    }
}

var str:String = "Swift"
var reverseStr = str.reverse
