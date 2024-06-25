////
////  LottieView.swift
////  TodolistTest
////
////  Created by Clarissa Alverina on 24/06/24.
////
//
//import SwiftUI
//import Lottie
//
//struct LottieView: UIViewRepresentable {
//    var filename: String
//    @Binding var isAnimating: Bool // Control state to start/stop animation
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: .zero)
//        
//        let animationView = AnimationView(name: filename)
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = .loop
//        
//        if isAnimating {
//            animationView.play()
//        } else {
//            animationView.stop()
//        }
//        
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//        
//        NSLayoutConstraint.activate([
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
//        ])
//        
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Update the animation state here if needed
//        if isAnimating {
//            uiView.subviews.forEach { subview in
//                if let animationView = subview as? AnimationView {
//                    animationView.play()
//                }
//            }
//        } else {
//            uiView.subviews.forEach { subview in
//                if let animationView = subview as? AnimationView {
//                    animationView.stop()
//                }
//            }
//        }
//    }
//}
