//
//  OnBoardingView.swift
//  Restart
//
//  Created by ANKIT KUMAR on 02/08/23.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    
    @State private var butttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var butttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffSet: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all)
        VStack(spacing:20) {
          // Mark :- Header
            
            Spacer()
            VStack(spacing: 0){
              Text(textTitle)
                    .font(.system(size: 60))
                    .fontWeight(.heavy)
                    .foregroundStyle(LinearGradient(colors: [.white], startPoint: .top, endPoint: .bottom))
                    .transition(.opacity)
                    .id(textTitle)
                    Text("""
             It's not how much we give but
             how much love we put into giving.
             """)
                    .font(.system(size:20))
                    .fontWeight(.light)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(LinearGradient(colors: [.white], startPoint: .top, endPoint: .bottom))
                    .padding(.horizontal, 10)
            }//End of Header
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : -50)
            .animation(.easeOut(duration: 1), value: isAnimating)
           
            
            // Mark :- Center
            ZStack{
                ZStack{
                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 40)
                        .frame(width: 260, height: 260, alignment: .center)
                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 80)
                        .frame(width: 260, height: 260, alignment: .center)
                    
                }
                .offset(x: imageOffSet.width * -1)
                .blur(radius: abs(imageOffSet.width / 5))
                .animation(.easeOut(duration: 1), value: imageOffSet)
                Image("character-1")
                    .resizable()
                    .scaledToFit()
                    .offset(x: imageOffSet.width * 1.2, y: 0)
                    .rotationEffect(.degrees(Double(imageOffSet.width / 20)))
                    .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if abs(imageOffSet.width) <= 150 {
                                imageOffSet = gesture.translation
                                
                                withAnimation(.linear(duration: 0.25)) {
                                    indicatorOpacity = 0
                                    textTitle = "Give."
                                }
                            }
                        }
                        .onEnded { _ in
                            imageOffSet = .zero
                            withAnimation(.linear(duration: 0.25)) {
                                indicatorOpacity = 1
                                textTitle = "share."
                            }
                        }
                    )// Gesture
                    .animation(.easeOut(duration: 1), value: imageOffSet)
                 
            }// center
            .opacity(isAnimating ? 1 : 0)
            .offset(x: isAnimating ? 0 : -90)
            .animation(.easeOut(duration: 3), value: isAnimating)
            Spacer()
            
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .foregroundColor(.white)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeIn(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                    .font(.system(size: 44, weight: .ultraLight))
                , alignment: .bottom
                
                )
            // Mark :- Footer
            ZStack{
             //Parts of the custom Button
                
             // 1. Background(Static)
                Capsule()
                    .fill(Color.white.opacity(0.2))
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .padding(9)
             // 2. Call-To-Action (Static)
                Text("Get Started")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 29, design: .rounded))
                    .offset(x: 20)
                    
            //  3. Capsule (Dynamic Width)
                HStack{
                    Capsule()
                        .fill(Color("ColorRed"))
                        .frame(width: butttonOffset + 80)
                    Spacer()
                }
            //  4. Circle (Draggable)
                HStack{
                    ZStack{
                        Circle()
                            .fill(Color("ColorRed"))
                        Circle()
                            .fill(.black.opacity(0.15))
                            .padding(8)
                        Image(systemName: "chevron.right.2")
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
                                playSound(sound: "chimeup", type: "mp3")
                                butttonOffset =  butttonWidth - 80
                                isOnBoardingViewActive = false
                            }
                            butttonOffset = 0
                        }
                    )
                    Spacer()
                    
                }
                
            }// End of footer section
            .frame(width: butttonWidth, height: 80, alignment: .center)
            .padding()
            .opacity(isAnimating ? 1 : 0)
            .offset(y: isAnimating ? 0 : 50)
            .animation(.easeOut(duration: 1), value: isAnimating)
            
        }// Vstack
       }//Zstack
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
