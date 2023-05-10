//
//  CircleLine.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 07.05.2023.
//

import SwiftUI

struct CircleLine: View {
    var value: CGFloat
    var lineWidth: Double = 4
    
    @State var appear = false
    
    
    var body: some View {
        Circle()
            .trim(from: 0, to: appear ? value : 0)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .fill(.angularGradient(colors: [.purple, .orange, .red, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
            .onAppear {
                withAnimation(.spring().delay(0.5)) {
                    appear = true
                }
            }
            .onDisappear {
                appear = false
            }
    }
}

struct CircleLine_Previews: PreviewProvider {
    static var previews: some View {
        CircleLine(value: 0.75)
    }
}
