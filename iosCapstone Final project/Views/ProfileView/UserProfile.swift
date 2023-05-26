//
//  UserProfile.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = ViewModel()
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var isLoggedOut = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Divider()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Personal information")
                        .font(.system(size: 25, weight: .semibold))
                    Text("Avatar")
                        .onboardingTextStyle()
                    HStack(spacing: 0) {
                        Image("avatar")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Button("Change") { }
                            .buttonStyle(ButtonStylePrimaryColor1())
                        Button("Remove") { }
                            .buttonStyle(ButtonStylePrimaryColorReverse())
                        Spacer()
                    }
                    VStack{
                        Text("First name")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                    }
                    VStack {
                        Text("Last name")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                        
                    }
                    VStack {
                        Text("E-mail")
                            .onboardingTextStyle()
                        TextField("E-mail", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    
                    VStack {
                        Text("Phone number")
                            .onboardingTextStyle()
                        TextField("Phone number", text: $phoneNumber)
                            .keyboardType(.default)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Email notifications")
                        .font(.regularText())
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    VStack {
                        Toggle(isOn: $orderStatuses) {
                            Text("Order statuses")
                        }
                        .toggleStyle(CustomToggleStyle())
                        
                        Toggle(isOn: $passwordChanges) {
                            Text("Password changes")
                        }
                        .toggleStyle(CustomToggleStyle())
                        
                        Toggle(isOn: $specialOffers) {
                            Text("Special offers ")
                        }
                        .toggleStyle(CustomToggleStyle())
                        Toggle(isOn: $newsletter) {
                                Text("Newsletter")
                            }
                            .toggleStyle(CustomToggleStyle())
                    }
                    .padding()
                    .font(Font.leadText())
                    .foregroundColor(.primaryColor1)
                    
                    Button("Log out") {
                        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                        UserDefaults.standard.set("", forKey: kFirstName)
                        UserDefaults.standard.set("", forKey: kLastName)
                        UserDefaults.standard.set("", forKey: kEmail)
                        UserDefaults.standard.set("", forKey: kPhoneNumber)
                        UserDefaults.standard.set(false, forKey: kOrderStatuses)
                        UserDefaults.standard.set(false, forKey: kPasswordChanges)
                        UserDefaults.standard.set(false, forKey: kSpecialOffers)
                        UserDefaults.standard.set(false, forKey: kNewsletter)
                        isLoggedOut = true
                        UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                               dismiss()
                               UserDefaults.resetStandardUserDefaults()
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    Spacer(minLength: 20)
                }
                
                HStack {
                    Button("Discard Changes") {
                        firstName = viewModel.firstName
                        lastName = viewModel.lastName
                        email = viewModel.email
                        phoneNumber = viewModel.phoneNumber
                        
                        orderStatuses = viewModel.orderStatuses
                        passwordChanges = viewModel.passwordChanges
                        specialOffers = viewModel.specialOffers
                        newsletter = viewModel.newsletter
                        dismiss()
                    }
                        .buttonStyle(ButtonStylePrimaryColorReverse())
                    Button("Save changes") {
                        if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                            UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                            UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                            UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                            UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                            dismiss()
                        }
                    }
                        .buttonStyle(ButtonStylePrimaryColor1())
                }
                
            }
            // .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .imageScale(.small)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.primaryColor1)
                        .clipShape(Circle())
                }
                
            }
            ToolbarItem(placement: .principal) {
                Image("Logo")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        
                }
            }
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = viewModel.phoneNumber
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
       
    }
}


struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserProfile()
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack(spacing: 20) {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(configuration.isOn ? Color.primaryColor1 : .primary)
                    .animation(.easeInOut,value: configuration.isOn)
                configuration.label
             
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

