//
//  NavigationItem.swift
//  NetworkModuleExample
//
//  Created by Aklesh on 16/11/21.
//

import Foundation
import UIKit

@objc public protocol NavigationItemsDelegate: NSObjectProtocol {
    @objc optional func itemLeftTaped(sender: UIBarButtonItem)
    @objc optional func itemRightTaped(sender: UIBarButtonItem)
}

class NavigationItem: UINavigationItem {
    
    // MARK:- Delegate
    var delegate:NavigationItemsDelegate?
    
    public var itemTitle: NavigationItemType.TypeTitle? = .noTitleView {
        
        didSet {
            if itemTitle != nil {
                self.setTitleItem(itemTitle!)
            }
        }
    }
    
    public var itemLeft: NavigationItemType.TypeLeftButton? = .noButton {
        
        didSet {
            if itemLeft != nil {
                self.setLeftNavigationItem(itemLeft!)
            }
        }
    }
    
    public var itemRight: NavigationItemType.TypeRightButton? = .noButton {
        
        didSet {
            if itemRight != nil {
                self.setRightNavigationItem(itemRight!)
            }
        }
    }
}

// MARK: - Set NavigationItem
extension NavigationItem {
    
    func setTitleItem(_ itemType: NavigationItemType.TypeTitle) {
        switch itemType {
        case .titleViewInteractive(let value):
            break
        case .titleViewNonInteractive(let title):
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
            titleLabel.text = title
            titleLabel.numberOfLines = 2
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textAlignment = .center
            titleLabel.isAccessibilityElement = true
            titleLabel.accessibilityTraits = UIAccessibilityTraits.header
            titleLabel.textColor = UIColor.white
            
            let customTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
            customTitleView.addSubview(titleLabel)
            customTitleView.isAccessibilityElement = false
            self.titleView = customTitleView
            break
        default:
            break
        }
    }
    
    func titleTaped(sender: UIBarButtonItem) {
        self.delegate?.itemLeftTaped!(sender: sender)
    }
}

// MARK: - Set Left NavigationItem
extension NavigationItem {
    
    func setLeftNavigationItem(_ itemType: NavigationItemType.TypeLeftButton) {
        var arrBtns: [UIBarButtonItem] = []
        switch itemType {
        case .btnBack:
            let image = UIImage(named: "BackButton")
            let barBtnLeft = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = UIColor.white
            barBtnLeft.accessibilityIdentifier = "leftBarButton"
            arrBtns.append(barBtnLeft)
            break
        case .btnClose:
            let barBtnLeft = UIBarButtonItem.init(image: #imageLiteral(resourceName: "bar-btn-close"), style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = UIColor.white
            barBtnLeft.accessibilityIdentifier = "leftBarButton"
            arrBtns.append(barBtnLeft)
            break
        case .btnWithString(let value, let style):
            let barBtnLeft = UIBarButtonItem.init(title: value, style: style, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = UIColor.white
            barBtnLeft.accessibilityIdentifier = "leftBarButton"
            arrBtns.append(barBtnLeft)
            break
        case .btnWithIcon(let image):
            let barBtnLeft = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.tintColor = UIColor.white
            barBtnLeft.accessibilityIdentifier = "leftBarButton"
            arrBtns.append(barBtnLeft)
            break
        case .btnWithIconAndString(let image,let value, let style):
            let barBtnLeft = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtnLeft.style = style
            barBtnLeft.tintColor = UIColor.white
            barBtnLeft.accessibilityIdentifier = "leftBarButton"
            
            arrBtns.append(barBtnLeft)
            break
        case .btnWithCustomView(let value):
            let barBtn = UIBarButtonItem.init(customView: value)
            //barBtn.tintColor = BarButtonTintColor
            barBtn.accessibilityIdentifier = "leftBarButton"
            
            arrBtns.append(barBtn)
        default:
            break
        }
        self.setLeftBarButtonItems(arrBtns, animated: true)
    }
    
    @objc func btnLeftTaped(sender: UIBarButtonItem) {
        self.delegate?.itemLeftTaped!(sender: sender)
    }
}

// MARK: - Set Right NavigationItem
extension NavigationItem {
    func setRightNavigationItem(_ itemType: NavigationItemType.TypeRightButton) {
        var arrBtns: [UIBarButtonItem] = []
        switch itemType {
        case .btnWithString(let value, let style):
            let barBtn = UIBarButtonItem.init(title: value, style: style, target: self, action: #selector(btnRightTaped))
            barBtn.tintColor = UIColor.white
            barBtn.accessibilityIdentifier = "rightBarButton"
            arrBtns.append(barBtn)
            break
        case .btnWithIcon(let image):
            let barBtn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(btnRightTaped))
            barBtn.tintColor = UIColor.white
            barBtn.accessibilityIdentifier = "rightBarButton"
            arrBtns.append(barBtn)
            break
        case .btnClose:
            let barBtn = UIBarButtonItem.init(image: #imageLiteral(resourceName: "bar-btn-close"), style: .plain, target: self, action: #selector(btnLeftTaped))
            barBtn.tintColor = UIColor.white
            barBtn.accessibilityIdentifier = "rightBarButton"
            arrBtns.append(barBtn)
            break
        case .btnWithCustomView(let value):
            let barBtn = UIBarButtonItem.init(customView: value)
            //barBtn.tintColor = BarButtonTintColor
            barBtn.accessibilityIdentifier = "rightBarButton"
            arrBtns.append(barBtn)
        default:
            break
        }
        self.setRightBarButtonItems(arrBtns, animated: true)
    }
    
    @objc func btnRightTaped(sender: UIBarButtonItem) {
        self.delegate?.itemRightTaped!(sender: sender)
    }
}

// MARK: - NavigationItem Type
enum NavigationItemType {
    
    enum TypeTitle {
        case noTitleView
        case titleViewInteractive(value: Any)
        case titleViewNonInteractive(title: String)
    }
    
    enum TypeLeftButton {
        case noButton
        case btnBack
        case btnClose
        case btnWithString(value: String, style: UIBarButtonItem.Style)
        case btnWithIcon(image: UIImage)
        case btnWithIconAndString(image: UIImage, value: String, style: UIBarButtonItem.Style)
        case btnWithCustomView(value: UIView)
        
    }
    
    enum TypeRightButton {
        case noButton
        case btnWithString(value: String, style: UIBarButtonItem.Style)
        case btnWithIcon(image: UIImage)
        case btnClose
        case btnWithCustomView(value: UIView)
        
    }
    
    case TitleView(type: TypeTitle)
    case LeftButton(type: TypeLeftButton)
    case RightButton(type: TypeRightButton)
}

