import SwiftUI
import MapKit
import SceneKit

struct MapWith3DOverlayView: View {
    var body: some View {
        ZStack(alignment: .top) {
            MapView()
                .ignoresSafeArea(edges: .all)
            
            SceneView(scene: makeScene(),
                      options: [.autoenablesDefaultLighting, .allowsCameraControl])
                .frame(width: 200, height: 200) // 적절한 프레임을 설정하세요.
                .background(Color.clear) // 배경을 투명하게 만들어 지도와 잘 어우러지도록 합니다.
        }
    }

    private func makeScene() -> SCNScene {
        let scene = SCNScene(named: "Assets/Car.scn")!  // 모델 파일 이름을 정확히 사용하세요.
        // Scene 설정 기타 등등...
        return scene
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // 주의: 실제 앱에서는 사용자의 위치나 관심 영역으로 지도의 보기 영역을 설정해야 할 수 있습니다.
    }
}

// ContentView.swift에서 사용하기
struct ContentView: View {
    var body: some View {
        MapWith3DOverlayView()
    }
}

// 미리보기 제공
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
