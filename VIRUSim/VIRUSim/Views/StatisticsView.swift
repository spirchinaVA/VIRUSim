//
//  StatisticsView.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 10.05.2023.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @Environment(\.dismiss) var dismiss
    var timeArray: [Int]
    var infCountArray: [Int]
    
    var body: some View {
        
        VStack {
            Text("Statistics")
                .padding(3)
                .foregroundColor(.primary)
                .font(.title)
                .background(
                    Rectangle().fill(.thinMaterial)).cornerRadius(10)
                .padding(10)
            Chart {
                ForEach(timeArray.indices, id: \.self) { i in
                    LineMark(
                        x: .value("Time(sec)", timeArray[i]),
                        y: .value("Sick people", infCountArray[i])
                    )
                }
            }
            .foregroundColor(.primary)
            .background(.white.opacity(0.25))
            .frame(height: 300)
            .padding(10)
            Button {
                dismiss()
            } label: {
                AngularButton(title: "Close")
            }
            .padding(10)
        }.background(
            Rectangle()
                .fill(Color("statistics"))
                .cornerRadius(20)
        )
        .frame(width: UIScreen.main.bounds.width*0.9)
        .foregroundColor(.primary)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView( timeArray: [3,12,23,32,36,46,56,69], infCountArray: [3,12,23,32,36,46,56,69])
    }
}
