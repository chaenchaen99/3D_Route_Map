//
//  BusUIViewController.swift
//  3d-public-transportation
//
//  Created by 정채연 on 3/13/24.
//

import UIKit

import SwiftUI
import UIKit

class BusUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SwiftUI 뷰 생성
        let busView = BusView()
        
        // SwiftUI 뷰를 호스팅할 UIHostingController 생성
        let hostingController = UIHostingController(rootView: busView)
        
        // UIHostingController를 현재 UIViewController에 추가
        // 여기서는 addChild와 didMove를 사용하여 추가하지만,
        // 상황에 따라 present 또는 navigationController?.pushViewController를 사용할 수 있음
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // UIHostingController의 뷰 크기 및 위치 설정
        // Auto Layout을 사용하거나, 직접 frame을 설정할 수 있음
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

