//
//  NewUserScreen.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct NewUserScreen: View {
    
    @State var name: String = "Hallie"
    @State var age: String = "17"
    @State var gender: String = "Trans female"
    @State var state: String = "New York"
    @State var city: String = "Rochester"
    @State var race: String = "White"
    @State var sexuality: String = "Pansexual"
    
    @State var isLoading: Bool = false
    
    let allGenders: [String] = ["cisMale", "cisFemale", "nonBinary", "genderFluid", "transMan", "transFemale"]
    
    var isEnabled: Bool {
        get {
            return self.name != "" && self.age != "" && self.gender != "" && self.state != "" && self.city != "" && self.race != "" && self.sexuality != ""
        }
    }
    
    @State var showWhy: Bool = false
    
    private func createUser() {
        if self.isEnabled {
            print("CREATING A NEW USER AND GOING TO SET IT TO THE PHONE STORAGE!")
            self.isLoading = true
            Task {
                await UserManager.shared.createNewUser(User(name: self.name, gender: self.gender, age: self.age, race: self.race, state: self.state, city: self.city, sexuality: self.sexuality, id: UUID().uuidString, deviceToken: UserDefaults.standard.string(forKey: "deviceTokenToSendToServer") ?? ""))
                self.isLoading = false
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    Text("Your SymPlace Profile")
                        .font(.title)
                        .bold()
                    
                    Text("Create your private profile below to continue!")
                        .foregroundColor(.gray)
                    
                    Button {
                        self.showWhy.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 16))
                            Text("Why do we ask for this information?")
                        }.foregroundColor(.gray)
                    }.buttonStyle(PlainButtonStyle())
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Group {
                            Text("About You")
                                .font(.title2)
                                .bold()
                            Text("Help us learn what spaces you like")
                                .foregroundColor(.gray)
                            
                            SymTextField(input: self.$name, imageName: "person.fill", placeholder: "Name")
                            SymTextField(input: self.$age, imageName: "calendar", placeholder: "Age")
                            SymTextField(input: self.$gender, imageName: "face.smiling.fill", placeholder: "Gender")
                            SymTextField(input: self.$sexuality, imageName: "flag.fill", placeholder: "Sexuality")
                            SymTextField(input: self.$race, imageName: "person.fill.viewfinder", placeholder: "Race")
                            
                            Divider()
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                        }
                        
                        Group {
                            Text("Your Locations")
                                .font(.title2)
                                .bold()
                            Text("Help us optimize our location caching for you")
                                .foregroundColor(.gray)
                            
                            SymTextField(input: self.$state, imageName: "mappin.circle.fill", placeholder: "State")
                            SymTextField(input: self.$city, imageName: "mappin", placeholder: "City")
                        }
                        
                    }
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    
                    Button {
                        self.createUser()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(appLightGreen)
                            HStack {
                                Text("Create Your Account")
                                    .bold()
                                    .foregroundColor(self.isEnabled ? .white : .white.opacity(0.6))
                            }.padding()
                        }
                    }.buttonStyle(PlainButtonStyle())
                    
                    if !self.isEnabled {
                        Text("Finish entering your information")
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 6)

                    Button {
                        OnboardingController.shared.undoOnboardComplete()
                    } label: {
                        Text("Return to Onboarding")
                            .foregroundColor(.gray)
                    }.buttonStyle(PlainButtonStyle())

                    
                    
                }.padding()
            }.sheet(isPresented: self.$showWhy) {
                print("GOT RID OF THE INFORMATION SHEET")
            } content: {
                InformationCollectionView()
            }
            
            if self.isLoading {
                Loader()
            }
        }
    }
}
