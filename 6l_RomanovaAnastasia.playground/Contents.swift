import UIKit

enum IphoneModels {
  case XS, XS_Max, XR
}

enum SamsungModels {
  case S8, S8plus, S9, S9plus
}

enum Parameter {
  case screen, memory, price
}

protocol Features {
  var screen: Double {get}
  var memory: Double {get}
  var price: Double {get}
}

class Iphone: Features {
  let screen: Double
  let memory: Double
  let model: IphoneModels
  var price: Double {
    get {
      if self.model != .XR {
      return screen * memory * 100
      }
      else {
        return screen * memory * 50
      }
    }
  }
  init (screen: Double, memory: Double, model: IphoneModels) {
    self.screen = screen
    self.memory = memory
    self.model = model
  }
}

class Samsung: Features {
  let screen: Double
  let memory: Double
  let model: SamsungModels
  var price: Double {
    get {
      if self.model == .S9 || self.model == .S9plus {
        return screen * memory * 200
      }
      else {
        return screen * memory * 100
      }
    }
  }
  init (screen: Double, memory: Double, model: SamsungModels) {
    self.screen = screen
    self.memory = memory
    self.model = model
  }
}

struct Stack<T: Features> {
  private var phones: [T] = []
  mutating func push (_ phone: T) {
    phones.append(phone)
  }
  mutating func pop() -> T? {
    return phones.removeLast()
  }
  func count() -> Int {
    return phones.count
  }
  var totalPrice: Double {
    var price = 0.0
    for phone in phones {
      price += phone.price
    }
    return price
  }
  //функция для вывода описания элементов стэка в читаемом виде
  //вопрос: поскольку эта функция написана к структуре, я не могу ее применить к массивам в дальнейшем коде и приходится дублировать код для массивов. Как я могу определить эту функцию один раз для массивов? пробовала написать экстеншн для Array, не подошло, т.к. аргументы этой функции (phone и phones) существуют только внутри структуры
  func description() -> String {
    var description: String = ""
    for phone in phones {
      description += "Телефон \(T.self), объем памяти: \(phone.memory), экран: \(phone.screen), цена: \(phone.price).\n"
    }
    return description
  }
  subscript (phones: Int...) -> Double? {
    var price = 0.0
    for index in phones {
      if index > self.phones.count || index < 0 {
        return nil
      }
      else {
        price += self.phones[index].price
      }
    }
    return price
  }
  //фильтрация элементов стека по заданному параметру, возвращает строку для читаемого вывода в консоль
  func filter (parameter: Parameter, value: ((Double) -> Bool)) -> String {
    var tmpStack = Stack<T>()
    for phone in phones {
      if parameter == .price {
        if value(phone.price) {
          tmpStack.push(phone)
        }
      }
      else if parameter == .memory {
        if value(phone.memory) {
          tmpStack.push(phone)
        }
      }
      else if parameter == .screen {
        if value(phone.screen) {
          tmpStack.push(phone)
        }
      }
    }
    return tmpStack.description()
  }
  //сортировка
  func sort (method: ((Features, Features) -> Bool)) -> String {
    var description = ""
    //ввожу доп массив phonesSorted, т.к. массив phones почему-то не меняется по итогам сортировки, и в description записывается старый порядок данных в массиве
    var phonesSorted: [T] = []
    phonesSorted = phones.sorted(by: method)
    for phone in phonesSorted {
      description += "Телефон \(T.self), объем памяти: \(phone.memory), экран: \(phone.screen), цена: \(phone.price).\n"
    }
    return description
  }
  //расчет цены в валюте, возвращаю строку с данными массива для вывода в консоль
  func priceInCurrency (currency: ((Double) -> Double)) -> String {
    var description = ""
    var newPrices: [Double] = []
    for phone in phones {
      newPrices.append(currency(phone.price))
    }
    var i: Int = 0
    for phone in phones {
      description += "Телефон \(T.self), объем памяти: \(phone.memory), экран: \(phone.screen), цена: \(phone.price), цена в валюте: \(round(newPrices[i])).\n"
      i += 1
    }
    return description
  }
}

var stackIphones = Stack<Iphone>()
stackIphones.push(Iphone(screen: 5.8, memory: 64, model: .XS))
stackIphones.push(Iphone(screen: 6.5, memory: 256, model: .XS_Max))
stackIphones.push(Iphone(screen: 6.1, memory: 128, model: .XR))
stackIphones.push(Iphone(screen: 6.5, memory: 512, model: .XS_Max))
stackIphones[2]
stackIphones[3]
stackIphones[0,3]
stackIphones[5]

var stackSamsungs = Stack<Samsung>()
stackSamsungs.push(Samsung(screen: 5.8, memory: 64, model: .S9))
stackSamsungs.push(Samsung(screen: 6.2, memory: 256, model: .S9plus))
stackSamsungs.push(Samsung(screen: 5.8, memory: 64, model: .S8))
stackSamsungs.push(Samsung(screen: 6.2, memory: 64, model: .S8plus))
stackSamsungs.push(Samsung(screen: 6.2, memory: 128, model: .S8plus))

print(stackIphones.filter(parameter: .price) { $0 >= 50000 })
print(stackSamsungs.filter(parameter: .screen, value: { $0 == 6.2}))
print(stackIphones.sort(method: { $0.screen > $1.screen }))
print(stackSamsungs.sort(method: { $0.price < $1.price}))
var dollar = 65.54
print(stackIphones.priceInCurrency(currency: { $0 / dollar }))
var euro = 76.10
print(stackSamsungs.priceInCurrency(currency: { $0 / euro }))
