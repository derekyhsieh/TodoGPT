//
//  TypingIndicator.swift
//  SwiftUI-Auth
//
//  Created by Derek Hsieh on 5/13/23.
//

import SwiftUI

struct TypingIndicator: View {
    @State private var numberOfAnimatingBalls = 3
    
    let ballSize: CGFloat = 5
    let speed: Double = 0.5
    
    
    var body: some View {
        HStack(alignment: .firstTextBaseline){
            ForEach(0..<3) { i in
                Capsule()
                    .foregroundColor((self.numberOfAnimatingBalls == i) ? .blue : Color(UIColor.darkGray))
                    .frame(width: self.ballSize, height: (self.numberOfAnimatingBalls == i) ? self.ballSize / 3 : self.ballSize)
            }
        }
        .animation(Animation.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1).speed(2))
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: self.speed, repeats: true) { _ in
                var randomNumber: Int
                
                repeat {
                    randomNumber = Int.random(in: 0...2)
                } while randomNumber == self.numberOfAnimatingBalls
                self.numberOfAnimatingBalls = randomNumber
            }
        }
    }
}

struct TypingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TypingIndicator()
    }
}
