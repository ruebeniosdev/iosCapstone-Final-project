//
//  UserProfile.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ViewModel()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
    //            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
                VStack(alignment: .leading, spacing: 20) {
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("avatar")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    Text("First Name: \(vm.firstName)")
                        .fontWeight(.semibold)
                    Text("Last Name: \(vm.lastName)")
                        .fontWeight(.semibold)
                    Text("Email: \(vm.email)")
                        .fontWeight(.semibold)
                }
                Spacer()
                Button("Logout", action: logout)
                    .buttonStyle(LogOutButton())
                    .padding(.vertical, 100)
            }
            .padding(.horizontal)
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }
    func logout() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
        dismiss()
        UserDefaults.resetStandardUserDefaults()
    }
    
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
