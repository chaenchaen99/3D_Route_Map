//
//  ContentView.swift
//  3D-public-transportation
//
//  Created by 정채연 on 1/27/24.
//

import Foundation
import SwiftUI

//@ObservedObject - @Observable프로토콜을 준수하는 객체의 변경을 감시
struct ContentView: View {
    @ObservedObject var userListViewModel: UserListViewModel
    
    var body: some View {
        List(userListViewModel.users) { user in
            UserRow(user: user)
        }
    }
}

struct UserRow: View {
    var user: User
    
    var body: some View {
        Text(user.name)
    }
}
