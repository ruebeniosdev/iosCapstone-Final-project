//
//  Onboarding.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

struct Onboarding: View {
    @StateObject private var vm = ViewModel()
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var isLoggedIn = false
    var body: some View {
        NavigationStack {
                VStack {
                    Header()
                        VStack(spacing: 16) {
                            Text("First name *")
                                .onboardingTextStyle()
                            TextField("First Name", text: $firstName)
                            Text("Last name *")
                                .onboardingTextStyle()
                            TextField("Last Name", text: $lastName)
                            Text("E-mail *")
                                .onboardingTextStyle()
                            TextField("E-mail", text: $email)
                                .keyboardType(.emailAddress)
                        }
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                        .padding()
                        Button("Register") {
                            if vm.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                UserDefaults.standard.set(true, forKey: kOrderStatuses)
                                UserDefaults.standard.set(true, forKey: kPasswordChanges)
                                UserDefaults.standard.set(true, forKey: kSpecialOffers)
                                UserDefaults.standard.set(true, forKey: kNewsletter)
                                firstName = ""
                                lastName = ""
                                email = ""
                                isLoggedIn = true
                            } else {
                                vm.showAlert = true
                                vm.alertMessage = "Please fill in all the required fields."
                            }
                        }
                        .fontWeight(.bold)
                        .buttonStyle(ButtonStyleYellowColorWide())
                        
                        Spacer()
                }
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Error"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
                }
                .onAppear() {
                    if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                        isLoggedIn = true
                    }
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    Home()
                        .navigationBarBackButtonHidden(true)
                }
                
                
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
