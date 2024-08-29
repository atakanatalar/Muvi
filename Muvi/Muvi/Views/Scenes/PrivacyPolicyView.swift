//
//  PrivacyPolicyView.swift
//  Muvi
//
//  Created by Atakan Atalar on 29.08.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.surfaceDark.ignoresSafeArea()
            
            ScrollView() {
                VStack(alignment: .leading, spacing: 12) {
                    PrivacyPolicyTextTitle()
                    PrivacyPolicyText()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBar(inlineTitle: "Privacy & Policy")
    }
}

#Preview {
    PrivacyPolicyView()
}

struct PrivacyPolicyTextTitle: View {
    var body: some View {
        Text("Muvi - Privacy & Policy")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.surfaceWhite)
    }
}

struct PrivacyPolicyText: View {
    var body: some View {
        Text("""
This Privacy Policy outlines how your personal information is collected, used, and protected when you use the Muvi platform. Your privacy is important to us, and we take all necessary measures to ensure the security of your information.

1. Information Collected
We may collect various types of information from you when you use Muvi, including:

- Personal Information: Information that directly identifies you, such as your name, email address, and phone number.
- Automatically Collected Information: Information that is automatically collected about your interaction with our site, such as cookies, IP address, device details, and browsing behavior.

2. Use of Information
We may use the information we collect for the following purposes:

- To provide and improve our services,
- To offer customer support,
- To deliver personalized content and recommendations,
- To fulfill our legal obligations.

3. Sharing of Information
We do not share your personal information with third parties, except in the following circumstances:

- When required by law,
- With business partners and vendors necessary to provide our services,
- To ensure the safety of our users.

4. Security of Information
We employ industry-standard security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction. However, no data transmission over the internet can be guaranteed to be 100% secure.

5. Cookies
Our website uses cookies to enhance your user experience and analyze our services. For more information on how we use cookies, please review our Cookie Policy.

6. User Rights
You have the right to access, correct, or delete your personal information. If you wish to exercise these rights, please contact us.

7. Changes
This Privacy Policy may be updated from time to time. If we make any changes, we will notify you of those changes.

8. Contact
If you have any questions or concerns about our Privacy Policy, please contact us at: email@muvi.com
""")
        .font(.subheadline)
        .foregroundStyle(.highEmphasis)
    }
}
