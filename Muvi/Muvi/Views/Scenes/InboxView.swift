//
//  InboxView.swift
//  Muvi
//
//  Created by Atakan Atalar on 29.08.2024.
//

import SwiftUI

struct InboxView: View {
    var body: some View {
        ZStack {
            Color.surfaceDark.ignoresSafeArea()
            
            VStack {
                List(Notification.notifications) { notification in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(notification.title)
                                .font(.headline)
                                .foregroundStyle(.surfaceWhite)
                            Spacer()
                            Text(notification.date)
                                .font(.caption)
                                .foregroundColor(.mediumEmphasis)
                        }
                        
                        Text(notification.description)
                            .font(.subheadline)
                            .foregroundColor(.highEmphasis)
                            .lineLimit(2)
                    }
                    .listRowBackground(Color.surfaceDark)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .listRowSpacing(8)
            }
        }
        .navigationBar(inlineTitle: "Inbox")
    }
}

#Preview {
    InboxView()
}

struct Notification: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: String
}

extension Notification {
    static let notifications: [Notification] = [
        Notification(
            title: "New Movie Release",
            description: "A new movie has been released on the platform. Check out the latest addition to our collection and start watching now.",
            date: "29.08.2024, 13:40"
        ),
        Notification(
            title: "Update Available",
            description: "A new update for the app is available. We recommend updating to the latest version to enjoy new features and improvements.",
            date: "28.08.2024, 10:20"
        ),
        Notification(
            title: "Upcoming Movie",
            description: "An exciting new movie is coming soon! Stay tuned for the release date and be the first to watch the latest blockbuster.",
            date: "27.08.2024, 19:14"
        )
    ]
}
