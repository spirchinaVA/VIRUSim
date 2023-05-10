//
//  ScoreButton.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 07.05.2023.
//

import SwiftUI

struct ScoreButton: View {
    var sickPeople:Int
    var allPeople:Int
    var body: some View {
        VStack {
           Circle()
                .fill(Color("281B5A").opacity(0.8))
                .frame(width: 110, height: 110)
                .background(
                    Circle()
                        .fill(
                            .angularGradient(colors: [.blue, .red, .blue], center: .center, startAngle: .degrees(0), endAngle: .degrees(360))
                        )
                        .blur(radius: 15)
                )
        }
        .frame(width: 170, height: 170)
        .background(.ultraThinMaterial)
        .cornerRadius(90)
        .modifier(OutlineOverlay(cornerRadius: 90))
        .overlay(CircleLine(value: CGFloat(sickPeople)/CGFloat(allPeople), lineWidth: 8))
        .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
        .overlay(
            VStack{
                Text("\(sickPeople)").padding(1)
                Divider().frame(height: 1)
                    .overlay(.primary).padding(.horizontal, 15)

                Text("\(allPeople)").padding(1)
            }
            
                .frame(width: 110, height: 110)
                .font(.title3.weight(.semibold))
                .padding(2)
                .background(Color(.systemBackground).opacity(0.3))
                .cornerRadius(70)
        )
        .overlay(
            Text("\(sickPeople*100/allPeople)%")
                .font(.footnote.weight(.semibold))
                .padding(2)
                .offset(y: 70)
        )
    }
}

struct ScoreButton_Previews: PreviewProvider {
    static var previews: some View {
        ScoreButton(sickPeople: 533, allPeople: 2043)
    }
}


