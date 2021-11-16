//
//  File.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 16/11/21.
//

import Foundation
import UIKit

class ParentViewController: UIViewController {
    var child : UIViewController?
    
    var isReachable:Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackBarButtonItem()
    }
    func refreshPage() {
        debugPrint("parentVC refreshPage called")
    }
    
    private func setupBackBarButtonItem() {
        let navItem = self.navigationItem as? NavigationItem
        navItem?.delegate = self
        navItem?.itemLeft = .btnBack
    }
    
    func removeBackBarButton()  {
      let navItem = self.navigationItem as? NavigationItem
      navItem?.itemLeft = .noButton
    }
    
    func showSpinnerView() {
        child = SpinnerViewController()
        child?.view.frame = self.view.frame
        if let window = appDelegate.window {
            child!.view.center = window.center
            window.addSubview(child!.view)
        }
    }
    
    func hideSpinnerView() {
        if let childview  = child {
            childview.view.removeFromSuperview()
        }
    }
    
    func showAlertWithMessage(message:String){
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}
extension  ParentViewController:NavigationItemsDelegate{
    func itemLeftTaped(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

