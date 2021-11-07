//
//  SymSlider.swift
//  SymPlace
//
//  Created by Hallie on 11/6/21.
//

import SwiftUI

struct SymSlider: View {
    
    //MARK: DO NOT USE ON ANYTHING OTHER THAN A 5 RATING
    
    @Binding var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 24)
                    .foregroundColor(appPurple)
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: geometry.size.width * CGFloat(self.value / 5), height: 24)
                    .foregroundColor(appOrange)
            }.gesture(DragGesture(minimumDistance: 0)
            .onChanged({ dvalue in
                // TODO: - maybe use other logic here
                let n = ((dvalue.location.x / geometry.size.width) * 5)
                if n < 0 {
                    self.value = 0
                } else if n > 5 {
                    self.value = 5
                } else {
                    self.value = n
                }
            }))
        }
        
    }
}
