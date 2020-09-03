//
//  LoadFont.swift
//  sandiFramework
//
//  Created by SANDI on 27/08/20.
//  Copyright © 2020 sample. All rights reserved.
//

import UIKit

public class LoadFonts: NSObject {
    public enum FontSizes: CGFloat {
        case S64 = 64
        case S46 = 46
        case S36 = 36
        case S32 = 32
        case S31 = 31
        case S30 = 30
        case S29 = 29
        case S28 = 28
        case S27 = 27
        case S26 = 26
        case S25 = 25
        case S24 = 24
        case S23 = 23
        case S22 = 22
        case S21 = 21
        case S20 = 20
        case S19 = 19
        case S18 = 18
        case S17 = 17
        case S16 = 16
        case S15 = 15
        case S14 = 14
        case S13 = 13
        case S12 = 12
        case S11 = 11
        case S10 = 10
        case S9 = 9
        case S8 = 8
        case S7 = 7
        
        public static func getPreferredFontSize(defaultSize: CGFloat) -> CGFloat {
            let defaultFontSize = defaultSize
            
            // IN CASE YOU NEED DIFFERENT FONT SIZE PER DEVICE, SET HERE 😉
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 960:
                    // For "iPhone 4 or 4S or 4C"
                    return defaultFontSize
                case 1136:
                    // For "iPhone 5 or 5S or 5C"
                    return defaultFontSize
                case 1334:
                    // For "iPhone 6/6S/7/8"
                    return defaultFontSize
                case 1920, 2208:
                    // for "iPhone 6+/6S+/7+/8+"
                    return defaultFontSize
                case 2436, 1792, 2688:
                    // for "iPhone X"
                    return defaultFontSize
                default:
                    return defaultFontSize
                    
                }
            }
            return defaultSize
        }
    }

    
    public enum FontTypes: String {
        case RobotoBold = "Roboto-Bold"
        case RobotoRegular = "Roboto-Regular"
        case RobotoLight = "Roboto-Light"
        case MontserratBold = "Montserrat-Bold"
        case MontserratRegular = "Montserrat-Regular"
        case OpenSansBold = "OpenSans-Bold"
        case OpenSansRegular = "OpenSans-Regular"
        case OpenSansSemiBold = "OpenSans-SemiBold"
        case RalewayBold = "Raleway-Bold"
        case RalewayRegular = "Raleway-Regular"
        case PlayfairDisplayRegular = "PlayfairDisplay-Regular"
        case PlayfairDisplayBold = "PlayfairDisplay-Bold"
        case CaveatRegular = "Caveat-Regular"
        case CaveatBold = "Caveat-Bold"
    }
    
    public class func loadFontWithSize(_ size: FontSizes, _ fontType: FontTypes) -> UIFont? {
        let fontName = fontType
        var font = UIFont(name: fontName.rawValue, size: size.rawValue)
        if font == nil {
            self.dynamicallyLoadFontNamed(fontName.rawValue)
            font = UIFont(name: fontName.rawValue, size: size.rawValue)

            // safe fallback
            if font == nil {
                font = UIFont.systemFont(ofSize: size.rawValue)
            }
        }

        return font
    }
    
    class func dynamicallyLoadFontNamed(_ name: String?) {
        let resourceName = name
        let bundle = Bundle(for: self.classForCoder())
        let url = bundle.url(forResource: resourceName, withExtension: "ttf")
        var fontData: Data? = nil
        if let url = url {
            fontData = try? Data(contentsOf: url)
        }
        if fontData != nil {
            var provider: CGDataProvider? = nil
            if let data = fontData as? CFData? {
                provider = CGDataProvider(data: data!)
            }
            let font = CGFont(provider!)
            if let font = font {
                print(font)
                var error: Unmanaged<CFError>?
                CTFontManagerRegisterGraphicsFont(font, &error)
            }
        }
    }

}


/*
 titleLabel?.font = loadFonts.loadFontWithSize(.S10, .MontserratRegular)
 */
