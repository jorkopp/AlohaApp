//
//  NoConnectivityView.swift
//  AlohaApp
//
//  Created by Jordan Kopp on 8/2/25.
//

import SwiftUI

struct NoConnectivityView: View {
    var body: some View {
        @State var isBlinking: Bool = true
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.redAccent)
                    .opacity(isBlinking ? 1 : 0.3)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isBlinking)
                Text("No Internet Connection")
                    .font(.title)
                    .bold()
                    .colorInvert()
                Text("Please check your network and try again.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .colorInvert()
                
                Button(action: {
                }) {
                    Text("Retry")
                        .padding()
                        .background(Color.redAccent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .onAppear {
                isBlinking.toggle()
            }
        }
    }
}

#Preview {
    NoConnectivityView()
}
