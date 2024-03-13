//
//  ContentView.swift
//  VStepperExample
//
//  Created by apple on 13/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentState = 0
    let steps = [
        StepModel(stepNumber: 1, title: "One"),
        StepModel(stepNumber: 2, title: "Two"),
        StepModel(stepNumber: 3, title: "Three"),
        StepModel(stepNumber: 4, title: "Four"),
        StepModel(stepNumber: 5, title: "‍Five")
    ]
    
    var body: some View {
        VStack {
            GeometryReader { metrics in
                StepperView(steps: steps, currentStep: $currentState, direction: .leftToRight)
                    .frame(width: 150, height: metrics.size.height * 0.5)
                    .padding(.top, 10)
            }
            
            HStack {
                if currentState > 1 {
                    Button("Previous") {
                        self.currentState -= 1
                    }
                }
                
                Spacer()
                
                if currentState <= steps.count {
                    Button(currentState < steps.count ? "Next" : "Done") {
                        if self.currentState <= steps.count {
                            self.currentState += 1
                        }
                    }
                }
                
            }.padding(20)
        }
    }
}

#Preview {
    ContentView()
}
