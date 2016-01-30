//: Playground - noun: a place where people can play

import Cocoa

struct Item {
    var price: Int
    var count: Int
}

//表示在一个游戏中操作自动贩卖机时可能会出现的错误状态
enum VendingMachineError: ErrorType {
    case InvalidSelection//选择无效的
    case InsufficientFunds(coinsNeeded: Int)//金额不足
    case OutOfStock//无货
}

class VendingMachine {
    //inventory 存货
    var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0//硬币存储
    
    func dispense(snack: String) {
        print("Dispending\(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        --item.count
        inventory[name] = item
        dispense(name)
    }
}

let vender = VendingMachine()
vender.coinsDeposited = 1
do {
    try vender.vend(itemNamed: "Chips")
} catch VendingMachineError.InvalidSelection {
    print("选择无效")
} catch VendingMachineError.InsufficientFunds {
    let m = VendingMachineError.InsufficientFunds
    print("钱不足\(m)")
} catch VendingMachineError.OutOfStock {
    print("无货")
}


//懒加载
class ClassA {
    lazy var str: String = {
        let str = "Hello"
        print("只在首次访问输出")
        return str
    }()
}


enum WrongName:ErrorType{
    case NoName
}

func doSomeThing(name name: String) throws ->String {
    if name.isEmpty {
        throw WrongName.NoName
    }
    print("no error")
    return name
}

do {
   let u = try? doSomeThing(name: "u")
} catch WrongName.NoName {
    print("NoName error!")
}

var x = 42
var x2 = x
++x
print("x = \(x) x2 = \(x2)")


func hello(name name: String) {
    print("hello \(name)")
}

hello(name: "Robot")


class MyHelloWorldClass {
    func helloWithName(name name: String) -> String {
        return "hello, \(name)"
    }
}
//柯里化函数
let helloWithNameFunc = MyHelloWorldClass.helloWithName
//柯里化函数的调用
let myHelloInstance = MyHelloWorldClass()
helloWithNameFunc(myHelloInstance)(name: "aaa")
helloWithNameFunc(myHelloInstance)(name: "sss")
helloWithNameFunc(myHelloInstance)(name: "Bo")


struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}


let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print(boilingPointOfWater)

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater)

let bodyTemperature = Celsius(37.0)





let die: Dictionary<Int, String> = [1: "one", 2: "two"]
print(die)

func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}




//Array<Dictionary>
let arr1: Array = [1, 2, 3, 4]
let dic1: Dictionary = [1: "a",2: "b", 3: "c"]


enum CompassPoint {
    case North
    case South
    case East
    case West
}


var directionToHead = CompassPoint.West
directionToHead = .East

switch directionToHead {
case .North:
    print("北方")
//case .South:
//    print("南方")
//case .East:
//    print("东方")
//case .West:
//    print("西方")
default:
    print("随便")
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

names.sort(backwards)

let anotherArray = names.flatMap { (string:String) -> Int? in
    
    let length = string.characters.count
    
    guard length > 0 else {
        return nil
    }
    
    return string.characters.count
}

print(anotherArray)

let addNames = names.flatMap{
    (str: String) -> String in
    return str + "aop"
}
print(addNames)

let annames = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backWards(s1: String, s2: String) -> Bool {
    return s1 < s2
}

let rever = names.sort(backWards)
//数组的初始化
var array1: Array<Int> = Array()
var array2: [String] = Array()
//字典的初始化
var dic12: Dictionary<String, Int> = Dictionary()
var dic21: [String: String] = Dictionary()

//扩展
extension Double {
    var km: Double {return self * 1_000.0 }
    var m: Double {return self }
    var cm: Double {return self / 100.0 }
    var mm: Double {return self / 1_000.0 }
    var ft: Double {return self / 3.28084 }
}


extension String {
    var devide: String {
        return self + ".com"
    }
}


let ouy = "2574".devide




let oneInch = 25.4.cm
print(oneInch)
let therrFeet = 3.ft
let aMarathon = 42.km + 195.m

extension Int {
    //为Int类型添加了一个名为 repetitions的实例方法: 这个repetitions(: _)方法接受一个 
   // () -> void 类型的单参数，表示将没有参数且没有返回值的函数
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions { () -> Void in
    print("Hello")
}

5.repetitions { () -> Void in
    print("aa")
}

extension Int {
    mutating func square() {
        self = self * self
    }
    var double : Int {
        return self * 2
    }
}

var someInt = 3
someInt.square()

let sopuy = 8.double


var opy = 5
opy.square()
//下标
extension Int {
    
    subscript(var digitIndex: Int) -> Int {
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
//泛型
func simpleMax<T: Comparable>(x: T, _ y: T) -> T {
    if x < y {
        return y
    }
    return x
}
simpleMax(17, 42)
simpleMax("a", "b")

let dictArray: Array<Dictionary<Int, String>> = [[1: "a"], [2: "b"], [3: "c"]]
print(dictArray)

func maxOfInput<T: Comparable>(x: T, _ y: T) -> T{
    if x < y {
        return y
    }
    return x
}

maxOfInput(56, 87)






