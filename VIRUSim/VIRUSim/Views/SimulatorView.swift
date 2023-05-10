//
//  Simulator.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 07.05.2023.
//

import SwiftUI

struct SimulatorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var simViewModel: SimulatorViewModel
    @State var value:CGFloat = 0
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let columnsZoom = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var zoom = false
    var body: some View {
        
        ScrollView {
            HStack {
               
                Spacer()
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(9)
                    .background(.ultraThinMaterial, in: Circle())
                    .padding(.trailing, 30)
                    .onTapGesture {
                        simViewModel.timer.connect().cancel()
                        dismiss()
                    }
            }
            .frame(width: UIScreen.main.bounds.width)
            
            ScoreButton(sickPeople: simViewModel.sickPeople, allPeople: simViewModel.data.groupSize)
                .frame(width: UIScreen.main.bounds.width)
                .padding(30)
            
            Button {
                zoom.toggle()
            } label: {
                Image(systemName: zoom ? "minus.magnifyingglass" : "plus.magnifyingglass")
                    .foregroundColor(.primary)
                    .font(.title)
                    .fontWeight(.light)
            }
            
            LazyVGrid(columns: zoom ? columnsZoom : columns, spacing: zoom ? 5 : 20) {
                ForEach(simViewModel.peopleState.indices, id: \.self) { i in
                    
                    VStack {
                        Circle()
                            .fill(Color("281B5A").opacity(0.9))
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(
                                        //                                                            withAnimation(.easeInOut(duration: 0.5)){
                                        .angularGradient(colors: simViewModel.peopleState[i] ? [.blue, .red]:                           [.blue, .green],
                                                         center: .center,
                                                         startAngle: .degrees(0),
                                                         endAngle: .degrees(360))
                                        //                                                            }
                                        
                                    )
                                    .blur(radius: 15)
                            )
                        
                    }
                    .frame(width: zoom ? 50 : 70, height: zoom ? 50 : 70)
                    .background(.ultraThinMaterial)
                    .cornerRadius(60)
                    .modifier(OutlineOverlay(cornerRadius: 60))
                    .overlay(
                        Image(systemName: "person")
                            .frame(width: 36, height: 36)
                            .background(.thinMaterial)
                            .cornerRadius(30)
                            .modifier(OutlineOverlay(cornerRadius: 30))
                            .foregroundStyle(.secondary)
                    )
                    .onTapGesture {
                        withAnimation() {
                            simViewModel.infectPerson(index: i)
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
            .padding(20)
            
        }.frame(width: UIScreen.main.bounds.width)
            .background(Color("Background"))
            .onAppear{
                simViewModel.timer.connect()
            }
            .onReceive(simViewModel.timer) { t in
                if simViewModel.sickPeople >= simViewModel.data.groupSize {
                    
                    simViewModel.timer.connect().cancel()
                    print("bye")
                } else {
                    print("hey")
                    simViewModel.spreadInfection()
                }
            }
        
    }
    
    var person: some View {
        Circle().overlay{
            
        }
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatorView(simViewModel: SimulatorViewModel(groupSize: 7, infectionFactor: 3, time: 1))
    }
}
