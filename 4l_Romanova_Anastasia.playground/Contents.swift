import UIKit

enum ModelMcLaren {
  case F1, P1, MP412C
}

enum ModelVolvo {
  case FE, FL, FM, FH, FMX
}

enum EngineState {
  case on, off
}

enum WindowsState {
  case open, closed
}

enum TrunkState {
  case empty, full
}

enum HatchState {
  case open, closed
}

enum Engine {
  case start, stop
}

enum Windows {
  case open, close
}

enum Trunk {
  case loadStuff, unloadStuff, checkEmptyVolume
}

enum Hatch {
  case open, close
}

class Car {
  let year: Int
  let volumeOfTrunk: Double
  var engineState: EngineState
  var windowsState: WindowsState
  var trunkState: TrunkState
  init(year: Int, volumeOfTrunk: Double, engineState: EngineState, windowsState: WindowsState, trunkState: TrunkState) {
    self.year = year
    self.volumeOfTrunk = volumeOfTrunk
    self.engineState = engineState
    self.windowsState = windowsState
    self.trunkState = trunkState
  }
  func beep() {
  }
  func checkEngine(engine: Engine) {
    switch engine {
    case .start:
      self.engineState = .on
    case .stop:
      self.engineState = .off
    }
  }
  func checkWindows(windows: Windows) {
    switch windows {
    case .open:
      self.windowsState = .open
    case .close:
      self.windowsState = .closed
    }
  }
  func checkTrunk(trunk: Trunk) {
    switch trunk {
    case .loadStuff:
      self.trunkState = .full
    case .unloadStuff:
      self.trunkState = .empty
    default:
      print(trunkState)
    }
  }
}

class trunkCar: Car {
  let model: ModelVolvo
  let height: Double
  let weight: Double
  var loadedVolume: Double
  init(year: Int, volumeOfTrunk: Double, engineState: EngineState, windowsState: WindowsState, trunkState: TrunkState, model: ModelVolvo, height: Double, weight: Double, loadedVolume: Double? = nil) {
    self.model = model
    self.height = height
    self.weight = weight
    if loadedVolume == nil {
      self.loadedVolume = 0
    } else {
      self.loadedVolume = loadedVolume!
    }
    super.init(year: year, volumeOfTrunk: volumeOfTrunk, engineState: engineState, windowsState: windowsState, trunkState: trunkState)
  }
  override func beep() {
    print("BEEEP")
  }
  override func checkTrunk(trunk: Trunk) {
    switch trunk {
      case .loadStuff:
        self.trunkState = .full
      case .unloadStuff:
        self.trunkState = .empty
      case .checkEmptyVolume:
        print("Свободный объем кузова: \(volumeOfTrunk-loadedVolume)")
    }
  }
}

class sportCar: Car {
  let model: ModelMcLaren
  let maxSpeed: Double
  var hatchState: HatchState
  init(year: Int, volumeOfTrunk: Double, engineState: EngineState, windowsState: WindowsState, trunkState: TrunkState, model: ModelMcLaren, maxSpeed: Double, hatchState: HatchState) {
    self.model = model
    self.maxSpeed = maxSpeed
    self.hatchState = hatchState
    super.init(year: year, volumeOfTrunk: volumeOfTrunk, engineState: engineState, windowsState: windowsState, trunkState: trunkState)
  }
  func checkHatch(hatch: Hatch) {
    switch hatch {
    case .open:
      self.hatchState = .open
    case .close:
      self.hatchState = .closed
    }
  }
  override func beep() {
    print("beeeeeeeeep")
  }
  override func checkTrunk(trunk: Trunk) {
    switch trunk {
    default:
      print("У этой модели багажник отсутствует")
    }
  }
}

var sportCar1 = sportCar(year: 2014, volumeOfTrunk: 72.0, engineState: .off, windowsState: .open, trunkState: .empty, model: .MP412C, maxSpeed: 330.0, hatchState: .closed)
var sportCar2 = sportCar(year: 1998, volumeOfTrunk: 90.0, engineState: .on, windowsState: .closed, trunkState: .empty, model: .F1, maxSpeed: 362.0, hatchState: .open)
var truck1 = trunkCar(year: 2013, volumeOfTrunk: 16000.0, engineState: .off, windowsState: .closed, trunkState: .full, model: .FMX, height: 3123.0, weight: 42000.0)
var truck2 = trunkCar(year: 2000, volumeOfTrunk: 13000.0, engineState: .off, windowsState: .closed, trunkState: .empty, model: .FH, height: 3199.0, weight: 7200.0, loadedVolume: 500.0)

sportCar1.checkEngine(engine: .start)
sportCar2.trunkState = .full
sportCar1.beep()
sportCar2.maxSpeed
truck1.checkTrunk(trunk: .unloadStuff)
truck2.windowsState = .open
truck1.loadedVolume
truck2.checkTrunk(trunk: .checkEmptyVolume)

print("McLaren \(sportCar1.model), год выпуска: \(sportCar1.year), объем багажника: \(sportCar1.volumeOfTrunk) л., состояние двигателя: \(sportCar1.engineState), максимальная скорость: \(sportCar1.maxSpeed), состояние люка: \(sportCar1.hatchState)")
print("McLaren \(sportCar2.model), год выпуска: \(sportCar2.year), объем багажника: \(sportCar2.volumeOfTrunk) л., состояние багажника: \(sportCar2.trunkState), максимальная скорость: \(sportCar2.maxSpeed), состояние люка: \(sportCar2.hatchState)")
print("Volvo \(truck1.model), год выпуска: \(truck1.year), объем кузова: \(truck1.volumeOfTrunk) л., состояние окон: \(truck1.windowsState), высота: \(truck1.height)")
print("Volvo \(truck2.model), год выпуска: \(truck2.year), объем кузова: \(truck2.volumeOfTrunk) л., состояние багажника: \(truck2.trunkState), загрузка: \(truck2.loadedVolume)")
