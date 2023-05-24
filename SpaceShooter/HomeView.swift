//
//  HomeView.swift
//  SpaceShooter
//
//  Created by Vicky Irwanto on 24/05/23.
//

import SwiftUI

struct HomeView: View {
    @State var changeScreen = false
    var body: some View {
        
        return Group{
            if changeScreen{
                ContentView()
            }else{
                VStack(spacing: 0.0){
                    Text("SPACE SHOOTER")
                        .font(.system(size: 40, weight: .bold, design: .monospaced))
                        .foregroundColor(Color.brown)
                        .shadow(radius: 5, x: 2, y: 4)
                        .padding(.top, 20)
                    GeometryReader{
                        geo in
                        
                        Button(action: {
                            withAnimation{
                                self.changeScreen = true
                            }
                        }, label: {
                            ZStack{
                                Image("btn")
                                Text("Play Game")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                                    .padding(.top, -14)
                                    .shadow(radius: 5, x: 2, y: 4)
                            }
                        })
                        .position(x: geo.size.width/2, y: geo.size.height/5)
                        
                        Button(action: {
                            print("Test")
                        }, label: {
                            ZStack{
                                Image("btn")
                                Text("Settings")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                                    .padding(.top, -14)
                                    .shadow(radius: 5, x: 2, y: 4)
                            }
                        })
                        .position(x: geo.size.width/2, y: geo.size.height/2.5)
                        
                        Button(action: {
                            print("Test")
                        }, label: {
                            ZStack{
                                Image("btn")
                                Text("Quit Game")
                                    .foregroundColor(Color.brown)
                                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                                    .padding(.top, -14)
                                    .shadow(radius: 5, x: 2, y: 4)
                            }
                        })
                        .position(x: geo.size.width/2, y: geo.size.height/1.65)
                        
                    }
                    .padding(.top, -50)
                    
                    
                    
                }
                .background(
                    Image("bg")
                )
            }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
