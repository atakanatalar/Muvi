//
//  AppTabView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct AppTabView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    @State var isShowingOnboardView: Bool = false
    @State var selectedTab = 0
    
    let tabs = [
        TabBarItem(icon: "icon_home", selectedIcon: "icon_home_selected", title: "Home"),
        TabBarItem(icon: "icon_search", selectedIcon: "icon_search_selected", title: "Search"),
        TabBarItem(icon: "icon_folder", selectedIcon: "icon_folder_selected", title: "List"),
        TabBarItem(icon: "icon_grid", selectedIcon: "icon_grid_selected", title: "More")
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack { HomeView() }
                    .tag(0)
                
                NavigationStack { SearchView() }
                    .tag(1)
                
                NavigationStack { ListView() }
                    .tag(2)
                
                NavigationStack { MoreView() }
                    .tag(3)
            }
            
            VStack(spacing: 0) {
                Divider()
                    .background(Color(.separator))
                TabBarView(selectedTab: $selectedTab, tabs: tabs)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            if isFirstTime {
                DispatchQueue.main.async() { isShowingOnboardView = true }
            }
        }
        .fullScreenCover(isPresented: $isShowingOnboardView) {
            OnboardView(isShowingOnboardView: $isShowingOnboardView)
        }
    }
}

#Preview {
    AppTabView()
}
