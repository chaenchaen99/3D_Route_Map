import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // SwiftUI 뷰를 호스팅하는 뷰 컨트롤러를 선언
        var hostingController: UIHostingController<AnyView>?
        
        if #available(iOS 15.0, *) {
            hostingController = UIHostingController(rootView: AnyView(LocateMe()))
        } else {
            hostingController = UIHostingController(rootView: AnyView(Text("iOS 15.0 이상에서만 지원됩니다.")))
        }

        // hostingController를 child로 추가
        if let validHostingController = hostingController {
            addChild(validHostingController)
            validHostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(validHostingController.view)
            
            // Constraints 설정
            NSLayoutConstraint.activate([
                validHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                validHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                validHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                validHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            validHostingController.didMove(toParent: self)
        }
    }
}
