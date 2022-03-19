import Alamofire
struct APIManager {
    static let instance = APIManager()
    static let key: String = "e04eb929d3b6dcb68b39af7948be9fb0"
    
    enum BaseConstant {
        static let baseURL = "https://api.openweathermap.org/data/2.5"
    }
    
    enum EndPoints {
        static let weather = "/weather"
        static let latitude = "?lat="
        static let longitude = "&lon="
        static let appID = "&appid="
    }
    
    enum Metrics {
        static let metric = "&units=metric"
        static let imperial = "&units=imperial"
    }
    
    func getTheWeather(
        myLatitude: Double,
        myLongitude: Double,
        completion: @escaping ((DataOfTheWeather) -> Void)) {
            AF.request(BaseConstant.baseURL +
                       EndPoints.weather +
                       EndPoints.latitude +
                       "\(myLatitude)" +
                       EndPoints.longitude +
                       "\(myLongitude)" +
                       EndPoints.appID +
                       APIManager.key +
                       Metrics.metric
            ).responseDecodable(of: DataOfTheWeather.self) {
                response in
                switch response.result {
                case .success(let model):
                    completion(model)
                case.failure(let error):
                    print(error)
                }
            }
        }
    
    private init() { }
}
