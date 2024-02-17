import SceneKit
import MapKit

class BearingManager: UIViewController, CLLocationManagerDelegate {

    var carNode: SCNNode!
    var locationManager: CLLocationManager!
    var lastLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 3D 모델 초기화
        let scene = SCNScene(named: "car.dae")!
        carNode = scene.rootNode.childNode(withName: "car", recursively: true)!
        
        // 위치 관리자 설정
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    // 위치 업데이트 처리
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }

        // 처음 위치 설정
        if lastLocation == nil {
            lastLocation = newLocation
        }

        // 이전 위치와 새로운 위치 사이의 각도 계산
        let bearing = getBearingBetweenTwoPoints(point1: lastLocation!, point2: newLocation)
        
        // 3D 모델 회전
        carNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: Float(bearing))

        // 위치 업데이트
        lastLocation = newLocation
    }

    // 두 위치 사이의 각도 계산
    func getBearingBetweenTwoPoints(point1: CLLocation, point2: CLLocation) -> Double {
        let lat1 = point1.coordinate.latitude.toRadians()
        let lon1 = point1.coordinate.longitude.toRadians()

        let lat2 = point2.coordinate.latitude.toRadians()
        let lon2 = point2.coordinate.longitude.toRadians()

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        let radiansBearing = atan2(y, x)

        return radiansBearing.toDegrees()
    }
}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180
    }

    func toDegrees() -> Double {
        return self * 180 / .pi
    }
}
