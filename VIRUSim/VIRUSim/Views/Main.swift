//
//  Main.swift
//  VIRUSim
//
//  Created by Victoria Spirchina on 06.05.2023.
//

import SwiftUI

struct Main: View {
    
    @State var appear = false
    @State var appearBackground = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(appear ? 1 : 0)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                InputForm()
                .padding(20)
                .frame(maxHeight: .infinity, alignment: .center)
                .background(
                    Image("Blob 1").offset(x: 170, y: -60)
                        .opacity(appearBackground ? 1 : 0)
                        .blur(radius: appearBackground ? 0 : 40)
                )
                .background(Color("Background"))
            }
            
        }
        .onAppear {
            withAnimation(.spring()) {
                appear = true
            }
            withAnimation(.easeOut(duration: 2)) {
                appearBackground = true
            }
        }
    }

}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
