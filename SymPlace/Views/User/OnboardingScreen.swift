//
//  OnboardingScreen.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct OnboardingScreen: View {
    
    @ObservedObject var onboardController: OnboardingController = OnboardingController.shared
    
    @State var page: Int = 1
    
    @State var locationEnabled: Bool = false
    
    @State var showingAlert: Bool = false
    
    func incrementPage() {
        if self.page == 3 {
            //Finish onboarding
            self.onboardController.finishOnboarding()
        } else {
            withAnimation {
                self.page += 1
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(self.page == 1 ? "Welcome to SymPlace" : self.page == 2 ? "About SymPlace" : "Get Ready")
                .font(.title)
                .bold()
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(self.page == 1 ? appOrange : self.page == 2 ? appBlue : appLightGreen)
                ScrollView(.vertical, showsIndicators: true) {
                    if self.page == 1 {
                        VStack {
                            Image(uiImage: UIImage(named: "icon")!)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                                .clipped()
                            
                            Text("Find Your Safe Spaces")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                            
                            Text("SymPlace is an app that lives in the background, until you need it to find your next hang out spot!")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }.padding()
                    } else if self.page == 2 {
                        VStack {
                            Group {
                                Text("Three Simple Steps")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding(.top, 6)
                                    .multilineTextAlignment(.center)
                                VStack(alignment: .leading) {
                                    Text("One.")
                                        .font(.system(size: 20))
                                        .bold()
                                        .padding(.top, 6)
                                    Text("SymPlace periodically checks the places you hang out using secure on-device services. When it detects you visit this place often, it will ask you to review it!")
                                    
                                    Text("Two.")
                                        .font(.system(size: 20))
                                        .bold()
                                        .padding(.top, 6)
                                    Text("You review locations around you that you visit often! Your reviews are sent anonymously to our server to protect your privacy")
                                    
                                    Text("Three.")
                                        .font(.system(size: 20))
                                        .bold()
                                        .padding(.top, 6)
                                    Text("You and others discover new places around you to feel comfortable as yourself!")
                                    
                                    Divider()
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                    
                                    Text("SymPlace works with many people to help cache a collection of safe spaces for everyone to enjoy, and informs people to be wary of places that might not be the nicest. By just having this app on your phone, you're helping dozens of other people discover their next destinations.")
                                }.foregroundColor(.white)
                            }
                        }.padding()
                    } else {
                        VStack {
                            Text("Let's enable these services:")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .bold()
                                .padding(.top, 6)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                print("SHOW THE EXPLAINATION OF WHY")
                                self.showingAlert.toggle()
                            } label: {
                                Text("Why do we need these?")
                                    .foregroundColor(.white.opacity(0.6))
                            }.buttonStyle(PlainButtonStyle())
                                .alert(isPresented: self.$showingAlert) {
                                    Alert(title: Text("Why we need services"), message: Text("Location services are used to find safe places. Notification services are to contact you about new discoveries"), dismissButton: .default(Text("Got it!")))
                                }

                            Divider()
                                .padding(.horizontal)
                                .padding(.vertical, 6)
                                .foregroundColor(.white)
                            
                            Group { // Notification services
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Notification Services")
                                            .bold()
                                        Text("Allow us to talk to you")
                                    }.foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    if !NotificationManager.shared.enabled {
                                        Button {
                                            withAnimation {
                                                NotificationManager.shared.launchSetup()
                                            }
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .foregroundColor(appOrange)
                                                Text("Enable")
                                                    .foregroundColor(.white)
                                                    .padding()
                                            }.frame(width: 100)
                                        }.buttonStyle(PlainButtonStyle())
                                    } else {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(appOrange)
                                    }

                                }.padding(.bottom)
                            }
                            
                            Group { // Location services
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Location Services")
                                            .bold()
                                        Text("Allow us to find places")
                                    }.foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    if !self.locationEnabled {
                                        Button {
                                            print("ENABLE LOCATION SERVICES")
                                            LocationManager.shared.requestAccess()
                                            withAnimation {
                                                self.locationEnabled.toggle()
                                            }
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .foregroundColor(appOrange)
                                                Text("Enable")
                                                    .foregroundColor(.white)
                                                    .padding()
                                            }.frame(width: 100)
                                        }.buttonStyle(PlainButtonStyle())
                                    } else {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(appOrange)
                                    }

                                }
                            }
                        }.padding()
                    }
                }
            }
            
            Spacer()
            HStack {
                if self.page > 1 {
                    Button {
                        withAnimation {
                            self.page -= 1
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(appPurple)
                            Text("BACK")
                                .foregroundColor(.white)
                                .bold()
                        }.frame(width: 120, height: 50)
                    }.buttonStyle(PlainButtonStyle())
                }
                Spacer()
                if self.page <= 3 {
                    Button {
                        self.incrementPage()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(appPurple)
                            Text(self.page == 3 ? "FINISH" : "NEXT")
                                .foregroundColor(self.page == 3 && (!NotificationManager.shared.enabled || !self.locationEnabled) ? .white.opacity(0.6) : .white)
                                .bold()
                        }.frame(width: 120, height: 50)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }.padding()
    }
}
