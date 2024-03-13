//
//  StepperView.swift
//  VStepperExample
//
//  Created by apple on 13/03/24.
//


import SwiftUI

enum DirectionType {
    case leftToRight
    case rightToLeft
}

struct StepperView: View {
    
    @Binding var currentStep: Int
    
    var direction: DirectionType = .rightToLeft
    var steps = [StepModel]()
    
    init(steps: [StepModel], currentStep: Binding<Int>, direction: DirectionType? = nil) {
        if let d = direction {
            self.direction = d
        }
        self.steps = steps
        _currentStep = currentStep
        for i in 0..<self.steps.count {
            if self.steps[i].stepNumber < currentStep.wrappedValue {
                self.steps[i].state = .passed
            } else if self.steps[i].stepNumber == currentStep.wrappedValue {
                self.steps[i].state = .current
            } else if steps[i].stepNumber > currentStep.wrappedValue {
                self.steps[i].state = .notPassed
            }
        }
    }
    
    func calculateProgress() -> CGFloat {
        let stepsCount = steps.count
        let current = currentStep
        if current == 1 {
            return 0
        }
        if stepsCount % 2 == 0 {
            print(CGFloat(current) / CGFloat(stepsCount))

            return CGFloat(current) / CGFloat(stepsCount)
        } else {
            print(CGFloat(current - 1) / CGFloat(stepsCount - 1))

            return CGFloat(current - 1) / CGFloat(stepsCount - 1)
        }
    }
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(maxWidth: 4, maxHeight: metrics.size.height - 50)
                    .padding(.leading, 47)
                    .padding(.vertical, 25)
                
                VStack {
                    if direction == .rightToLeft {
                        Spacer()
                    }
                    Rectangle()
                        .fill(Color.green)
                        .frame(maxWidth: 4, maxHeight: (metrics.size.height - 50) * calculateProgress())
                        .padding(.leading, 47)
                        .padding(.vertical, 25)
                        .animation(.linear)
                    if direction == .leftToRight {
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    let array = direction == .rightToLeft ? steps.reversed() : steps
                    ForEach(array, id: \.self) { step in
                        StepView(step: step, currentStep: $currentStep)
                        if step != array.last {
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
            }
        }
    }

}
