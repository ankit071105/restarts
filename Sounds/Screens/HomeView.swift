//
//  HomeView.swift
//  Restart
//
//  Created by ANKIT KUMAR on 02/08/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = false
  
    @State private var butttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var butttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack {
            
        VStack(spacing:20) {
          // Mark :- Header
            
            Spacer()
            ZStack{
                ZStack{
                    Circle()
                        .stroke(.gray.opacity(0.1), lineWidth: 40)
                        .frame(width: 260, height: 260, alignment: .center)
                    Circle()
                        .stroke(.gray.opacity(0.1), lineWidth: 120)
                        .frame(width: 260, height: 260, alignment: .center)
                    Circle()
                        .stroke(.gray.opacity(0.1), lineWidth: 150)
                        .frame(width: 260, height: 260, alignment: .center)
                    
                }
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -100)
                    .animation(.easeOut(duration: 5), value: isAnimating)
            }
         
            Spacer()
            //Mark:- Center
            VStack(spacing: 0){
                    Text("""
             The time that leads to mastery is
             dependent on the intensity of our
             focus.
             """)
                    .font(.system(size:20))
                    .fontWeight(.light)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(LinearGradient(colors: [.gray], startPoint: .top, endPoint: .bottom))
                    .padding(.bottom, 20)
            }
            // Mark :- Footer
            ZStack{
             //Parts of the custom Button
                
             // 1. Background(Static)
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .padding(9)
             // 2. Call-To-Action (Static)
                Text("Restart")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .font(.system(size: 29, design: .rounded))
                    .offset(x: 20)
                    
            //  3. Capsule (Dynamic Width)
                HStack{
                    Capsule()
                        .fill(Color("ColorBlue"))
                        .frame(width: butttonOffset + 80)
                    Spacer()
                }
            //  4. Circle (Draggable)
                HStack{
                    ZStack{
                        Circle()
                            .fill(Color("ColorBlue"))
                        Circle()
                            .fill(.black.opacity(0.15))
                            .padding(8)
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .font(.system(size: 25, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .offset(x: butttonOffset)
                    .frame( width: 80,height: 80, alignment: .center)
                    .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && butttonOffset <= butttonWidth - 80 {
                                butttonOffset = gesture.translation.width
                            }
                        }
                        .onEnded { _ in
                            if butttonOffset > butttonWidth / 2 {
                                playSound(sound: "success", type: "m4a")
                                butttonOffset =  butttonWidth - 80
                                isOnBoardingViewActive = true
                            }
                            butttonOffset = 0
                        }
                    )
                    Spacer()
                    
                }
                
            }// End of footer section
            .frame(width: butttonWidth, height: 80, alignment: .center)
            .padding()// End of footer section
            .frame(width: butttonWidth, height: 80, alignment: .center)
            .padding()
           
        }// Vstack
       }//Zstack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
