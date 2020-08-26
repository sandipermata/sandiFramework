//
//  ExtensionUIButton.swift
//  SpeedTest_sji
//
//  Created by Sandi Permata on 21.04.20.
//  Copyright © 2020 sample. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    public func imageButton(image : String) {
        let img = UIImage(named: image)
        setImage(img, for: .normal)
    }
    
    public func tesAgainButton(title: String) {
        let colorHex = ColorWithHexaString()
        backgroundColor = colorHex.ColorWithHexaStrings(hex: "5781fb")
        setTitle(title, for: .normal)
        titleLabel?.font = loadFonts.loadFontWithSize(.S10, .MontserratRegular)
        setTitleColor(colorHex.ColorWithHexaStrings(hex: "ffffff"), for: .normal)
        layer.cornerRadius = 10
        isEnabled = true
    }
    
    public func disableButton(title: String) {
        let colorHex = ColorWithHexaString()
        backgroundColor = colorHex.ColorWithHexaStrings(hex: "ebf9df")
        setTitle(title, for: .normal)
        titleLabel?.font = loadFonts.loadFontWithSize(.S12, .MontserratBold)
        setTitleColor(colorHex.ColorWithHexaStrings(hex: "7dbd43"), for: .normal)
        layer.cornerRadius = 10
        isEnabled = false
    }
    
    public func setButtonSuccessView(title: String) {
        let colorHex = ColorWithHexaString()
        
        layer.cornerRadius = 35
        layer.backgroundColor = colorHex.ColorWithHexaStrings(hex: "FFFFFF").cgColor
        titleLabel?.font = loadFonts.loadFontWithSize(.S12, .MontserratBold)
        titleLabel?.textColor = colorHex.ColorWithHexaStrings(hex: "1098AD")
        setTitle(title, for: .normal)
    }
    
    public func enableButton(title: String) {
        let colorHex = ColorWithHexaString()
        backgroundColor = colorHex.ColorWithHexaStrings(hex: "9ccc3b")
        setTitle(title, for: .normal)
        titleLabel?.font = loadFonts.loadFontWithSize(.S12, .MontserratBold)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 10
        isEnabled = true
    }
    
    public func applyButton() {
        layer.cornerRadius = 30
        layer.backgroundColor = UIColor.white.cgColor
        setTitle("Apply bro", for: .normal)
        setTitleColor(UIColor(red: 16/255, green: 152/255, blue: 173/255, alpha: 1.0) , for: .normal)
        titleLabel?.font = loadFonts.loadFontWithSize(.S12, .MontserratBold)
    }
    
    public func FeedBackWeatherButton(title: String) {
        let colorHex = ColorWithHexaString()
        backgroundColor = colorHex.ColorWithHexaStrings(hex: "FEC20E")
        setTitle(title, for: .normal)
        titleLabel?.font = loadFonts.loadFontWithSize(.S12, .OpenSansRegular)
        titleLabel?.textColor = colorHex.ColorWithHexaStrings(hex: "000000")
        layer.cornerRadius = 10
        isEnabled = true
    }
    
    @objc enum Position: Int {
        case top, bottom, left, right
    }
    
    @objc func set(image: UIImage?, title: String, titlePosition: Position, additionalSpacing: CGFloat, state: UIControl.State){
        imageView?.contentMode = .center
        setImage(image, for: state)
        setTitle(title, for: state)
        titleLabel?.contentMode = .center
        
        adjust(title: title as NSString, at: titlePosition, with: additionalSpacing)
        
    }
    
    @objc func set(image: UIImage?, attributedTitle title: NSAttributedString, at position: Position, width spacing: CGFloat, state: UIControl.State){
        imageView?.contentMode = .center
        setImage(image, for: state)
        
        adjust(attributedTitle: title, at: position, with: spacing)
        
        titleLabel?.contentMode = .center
        setAttributedTitle(title, for: state)
    }
    
    @objc private func adjust(title: NSString, at position: Position, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        
        // Use predefined font, otherwise use the default
        let titleFont: UIFont = titleLabel?.font ?? UIFont()
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])
        
        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }
    
    @objc private func adjust(attributedTitle: NSAttributedString, at position: Position, with spacing: CGFloat) {
        let imageRect: CGRect = self.imageRect(forContentRect: frame)
        let titleSize = attributedTitle.size()
        
        arrange(titleSize: titleSize, imageRect: imageRect, atPosition: position, withSpacing: spacing)
    }
    
    @objc private func arrange(titleSize: CGSize, imageRect:CGRect, atPosition position: Position, withSpacing spacing: CGFloat) {
        switch (position) {
        case .top:
            titleEdgeInsets = UIEdgeInsets(top: -(imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: spacing / 2 + titleSize.height, left: -imageRect.width/2, bottom: 0, right: -imageRect.width/2)
        case .bottom:
            titleEdgeInsets = UIEdgeInsets(top: (imageRect.height + titleSize.height + spacing), left: -(imageRect.width), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: -imageRect.width/2, bottom: spacing / 2 + titleSize.height, right: -imageRect.width/2)
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.width * 2), bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing / 2)
        }
    }
}
