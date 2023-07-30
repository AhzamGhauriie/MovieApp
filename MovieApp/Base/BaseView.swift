//
//  BaseViewModel.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 30/06/2023.
//

import UIKit

class BaseView: UIViewController {
    
    // MARK:- Variables:
    var indicator = UIActivityIndicatorView()
    var setToastView: ((String) -> Void)?
    var viewModel: BaseViewModel = BaseViewModel() {
        didSet {
            self.commonInit()
        }
    }
    
    // MARK:- View Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Functions:
    func commonInit() {
        self.bindWithLoaderStatus()
        self.bindWithToastStatus()
        self.bindWithFailureResponse()
    }
    
    private func bindWithLoaderStatus() {
        viewModel.setLoading = { (isLoading) in
            if isLoading {
                DispatchQueue.main.async {
                    //   Loader.getInstance().showLoader()
                }
            } else {
                DispatchQueue.main.async {
                    //  Loader.getInstance().hideLoader()
                }
            }
        }
    }
    
    var setToastMessage: String = "" {
        didSet {
            setToastView?(setToastMessage)
        }
    }
    
    private func bindWithToastStatus() {
        viewModel.setToastView = { (message) in
            DispatchQueue.main.async {
                //AlertView().showPopup(message: message, type: .success)
            }
        }
    }
    
    private func bindWithFailureResponse() {
        viewModel.setFailureMessage = {
            (message) in
            DispatchQueue.main.async {
                //AlertView().showPopup(message: message)
            }
        }
    }
    
    
    
} // class end here:
