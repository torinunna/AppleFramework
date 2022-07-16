//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 권유진 on 2022/07/16.
//

import Foundation
import Combine

final class FrameworkListViewModel {
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
//    Data
    let items: CurrentValueSubject<[AppleFramework], Never>
    let selectedItem: CurrentValueSubject<AppleFramework?, Never>
    
//    User Action
    let didSelect = PassthroughSubject<AppleFramework, Never>()
   
    func didSelect(at indexPath: IndexPath) {
        
        let item = items.value[indexPath.item]
        
        selectedItem.send(item)

    }
    
}
