//
//  NetworkChangeClass.swift
//  PetPlanner
//
//  Created by Maniar on 8/5/19.
//  Copyright © 2019 Appiskey. All rights reserved.
//

import Foundation
import Reachability

protocol NetworkChangeNotifiable {
    func setupNetworkChange()
    func unsetNetworkChange()
    func showHideOnNetworkCall(error: Error?)
    var isNetworkAvailable : Bool {get}
}

class NetworkChangeClass: NetworkChangeNotifiable {
    
    private var topView: UIButton!
    private var isVisible: Bool = false

    
    var isNetworkAvailable: Bool {
        reachability = Reachability()
        return reachability.connection != .none
    }
    var reachability : Reachability!
    
    func setupNetworkChange() {
        
        reachability = Reachability()
            reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")                    
                } else {
                    print("Reachable via Cellular")
                }
                //AlertView().showPopup(message: "Back Online", type: .success)
            }
            reachability.whenUnreachable = { _ in
                print("Not reachable")
               // AlertView().showPopup(message: "You're offline, Please Tap to retry.", type: .alert)
            }
        do {
            try reachability.startNotifier()
        } catch {
            print("Reachability error")
        }
    }
    
    func unsetNetworkChange() {
        reachability.stopNotifier()
        hidePopup()
    }
    /// fucntion manages popup
    func showPopup() {
        if self.topView == nil {
            self.setupView()
        } else {
            self.showView()
        }
    }
    
    /// Private Function with custom properties to setup display popup
    private func setupView() {
        let bounds = UIScreen.main.bounds
        let height: CGFloat = 40
        topView = UIButton(frame: CGRect(x: 20, y: bounds.height + 50, width: (bounds.width - 40), height: height))
        topView.setTitleColor(UIColor.black, for: .normal)
        
        topView.contentHorizontalAlignment = .center
        topView.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                                          
        self.topView.layer.shadowColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.topView.layer.cornerRadius = 8.0
        self.topView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.topView.layer.shadowOpacity = 1.0
        self.topView.layer.shadowRadius = 3.0
        self.topView.addTarget(self, action: #selector(offlineTapped(_:)), for: .touchUpInside)
        UIApplication.shared.keyWindow!.addSubview(self.topView)
        
        self.showView()
    }
    
    /// Private function to display when internet is not connected
    private func showView() {
        guard !isVisible else {
            return
        }
        topView.setTitle("You're offline, Please tap to retry.", for: .normal)
        topView.backgroundColor = #colorLiteral(red: 0.7048474122, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        isVisible = true
        
        UIView.animate(withDuration: 1.0) {
            self.topView.frame.origin.y = UIScreen.main.bounds.height - CGFloat(80.0)
        }
    }
    
    /// Private function to hide with animation when internet is connected
    func hidePopup() {
        guard self.topView != nil else {
            return
        }
        guard isVisible else {
            return
        }
        topView.setTitle("Back Online", for: .normal)
        topView.backgroundColor = #colorLiteral(red: 0.4554322958, green: 0.7075553536, blue: 0.289439857, alpha: 1)
        isVisible = false
        
        UIView.animate(withDuration: 1.5) {
            
            self.topView.frame.origin.y = UIScreen.main.bounds.height + CGFloat(50.0)
        }
    }
    
    /// Selector: Method to recheck internet connectivity by hitting a sample request
    ///
    /// - Parameter sender: sender description
    @objc func offlineTapped(_ sender: UIButton){
        reachability = Reachability()
        guard reachability.connection != .none else {
            return
        }
        if #available(iOS 13.0, *) {
            Router.APIRouter(completeURL: "https://www.google.com", endPoint: nil, parameters: nil, method: .get) { response in
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func showHideOnNetworkCall(error: Error?){
        if error?._code == NSURLErrorNotConnectedToInternet
            || error?._code == NSURLErrorNetworkConnectionLost
            || error?._code == NSURLErrorCannotConnectToHost
            || error?._code == NSURLErrorCannotFindHost
            || error?._code == NSURLErrorTimedOut {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showPopup()
            }
            return
        }
        DispatchQueue.main.async {
            self.hidePopup()
        }
    }
}
