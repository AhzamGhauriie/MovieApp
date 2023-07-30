//
//  BaseViewModel.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 30/06/2023.
//


import Foundation
import UIKit

class BaseViewModel: NSObject {
  
    
    var setFailureMessage: ((String) -> Void)?
    var setLoading: ((Bool) -> Void)?
    var setToastView: ((String) -> Void)?
    var showNullView: ((Bool) -> Void)?
    
    var isLoading: Bool = false {
        didSet {
            setLoading?(isLoading)
        }
    }
    var errorMessage: String = "" {
        didSet {
            setFailureMessage?(errorMessage)
        }
    }
    var setToastMessage: String = "" {
        didSet {
            setToastView?(setToastMessage)
        }
    }
    var isNullViewVisible: Bool = false {
        didSet {
            showNullView?(isNullViewVisible)
        }
    }
}
