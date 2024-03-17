//
//  BusViewModel.swift
//  3d-public-transportation
//
//  Created by 정채연 on 3/13/24.
//

import Foundation
import Combine

class BusViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    func printBusList() {
        APIService.fetchBusListAfterBusStop()
            .sink { compeletion in
                switch compeletion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: {
                print($0.response.body.items.item)
            }
            .store(in: &cancellables)
    }
}
