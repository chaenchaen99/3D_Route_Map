//
//  BusView.swift
//  3d-public-transportation
//
//  Created by 정채연 on 3/13/24.
//

import SwiftUI

struct BusView: View {
    @StateObject var busList: BusViewModel = BusViewModel()
    
    var body: some View {
        Button(action: {
            busList.printBusList()
        }, label: {
            Text("버스 도착 정보")
        })
    }
}
