import UIKit
import MapKit

final class ViewController: UIViewController {
    
    // MARK: Private
    
    private let map = MKMapView()
    private let locationManager = CLLocationManager()
    private let myLocationButton = UIButton()
    private let weatherInMyLocationButton = UIButton()
    private let weatherButton = UIButton()
    private let location = CLLocationCoordinate2D(latitude: 53.904541, longitude: 27.561523)
    private var selectedLatitude: Double = 0.0
    private var selectedLongitude: Double = 0.0
    private var topAnchor: Int = -100
    private var topConstraints = NSLayoutConstraint()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupUI()
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(map)
        view.addSubview(myLocationButton)
        view.addSubview(weatherInMyLocationButton)
        view.addSubview(weatherButton)
    }
    
    private func addConstraints() {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        myLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        myLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        myLocationButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        weatherInMyLocationButton.translatesAutoresizingMaskIntoConstraints = false
        weatherInMyLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        weatherInMyLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        weatherInMyLocationButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        weatherInMyLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        weatherButton.translatesAutoresizingMaskIntoConstraints = false
        weatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        weatherButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        topConstraints = weatherButton.topAnchor.constraint(equalTo: view.topAnchor, constant: -30)
        topConstraints.isActive = true
        
    }
    
    private func setupUI() {
        
        weatherButton.backgroundColor = .systemBlue
        weatherButton.setTitleColor(.white, for: .normal)
        weatherButton.layer.masksToBounds = false
        weatherButton.layer.cornerRadius = 15
        weatherButton.layer.shadowColor = UIColor.black.cgColor
        weatherButton.layer.shadowOpacity = 0.6
        weatherButton.layer.shadowRadius = 4.0
        weatherButton.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        
        let coordinatesRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        map.setRegion(coordinatesRegion, animated: true)
        
        let configuratorForMyLocationButton = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .bold,
            scale: .large
        )
        let myLocationButtonImage = UIImage(
            systemName: "location.circle.fill",
            withConfiguration: configuratorForMyLocationButton
        )
        
        myLocationButton.setImage(
            myLocationButtonImage,
            for: .normal
        )
        
        myLocationButton.addTarget(
            self,
            action: #selector(myLocationDidTapped),
            for: .touchUpInside
        )
        
        let configuratorForWeatherButton = UIImage.SymbolConfiguration(
            pointSize: 40,
            weight: .bold,
            scale: .large
        )
        
        let weatherButtonImage = UIImage(
            systemName: "cloud.sun",
            withConfiguration: configuratorForWeatherButton
        )
        
        weatherInMyLocationButton.setImage(
            weatherButtonImage,
            for: .normal
        )
        
        weatherInMyLocationButton.addTarget(
            self,
            action: #selector(weatherInMyLocation),
            for: .touchUpInside
        )
    }
    
    // MARK: - Helpers
    
    @objc private func myLocationDidTapped() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.showsUserLocation = true
        let myLatitude = locationManager.location?.coordinate.latitude
        let myLongitude = locationManager.location?.coordinate.longitude
        let myLocation = CLLocationCoordinate2D(
            latitude: myLatitude ?? 53.904541,
            longitude: myLongitude ?? 27.561523
        )
        let coordinatesRegion = MKCoordinateRegion(
            center: myLocation,
            latitudinalMeters: 300,
            longitudinalMeters: 300
        )
        map.setRegion(coordinatesRegion, animated: true)
        
        let pointInMyLocation = MKPointAnnotation()
        pointInMyLocation.coordinate = CLLocationCoordinate2D(
            latitude: myLatitude ?? 53.904541,
            longitude: myLongitude ?? 27.561523
        )
        pointInMyLocation.title = "My location"
        map.addAnnotation(pointInMyLocation)
        
        selectedLatitude = myLatitude ?? 53.904541
        selectedLongitude = myLongitude ?? 27.561523
    }
    
    @objc private func weatherInMyLocation() {
        topConstraints.constant = 50
        self.view.layoutIfNeeded()
        APIManager.instance.getTheWeather(
            myLatitude: selectedLatitude,
            myLongitude: selectedLongitude) { data in
                self.weatherButton.setTitle("\(data.main.temp) °C", for: .normal)
                print("The temperature in your location is \(data.main.temp) °C.")
            }
    }
}
