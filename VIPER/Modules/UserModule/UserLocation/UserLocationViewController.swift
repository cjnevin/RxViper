import UIKit
import CoreLocation
import MapKit

class UserLocationViewController<T: DismissModalNavigating>: UIViewController, UserLocationView {
    private lazy var mapView: MKMapView = MKMapView()
    
    var presenter: UserLocationPresenter<UserLocationViewController, T>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter?.attachView(self)
    }
    
    deinit {
        presenter?.detachView()
    }
    
    private func layout() {
        view.backgroundColor = .white
        
        layoutMapView()
    }
    
    func setUserLocation(_ userLocation: UserLocation) {
        mapView.setUserLocation(userLocation)
    }
}

private extension UserLocationViewController {
    private func layoutMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension MKMapView {
    func setUserLocation(_ userLocation: UserLocation) {
        removeAnnotations(annotations.filter {
            $0 is MKPlacemark
        })
        
        CLGeocoder().reverseGeocodeLocation(userLocation.location) { [weak self] placemark, error in
            guard let `self` = self else { return }
            if let placemark = placemark?.first {
                self.addAnnotation(MKPlacemark(placemark: placemark))
            }
        }
        centerCoordinate = userLocation.coordinate
    }
}
