//
//  TabBarView.swift
//  Muvi
//
//  Created by Atakan Atalar on 19.08.2024.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    let tabs: [TabBarItem]
    
    var body: some View {
        HStack {
            ForEach(tabs.indices, id: \.self) { index in
                VStack {
                    Image(selectedTab == index ? tabs[index].selectedIcon : tabs[index].icon)
                    Text(tabs[index].title)
                        .font(.caption)
                        .foregroundColor(selectedTab == index ? .brandPrimary : .highEmphasis)
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    selectedTab = index
                }
            }
        }
        .background(.surfaceDark)
        .padding(.bottom, 24)
    }
}

struct TabBarItem {
    let icon: String
    let selectedIcon: String
    let title: String
}
