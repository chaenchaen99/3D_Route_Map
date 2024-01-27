//
//  UserListViewModel.swift
//  3D-public-transportation
//
//  Created by 정채연 on 1/27/24.
//

import Foundation
// ObservableObject - 해당 객체의 상태가 변경될 때마다 등록된 관찰자에게 알림을 보냄
// @Published - 변수가 변경될 때마다 알림을 보내는 역할
class UserListViewModel: ObservableObject {
    @Published var users: [User] = [
        User(id: 1, name: "User1"),
        User(id: 2, name: "User2"),
        User(id: 3, name: "User3")
    ]
}
