//
//  test.swift
//  ViewsAndModifiers,
//
//  Created by Bartosz Rola on 30/09/2022.
//

import SwiftUI

struct test: View {
        @State private var agreedToTerms = false
        @State private var agreedToPrivacyPolicy = false
        @State private var agreedToEmails = false

        var body: some View {
            let agreedToAll = Binding<Bool>(
                get: {
                    agreedToTerms && agreedToPrivacyPolicy && agreedToEmails
                },
                set: {
                    agreedToTerms = $0
                    agreedToPrivacyPolicy = $0
                    agreedToEmails = $0
                }
            )

            return VStack {
                Toggle("Agree to terms", isOn: $agreedToTerms)
                Toggle("Agree to privacy policy", isOn: $agreedToPrivacyPolicy)
                Toggle("Agree to receive shipping emails", isOn: $agreedToEmails)
                Toggle("Agree to all", isOn: agreedToAll)
            }
        }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
