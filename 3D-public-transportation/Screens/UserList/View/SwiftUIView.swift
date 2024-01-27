//
//  SwiftUIView.swift
//  3D-public-transportation
//
//  Created by 정채연 on 1/27/24.
//

import SwiftUI

struct SwiftUIView: View {
    @ObservedObject var userListViewModel: UserListViewModel
    
    var body: some View {
        List(userListViewModel.users) { user in
            UserRow(user: user)
        }
    }
}
