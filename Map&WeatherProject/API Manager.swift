import Alamofire
struct APIManager {
    static let instance = APIManager()
    
    enum BaseConstant {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }
    
    enum EndPoints {
        static let weather = "/weather"
    }
    
    func getDataAboutTheWeather(
        myLatitude: Double,
        myLongitude: Double,
        completion: @escaping ((DataOfTheWeather) -> Void)
    ) {
        let header: HTTPHeaders = [
            "lat" : "\(myLatitude)",
            "lon" : "\(myLongitude)",
            "appid": "7e3a861f881c64170c31b5490ed80a34"
        ]
        AF.request(
            BaseConstant.baseURL + EndPoints.weather,
            method: .get,
            parameters: [:],
            headers: header
        ).responseDecodable(
            of: DataOfTheWeather.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case.failure(let error):
                    print(error)
                }
            }
    }

    private init() { }
}

