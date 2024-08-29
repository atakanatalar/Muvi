//
//  HelpFAQView.swift
//  Muvi
//
//  Created by Atakan Atalar on 29.08.2024.
//

import SwiftUI

struct HelpFAQView: View {
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            List {
                ForEach(FAQItem.items) { item in
                    DisclosureGroup(
                        content: {
                            Text(item.answer)
                                .font(.subheadline)
                                .foregroundColor(.highEmphasis)
                                .padding(.vertical, -16)
                        },
                        label: {
                            Text(item.question)
                                .font(.headline)
                                .foregroundStyle(.surfaceWhite)
                        }
                    )
                    .listRowBackground(Color.surfaceDark)
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
        }
        .navigationBar(inlineTitle: "Help & FAQ")
    }
}

#Preview {
    HelpFAQView()
}

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

extension FAQItem {
    static let items: [FAQItem] = [
        FAQItem(
            question: "What is Muvi?",
            answer: "Muvi is an innovative platform designed to provide users with seamless access to a wide variety of movies and shows."
        ),
        FAQItem(
            question: "How do I sign up?",
            answer: "You can sign up by tapping on the 'Sign Up' button on the home screen and following the on-screen instructions."
        ),
        FAQItem(
            question: "How can I reset my password?",
            answer: "To reset your password, go to the login screen and tap on 'Forgot Password'. Follow the instructions sent to your registered email."
        ),
        FAQItem(
            question: "How do I contact customer support?",
            answer: "You can contact our customer support by going to the 'Contact Us' section in the app's settings."
        ),
        FAQItem(
            question: "What should I do if I encounter a technical issue?",
            answer: "If you encounter a technical issue, please try restarting the app or your device. If the issue persists, contact our support team."
        )
    ]
}
