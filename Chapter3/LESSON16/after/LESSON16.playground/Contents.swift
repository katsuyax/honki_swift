var places:[String] = ["Hyogo", "Osaka", "Kyoto", "Nara", "Shiga", "Wakayama"]

var place0 = places[0]
var place1 = places[1]

var places2 = places[1...3]

places.append("Kyoto")

places.removeLast()
print(places)

var size = ["small":30, "middle":50, "large":70]
print(size["middle"])

size["X-large"] = 90
print(size)
