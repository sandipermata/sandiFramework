//
//  LocalizableString.swift
//  podGeneralSJI
//
//  Created by adriansalim on 27/05/20.
//  Copyright © 2020 adriansalim. All rights reserved.
//

import UIKit

class LocalizableString: NSObject {
    
    public enum languageCode: String {
        case english = "en"
        case indonesian = "id"
    }
    
    public func setDefaultLanguage(value: languageCode) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "defaultLanguage")
    }
    
    public func getDefaultLanguage() -> String {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: "defaultLanguage") as! String
        return value
    }
}


extension String {
    public func localized(_ lang:String) ->String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}


/*
 How to use
 1. LocalizableString.setDefaultLanguage(.english)
 2. exampleLabel.text = "NAME_LOCALIZABLE_STRING".localize(LocalizableString.getDefaultLanguage())
 */
