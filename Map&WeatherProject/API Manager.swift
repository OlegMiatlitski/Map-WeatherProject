import Alamofire
struct APIManager {
    static let instance = APIManager()
    
    enum BaseConstant {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }
    
    enum EndPoints {
        static let weather = "/weather"
    }
    
    func getTheWeather(
        myLatitude: Double,
        myLongitude: Double,
        completion: @escaping ((DataOfTheWeather) -> Void)) {
            let key: String = "e04eb929d3b6dcb68b39af7948be9fb0"
            AF.request(BaseConstant.baseURL +
                       EndPoints.weather +
                       "?lat=\(myLatitude)&lon=\(myLongitude)&appid=\(key)")
                .responseDecodable(of: DataOfTheWeather.self) {
                    response in
                    switch response.result {
                    case .success(let model):
                        completion(model)
                    case.failure(let error):
                        print(error)
                    }
                }
        }
    
    
    func getDataAboutTheWeather(
        myLatitude: Double,
        myLongitude: Double,
        completion: @escaping ((DataOfTheWeather) -> Void)
    ) {
        let header: HTTPHeaders = [
            "lat" : "\(myLatitude)",
            "lon" : "\(myLongitude)",
            "appid": "e04eb929d3b6dcb68b39af7948be9fb0"
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

