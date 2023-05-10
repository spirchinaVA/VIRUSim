//
//  InputForm.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 06.05.2023.
//

import SwiftUI

struct InputForm: View {
    var input: SimulatorViewModel = SimulatorViewModel(groupSize: 7,infectionFactor: 3,time: 3)
    @State var groupSize = ""
    @State var infFactor = ""
    @State var time = ""
    @State var isPresented = false
    @State var appear = [false, false, false]

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Parameters")
                .font(.largeTitle).bold()
                .blendMode(.overlay)
                .slideFadeIn(show: appear[0], offset: 30)
            
            Text("Infection factor is  the max number that one person can infect.\nTime is infected people recalculation frequency.")
                .font(.headline)
                .foregroundStyle(.secondary)
                .slideFadeIn(show: appear[1], offset: 20)
            
            form.slideFadeIn(show: appear[2], offset: 10)
        }
        .coordinateSpace(name: "stack")
        .padding(20)
        .padding(.vertical, 20)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .background(
            VStack {
                Circle().fill(.blue).frame(width: 68, height: 68)
                    .scaleEffect(appear[0] ? 1 : 0.1)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        )
        .onAppear { animate() }
        .fullScreenCover(isPresented: $isPresented, content: {
            SimulatorView(simViewModel: input)
        })
    }
    
    var form: some View {
        Group {
            TextField("Enter the group size", text: $groupSize)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .customField(icon: "person.fill")
                
            
            TextField("Enter the infection factor", text: $infFactor)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .customField(icon: "facemask.fill")
                
                
            
            TextField("Enter the time in seconds", text: $time)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .customField(icon: "clock.fill")
                
      
            
            Button {
                input.setSettings(group: groupSize, infFactor: infFactor, t: time)
                isPresented = true
            } label: {
                AngularButton(title: "Start simulation")
            }
}
    }
    
    func animate() {
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.6)) {
            appear[2] = true
        }
    }
}

struct InputForm_Previews: PreviewProvider {
    static var previews: some View {
        InputForm()
    }
}
