//
//  CardTabBar.swift
//  PTR
//
//  Created by Hussein AlRyalat on 8/30/19.
//  Copyright © 2019 SketchMe. All rights reserved.
//

import UIKit

protocol CardTabBarDelegate: class {
    func cardTabBar(_ sender: PTCardTabBar, didSelectItemAt index: Int)
}

open class PTCardTabBar: UIView {
    
    weak var delegate: CardTabBarDelegate?
    
    var items: [UITabBarItem] = [] {
        didSet {
            reloadViews()
        }
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        reloadApperance()
    }
    
    func reloadApperance(){
        
        buttons().forEach { button in
            button.selectedColor = tintColor
        }
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        stackView.arrangedSubviews.forEach {
            if let button = $0 as? UIControl {
                button.removeTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            }
        }
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.15
        
        tintColorDidChange()
    }
    
    func add(item: UITabBarItem){
        self.items.append(item)
        self.addButton(with: item.image!, title: item.title!)
    }
    
    func remove(item: UITabBarItem){
        if let index = self.items.firstIndex(of: item) {
            self.items.remove(at: index)
            let view = self.stackView.arrangedSubviews[index]
            self.stackView.removeArrangedSubview(view)
        }
    }
    
    private func addButton(with image: UIImage, title: String){
        let button = PTBarButton(image: image)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.selectedColor = tintColor
        button.setTitle(title, for: UIControl.State())
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 10)
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button.alignVerticalCenter()
        self.stackView.addArrangedSubview(button)
    }
    
    func select(at index: Int, notifyDelegate: Bool = true){
        for (bIndex, view) in stackView.arrangedSubviews.enumerated() {
            if let button = view as? UIButton {
                button.tintColor =  bIndex == index ? tintColor : UIColor(rgb: 0x9b9b9b)
            }
        }
        
        if notifyDelegate {
            self.delegate?.cardTabBar(self, didSelectItemAt: index)
        }
    }
    
    
    func reloadViews(){

        for button in (stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }) {
            stackView.removeArrangedSubview(button)
            button.removeFromSuperview()
            button.removeTarget(self, action: nil, for: .touchUpInside)
        }
        
        for item in items {
            if let image = item.image {
                addButton(with: image, title: item.title ?? "")
            } else {
                addButton(with: UIImage(), title: item.title ?? "")
            }
        }
                
        select(at: 0)
    }
    
    
    
    private func buttons() -> [PTBarButton] {
        return stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }
    }
    
    func select(at index: Int){
        
        for (bIndex, button) in buttons().enumerated() {
            button.selectedColor = tintColor
            button.isSelected = bIndex == index
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
        
        self.delegate?.cardTabBar(self, didSelectItemAt: index)
    }
    
    
    @objc func buttonTapped(sender: PTBarButton){
        if let index = stackView.arrangedSubviews.firstIndex(of: sender){
            select(at: index)
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let position = touches.first?.location(in: self) else {
            super.touchesEnded(touches, with: event)
            return
        }
        
        let buttons = self.stackView.arrangedSubviews.compactMap { $0 as? PTBarButton }.filter { !$0.isHidden }
        let distances = buttons.map { $0.center.distance(to: position) }
        
        let buttonsDistances = zip(buttons, distances)
        
        if let closestButton = buttonsDistances.min(by: { $0.1 < $1.1 }) {
            buttonTapped(sender: closestButton.0)
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        roundCorners(corners: [.topLeft, .topRight], radius: bounds.height / 2)
//        layer.cornerRadius = bounds.height / 2
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIButton {
func alignVerticalCenter(padding: CGFloat = 6.0) {
    guard let imageSize = imageView?.image?.size, let titleText = titleLabel?.text, let titleFont = titleLabel?.font else {
return
        }
let titleSize = (titleText as NSString).size(withAttributes: [.font: titleFont])
    
let total = imageSize.height + titleSize.height + padding
        imageEdgeInsets = UIEdgeInsets(top: -(total - imageSize.height), left: 0, bottom: 0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(total - titleSize.height), right: 0)
    }
}
