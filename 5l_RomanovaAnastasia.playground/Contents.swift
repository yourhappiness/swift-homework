import UIKit

enum Windows {
  case open, closed, halfopen
}

enum Trunk {
  case full, empty, halffull
}

enum Doors {
  case open, closed
}

enum Transmission {
  case manual, auto, semiauto
}

enum Engine {
  case start, stop
}

enum Hatch {
  case open, closed, halfopen
}

protocol Car {
  var color: UIColor {get}
  var model: String {get}
  var transmission: Transmission {get}
  var doors: Int? {get}
  var windowsState: Windows {get set}
  var trunkState: Trunk {get set}
  var doorsState: Doors {get set}
  var engineState: Engine {get set}
  func move()
  func openWindows()
  func closeDoors()
  func loadTrunk()
}

extension Car {
  mutating func openWindows() {
    self.windowsState = .open
  }
}

extension Car {
  mutating func closeDoors() {
    self.doorsState = .closed
  }
}

extension Car {
  mutating func loadTrunk() {
    self.trunkState = .halffull
  }
}

class trunkCar: Car {
  var color: UIColor
  var model: String
  var transmission: Transmission
  var doors: Int?
  var windowsState: Windows
  var trunkState: Trunk
  var doorsState: Doors
  var engineState: Engine
  //отличающиеся свойства height и tonnage
  var height: Double
  var tonnage: Double
  func move() {
    print("I'm moving!")
  }
  //получается нужно заново определять реализацию методов протокола в классе? почему-то реализация по умолчанию через экстеншн не сработала
  func openWindows() {
    self.windowsState = .open
  }
  func closeDoors() {
    self.doorsState = .closed
  }
  func loadTrunk() {
     self.trunkState = .halffull
  }
  init(color: UIColor, model: String, transmission: Transmission, doors: Int? = nil, windowsState: Windows, trunkState: Trunk, doorsState: Doors, engineState: Engine, height: Double, tonnage: Double) {
    self.color = color
    self.model = model
    self.transmission = transmission
    self.doors = doors ?? 2
    self.windowsState = windowsState
    self.trunkState = trunkState
    self.doorsState = doorsState
    self.engineState = engineState
    self.height = height
    self.tonnage = tonnage
  }
}
class sportCar: Car {
  var color: UIColor
  var model: String
  var transmission: Transmission
  var doors: Int?
  var windowsState: Windows
  var trunkState: Trunk
  var doorsState: Doors
  var engineState: Engine
  //отличающиеся свойства hatch и maxSpeed
  var hatch: Hatch
  var maxSpeed: Double
  func move() {
    engineState = .start
  }
  func openWindows() {
    self.windowsState = .open
  }
  func closeDoors() {
    self.doorsState = .closed
  }
  func loadTrunk() {
    print("Багажник отсутствует у этой модели")
  }
  init(color: UIColor, model: String, transmission: Transmission, doors: Int? = nil, windowsState: Windows, trunkState: Trunk, doorsState: Doors, engineState: Engine, hatch: Hatch, maxSpeed: Double) {
    self.color = color
    self.model = model
    self.transmission = transmission
    self.doors = doors ?? 2
    self.windowsState = windowsState
    self.trunkState = trunkState
    self.doorsState = doorsState
    self.engineState = engineState
    self.hatch = hatch
    self.maxSpeed = maxSpeed
  }
}

extension trunkCar: CustomStringConvertible {
  var description: String {
    return "Грузовик, модель: \(model), цвет: \(color), трансмиссия: \(transmission), количество дверей: \(doors ?? 2), состояние окон: \(windowsState), состояние багажника: \(trunkState), состояние дверей: \(doorsState), состояние двигателя: \(engineState), высота: \(height), грузоподъемность: \(tonnage)."
  }
}

extension sportCar: CustomStringConvertible {
  var description: String {
    return "Спортивный автомобиль, модель: \(model), цвет: \(color), трансмиссия: \(transmission), количество дверей: \(doors ?? 2), состояние окон: \(windowsState), состояние багажника: \(trunkState), состояние дверей: \(doorsState), состояние двигателя: \(engineState), состояние люка: \(hatch), максимальная скорость: \(maxSpeed)."
  }
}

let trunkCar1 = trunkCar(color: .darkGray, model: "Volvo", transmission: .manual,  windowsState: .closed, trunkState: .halffull, doorsState: .open, engineState: .stop, height: 51.0, tonnage: 3000.0)
let trunkCar2 = trunkCar(color: .black, model: "Mersedes", transmission: .manual, doors: 3, windowsState: .halfopen, trunkState: .full, doorsState: .closed, engineState: .stop, height: 35.0, tonnage: 1500.0)
let sportCar1 = sportCar(color: .blue, model: "McLaren", transmission: .auto, windowsState: .open, trunkState: .empty, doorsState: .closed, engineState: .start, hatch: .open, maxSpeed: 313.0)
let sportCar2 = sportCar(color: .yellow, model: "Bugatti", transmission: .semiauto, doors: 3, windowsState: .closed, trunkState: .empty, doorsState: .closed, engineState: .stop, hatch: .halfopen, maxSpeed: 350.0)

trunkCar2.loadTrunk()
trunkCar1.doorsState = .closed
sportCar1.loadTrunk()
sportCar2.maxSpeed = 370.0

print(trunkCar1.description)
print(trunkCar2.description)
print(sportCar1.description)
print(sportCar2.description)
