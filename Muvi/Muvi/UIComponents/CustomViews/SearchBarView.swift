//
//  SearchBarView.swift
//  Muvi
//
//  Created by Atakan Atalar on 23.08.2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(.iconSearchSelected)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)
            
            TextField("", text: $searchText, prompt: Text("Movie, TV Show").foregroundStyle(.mediumEmphasis))
                .foregroundStyle(.surfaceWhite)
                .autocorrectionDisabled()
                .overlay(
                    Image(.iconXCircle)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.lowEmphasis)
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
        SearchBarView(searchText: .constant(""))
}
