//
//  ExtensionImage.swift
//  SpeedTest_sji
//
//  Created by Sandi Permata on 16.04.20.
//  Copyright © 2020 sample. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
