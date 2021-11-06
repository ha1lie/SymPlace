//
//  SymTextField.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct SymTextField: View {
    
    @Binding var input: String
    
    var imageName: String? = nil
    
    let placeholder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(appPurple)
            HStack {
                if self.imageName != nil {
                    Image(systemName: self.imageName!)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(.trailing, 4)
                }
                ZStack {
                    if self.input == "" {
                        HStack {
                            Text(self.placeholder)
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                        }
                    }
                    TextField(text: self.$input, prompt: Text("")) {
                        Text("")
                    }.foregroundColor(.white)
                }
            }.padding()
        }
    }
}
