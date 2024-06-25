//
//  WaterView2.swift
//  TodolistTest
//
//  Created by Clarissa Alverina on 24/06/24.
//

import SwiftUI
import Lottie

struct WaterView2: View {
    @State private var start = Date.now
    @State private var moveToTop = false
    @State private var isFloating = false
    @State private var startFloating = false
    @State private var returnToInitial = false
    @State private var backgroundOffset: CGFloat = 0

    var body: some View {
        TimelineView(.animation) { tl in
            let time = start.distance(to: tl.date)
            ZStack {
                BackgroundImageView3(imageName: "sea bg")
                BackgroundImageView3(imageName: "waves")
                    .opacity(0.3)
                    .visualEffect { content, proxy in
                        content
                            .distortionEffect(
                                ShaderLibrary.wave(
                                    .float(time),
                                    .float2(proxy.size)
                                ),
                                maxSampleOffset: .zero
                            )
                    }

                    VStack {
                        LottieView(animation: .named("finish"))
                            .playbackMode(.playing(.toProgress(1, loopMode: .playOnce)))
                        
                        Image("boat2")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 250)
                            .offset(y: moveToTop ? -UIScreen.main.bounds.height / 10 : UIScreen.main.bounds.height / 8)
                            .offset(y: isFloating ? -5 : 5)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                    isFloating.toggle()
                                }
                                if startFloating {
                                    withAnimation(.easeInOut(duration: 2)) {
                                        moveToTop.toggle()
                                    }
                                }
                            }
                    }

                Button("Move") {
                    withAnimation(.easeInOut(duration: 2)) {
                        moveToTop = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            isFloating.toggle()
                        }
                    }
                }
                .padding(.top, 500)
                .foregroundColor(.white)
                .bold()
                .font(.system(size: 20))

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundImageView3: View {
    let imageName: String

    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    WaterView2()
}
