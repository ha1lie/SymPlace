//
//  OutOfFive.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct OutOfFive: View {
    
    @Binding var rating: Double
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Text(String(format: "%.1f", self.rating))
                .font(.system(size: 30))
                .bold()
            Text("/ 5.0")
                .padding(.bottom, 4)
        }
    }
}
