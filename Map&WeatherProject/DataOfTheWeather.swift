import Foundation
struct DataOfTheWeather: Codable {
    let main: Main
}
struct Main: Codable {
    let temp: Double
}
