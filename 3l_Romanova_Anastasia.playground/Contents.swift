import UIKit

enum ModelBentley {
    case continental, bentayaga, flyingSpur, mulsanne
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

enum Engine {
    case start, stop
}

enum Windows {
    case open, close
}

enum Trunk {
    case loadStuff, unloadStuff
}

struct Bentley {
    let model: ModelBentley
    let year: Int
    let volumeOfTrunk: Double
    var engineState: EngineState
    var windowsState: WindowsState
    var trunkState: TrunkState
    mutating func checkEngine(engine: Engine) {
        switch engine {
        case .start:
            self.engineState = .on
        case .stop:
            self.engineState = .off
        }
        
    }
}

struct Volvo {
    let model: ModelVolvo
    let year: Int
    let volumeOfTrunk: Double
    var engineState: EngineState
    var windowsState: WindowsState
    var trunkState: TrunkState
    mutating func checkTrunk(trunk: Trunk) {
        switch trunk {
        case .loadStuff:
            self.trunkState = .full
        case .unloadStuff:
            self.trunkState = .empty
        }
    }
}

var car1 = Bentley(model: .continental, year: 2015, volumeOfTrunk: 358.0, engineState: .off, windowsState: .open, trunkState: .empty)
var car2 = Bentley(model: .bentayaga, year: 2017, volumeOfTrunk: 484.0, engineState: .on, windowsState: .closed, trunkState: .empty)
var truck1 = Volvo(model: .FMX, year: 2013, volumeOfTrunk: 16000.0, engineState: .off, windowsState: .closed, trunkState: .full)
var truck2 = Volvo(model: .FH, year: 2000, volumeOfTrunk: 13000.0, engineState: .off, windowsState: .closed, trunkState: .empty)

car1.checkEngine(engine: .start)
car2.trunkState = .full
truck1.checkTrunk(trunk: .unloadStuff)
truck2.windowsState = .open

print("Bentley \(car1.model), год выпуска: \(car1.year), объем багажника: \(car1.volumeOfTrunk) л., состояние двигателя: \(car1.engineState)")
print("Bentley \(car2.model), год выпуска: \(car2.year), объем багажника: \(car2.volumeOfTrunk) л., состояние багажника: \(car2.trunkState)")
print("Volvo \(truck1.model), год выпуска: \(truck1.year), объем кузова: \(truck1.volumeOfTrunk) л., состояние окон: \(truck1.windowsState)")
print("Volvo \(truck2.model), год выпуска: \(truck2.year), объем кузова: \(truck2.volumeOfTrunk) л., состояние багажника: \(truck2.trunkState)")
