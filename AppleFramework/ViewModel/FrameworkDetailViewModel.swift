//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 권유진 on 2022/07/16.
//

import Foundation
import Combine

final class DetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
//  Data
    let framework: CurrentValueSubject<AppleFramework, Never>
    
//  User Action
    let buttonPressed = PassthroughSubject<AppleFramework, Never>()
    
    func learnMorePressed() {
        buttonPressed.send(framework.value)
    }

}
