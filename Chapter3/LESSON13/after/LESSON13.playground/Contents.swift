let a = 60

if a > 80 {
  print("Aランク")
} else if a > 50 {
  print("Bランク")
} else {
  print("Cランク")
}

let place = "Osaka"

switch place {
case "Kyoto":
print("京都です")
case "Osaka":
  print("大阪です")
case "Tokyo", "Kanagawa":
  print("関東です")
default:
  print("想定していない県名です")
}
