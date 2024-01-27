//
//  UserViewModel.swift
//  3D-public-transportation
//
//  Created by 정채연 on 1/27/24.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = [
        User(id: 1, name: "User1"),
        User(id: 2, name: "User2"),
        User(id: 3, name: "User3")
    ]
}
