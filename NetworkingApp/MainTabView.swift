//
//  TabView.swift
//  NetworkingApp
//
//  Created by David Adekunle on 03/03/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Profile", systemImage: "person.fill"){
                GHProfileView()
            }
            .badge(1)
            
            Tab("TipCalculator" , systemImage: "iphone.gen3"){
                TipCalculatorView()
            }
            .badge("!")
        }
    }
}

#Preview {
    MainTabView()
}
