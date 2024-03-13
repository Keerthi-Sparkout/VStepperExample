//
//  StepView.swift
//  VStepperExample
//
//  Created by apple on 13/03/24.
//

import SwiftUI

struct StepModel: Hashable {
    var stepNumber: Int
    var title: String
    var state: StepState = .notPassed
}

enum StepState: Hashable {
    case passed
    case notPassed
    case current
    
    var color: Color {
        switch self {
        case .passed, .current:
            return .green
        case .notPassed:
            return .gray
        }
    }
    
    var borderColor: Color {
        switch self {
        case .passed, .notPassed:
            return .clear
        case .current:
            return .green
        }
    }
}

struct StepView: View {
    
    @Binding var currentStep: Int
    var step: StepModel

    init(step: StepModel, currentStep: Binding<Int>? = nil) {
        self.step = step
        _currentStep = currentStep ?? .constant(0)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .strokeBorder(step.state.borderColor, lineWidth: 4)
                    .background(Circle().fill(step.state.color))
                    .frame(width: 30, height: 30)
                Text("\(step.stepNumber)")
                    .foregroundColor(.white)
            }
            Text(step.title)
        }.onTapGesture {
            currentStep = step.stepNumber
        }
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(step: StepModel(stepNumber: 0, title: "New", state: .passed))
    }
}

struct AdaptiveStackView<Content: View>: View {
    let stackHorizontally: Bool
    let spacing: CGFloat
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let content: () -> Content
    
    init(stackHorizontally: Bool, spacing: CGFloat, horizontalAlignment: HorizontalAlignment = .center, verticalAlignment: VerticalAlignment = .center, @ViewBuilder content: @escaping () -> Content) {
        self.stackHorizontally = stackHorizontally
        self.spacing = spacing
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.content = content
    }
    
    var body: some View {
        Group {
            if stackHorizontally {
                HStack(alignment: verticalAlignment, spacing: spacing, content: content)
            } else {
            VStack(alignment: horizontalAlignment, spacing: spacing, content: content)
            }
        }
    }
}
