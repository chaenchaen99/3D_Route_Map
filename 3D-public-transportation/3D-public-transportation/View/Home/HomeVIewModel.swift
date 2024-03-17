//
//  HomeVIew.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/21/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    enum ViewState {
        case START
        case LOADING
        case SUCCESS(users: [User])
        case FAILURE(error: String)
    }

    //초기상태는 .START
    @Published var currentState: ViewState = .START
    
    //이 프로퍼티는 Combine 프레임워크에서 사용하는 Cancellable 객체들을 저장한다.
    //이 객체들을 저장해두지 않으면, 비동기 작업이 즉시 취소되어 결과를 받을 수 없게 된다.
    private var cancelables = Set<AnyCancellable>()

    init() {
        getUsers()
    }

    func getUsers() {
        //로딩 상태로 변경
        self.currentState = .LOADING
        
        APIService.shared.getUsers()
            .sink { completion in
                switch completion {
                case .finished:
                    //.finished는 Publisher가 성공적으로 완료되었음을 나타냄
                    print("Execution Finihsed.")
                case .failure(let error):
                    //에러가 발생하면 현재 상태를 FAILURE로 설정하고 에러 메시지를 저장
                    self.currentState = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { users in
                //사용자 정보를 성공적으로 받으면 현재 상태를 SUCCESS로 설정하고 사용자 정보를 저장
                self.currentState = .SUCCESS(users: users)
               // Cancellable 객체를 저장한다. 이 객체를 저장해두지 않으면, 비동기 작업이 즉시 취소되어 결과를 받을 수 없게 된다.
            }.store(in: &cancelables)
    }
}
