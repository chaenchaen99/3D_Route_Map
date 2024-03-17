//
//  HomeView.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/21/24.
//

import SwiftUI

struct HomeView: View {
    
    //viewModel의 변경 사항을 감지하고, UI를 업데이트할 수 있다.
    @ObservedObject var viewModel = HomeViewModel()

    var body: some View {
        //GeometryReader를 사용하여 화면의 크기를 얻고, viewModel.currentState의 상태에 따라 다른 뷰를 표시
        GeometryReader { geometry in
            if case .LOADING = viewModel.currentState {
                loaderView()
            } else if case .SUCCESS(let users) = viewModel.currentState {
                List(users) { user in
                    userCell(user: user)
                        .frame(width: geometry.size.width-20, height: 80)
                }
            } else if case .FAILURE(let error) = viewModel.currentState {
                VStack(alignment: .center) {
                    Spacer()
                    Text(error)
                        .font(.headline.bold())
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
            }
        }
    }

    func userCell(user: User) -> some View {
        HStack(spacing: 40) {
            AsyncImage(url: URL(string: user.avatar_url ?? "Unknown user")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60, alignment: .center)
            .clipShape(Circle())

            Text(user.login ?? "")
                .font(.headline)
            Spacer()
        }
    }

    func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
}
