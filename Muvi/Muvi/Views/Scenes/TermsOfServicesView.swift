//
//  TermsOfServicesView.swift
//  Muvi
//
//  Created by Atakan Atalar on 29.08.2024.
//

import SwiftUI

struct TermsOfServicesView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    TermsOfServicesTextTitle()
                    TermsOfServicesText()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBar(inlineTitle: "Terms Of Services")
    }
}

#Preview {
    TermsOfServicesView()
}

struct TermsOfServicesTextTitle: View {
    var body: some View {
        Text("Muvi - Terms of Services")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.surfaceWhite)
    }
}

struct TermsOfServicesText: View {
    var body: some View {
        Text("""
Terms of service are a set of guidelines and rules that must be honored by an organization or an individual if they want to use a certain service. In general, terms of service agreement is legally binding, but if it violates some law on a local, or federal level it's not.

Terms of service are subjected to change and if they do change, the person or the company providing a service needs to notify all the users in a timely manner.

Websites and mobile apps that only provide their visitors with information or sell products usually don't require terms of service, but if we are talking about providers that offer services online or on a site that will keep the user's personal data, then the terms of service agreement is required.

Some of the broadest examples where the terms of service agreement is mandatory include social media, financial transaction websites and online auctions.
""")
        .font(.subheadline)
        .foregroundStyle(.highEmphasis)
    }
}
