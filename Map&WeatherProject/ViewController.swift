import UIKit
import MapKit

final class ViewController: UIViewController {
    
    // MARK: Private
    
    private let map = MKMapView()
    private let locationManager = CLLocationManager()
    private let myLocationButton = UIButton()
    private let weatherInMyLocationButton = UIButton()
    private let location = CLLocationCoordinate2D(latitude: 53.904541, longitude: 27.561523)
 
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupUI()
    }
        // MARK: - API
        
        
        // MARK: - Setups
        
        private func addSubviews() {
            view.addSubview(map)
            view.addSubview(myLocationButton)
            view.addSubview(weatherInMyLocationButton)
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
            weatherInMyLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
            weatherInMyLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            weatherInMyLocationButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            weatherInMyLocationButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        }
        
        private func setupUI() {
             let coordinatesRegion = MKCoordinateRegion(center: location,
                                                       latitudinalMeters: 5000,
                                                       longitudinalMeters: 5000)
            
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
//
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
        }
        
        @objc private func weatherInMyLocation() {
            print("Weather")
        }
    }
    
    
    //добавить аламофаер, запросить погоду по широте и долготе нашей
    //сервер запрашивает через ключи - широта долгота и ар-ИД ключ - погода [:] - было, надо [широта : долгота]
    
