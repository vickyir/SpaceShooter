//
//  HomeView.swift
//  SpaceShooter
//
//  Created by Vicky Irwanto on 24/05/23.
//

import SwiftUI
import SpriteKit

var shipChoice = UserDefaults.standard

struct HomeView: View {
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Spacer()
                    
                    Text("IR Shooter")
                        .font(.custom("Chalkduster", size: 45))
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink{
                        ContentView().navigationBarBackButtonHidden(true).navigationBarBackButtonHidden(true)
                    }label: {
                        ZStack{
                            Image("btn")
                            Text("Start Game")
                                .font(.custom("Chalkduster", size: 32))
                                .foregroundColor(.white)
                                .padding(.top, -10)
                        }
                      
                    }
                    Spacer()
                    
                    VStack{
                        Text("Choose your Ship")
                            .font(.custom("Chalkduster", size: 25))
                            .fontWeight(.bold)
                        HStack(spacing: 0.0){
                            Button(action: {
                                makePlayerChoice()
                            }, label: {
                                ZStack{
                                    Image("btn")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text("Ship 1")
                                        .font(.custom("Chalkduster", size: 12))
                                        .foregroundColor(.white)
                                        .padding(.top, -8)
                                }
                               
                            })
                            .padding()
                            
                            Button(action: {
                                makePlayerChoice2()
                            }, label: {
                                ZStack{
                                    Image("btn")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text("Ship 2")
                                        .font(.custom("Chalkduster", size: 12))
                                        .foregroundColor(.white)
                                        .padding(.top, -8)
                                }
                            })
                            .padding()
                            
                            Button(action: {
                                makePlayerChoice3()
                            }, label: {
                                ZStack{
                                    Image("btn")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Text("Ship 3")
                                        .font(.custom("Chalkduster", size: 12))
                                        .foregroundColor(.white)
                                        .padding(.top, -8)
                                }
                            })
                            .padding()
                            
                            
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(alignment: .center)
            .background(Image("bg"))
            .ignoresSafeArea()
        }
        .onAppear{
            SoundManager.instance.PlaySound()
        }
        
    }
    
    func makePlayerChoice(){
        shipChoice.setValue(1, forKey: "playerChoice")
    }
    
    func makePlayerChoice2(){
        shipChoice.setValue(2, forKey: "playerChoice")
    }
    
    func makePlayerChoice3(){
        shipChoice.setValue(3, forKey: "playerChoice")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
