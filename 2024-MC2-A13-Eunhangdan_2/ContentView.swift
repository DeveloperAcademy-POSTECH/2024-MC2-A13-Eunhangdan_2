//
//  ContentView.swift
//  2024-MC2-A13-Eunhangdan_2
//
//  Created by marty.academy on 5/21/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            BoxesContainerView()
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Boxes")
                }
            
            MinifigureTabView()
                .tabItem {
                    Image(systemName: "batteryblock")
                    Text("Minifigures")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            MyPageView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("My Page")
                }
            
        } // TabView
        .onAppear {    // 탭바 백그라운드 투명화 방지 코드
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

#Preview {
    //ContentView()
    MinifigureTabView()
}
