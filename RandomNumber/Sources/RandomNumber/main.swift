import RandomNumberMaker

let arguments = CommandLine.arguments
if arguments.count != 2{
    print("please add numberRange")
}else{
    let rangeNumber = Int(arguments[1])
    let maker = RandomNumberMaker(numberRange: rangeNumber!)
    print(maker.randomNumber)
}
