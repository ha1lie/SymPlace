//
//  Loader.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct Loader: View {
    
    @Environment(\.colorScheme) var darkMode
    
    @State private var isLoadingOne: Bool = false
    
    /// Boolean to declare if indicator should animate or not
    let isAnimated: Bool
    
    init(_ ani: Bool = true) {
        self.isAnimated = ani
    }
    
    var body: some View {
        return ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.clear)
                .background(.ultraThinMaterial)
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 30, height: 30)
                .foregroundColor(appOrange)
                .rotationEffect(Angle(degrees: self.isLoadingOne ? 0 : 360))
        }.frame(width: 50, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .onAppear {
            if self.isAnimated {
                withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false)) {
                    self.isLoadingOne.toggle()
                }
            }
        }
    }
}
