//
//  BaseViewController.swift
//  SpeedTest_sji
//
//  Created by Sandi Permata on 21.04.20.
//  Copyright © 2020 sample. All rights reserved.
//

import UIKit
import Foundation


class baseViewController: UIViewController  {
    
    /*
     NVActivityIndicatorViewable
     private let presentingIndicatorTypes = {
     return NVActivityIndicatorType.allCases.filter { $0 != .blank }
     }()
     
     func starLoading(){
     // 0 - 31
     let size = CGSize(width: 30, height: 30)
     let selectedIndicatorIndex = 15
     let indicatorType = presentingIndicatorTypes[selectedIndicatorIndex]
     let showData = startAnimating()
     startAnimating(size, message: "Loading...", type: indicatorType, fadeInAnimation: nil)
     
     DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
     NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
     }
     }
     
     func stopLoading(){
     DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
     self.stopAnimating(nil)
     }
     }
     */
    var reachability = Reachability()!
    var window: UIWindow?
    
    override func viewWillAppear(_ animated: Bool) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closeKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func checkInternet(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged , object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            print("Could not strat notifier")
        }
    }
    
    @objc  func internetChanged(note:Notification)  {
        let reachability  =  note.object as! Reachability
        if reachability.connection == .none{
            self.showErrorPage(mainTitle: "Message", subTitle: "Please Cek Internet Connection", errorNo: "", buttonTitle: "Close", fromPage: "")
        }
    }
    func setImageTitle() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "sji")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    func setupNavigationBar_Cross(withTitle: String, subtitle: String? = nil, barTintColor: UIColor? = UIColor.white, tintColor: UIColor? = UIColor(red: 21/255.0, green: 170/255.0, blue: 191/255.0, alpha: 1.0), noShadow: Bool? = false, titleColor: UIColor? = UIColor.black) {
        
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.setupLeftNavigationBarButtonWithImage_Cross(image: UIImage(named: "close.png")!)
        self.navigationController?.navigationBar.tintColor = tintColor?.withAlphaComponent(0.7)
        self.navigationController?.navigationBar.isTranslucent = false
        
        if (noShadow == true) {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textColor = (nil != titleColor) ? titleColor : tintColor
        titleLabel.numberOfLines = 0
        
        titleLabel.text = withTitle
        //            titleLabel.font = UIFont.appFont(fontType: FontType.bold, fontSize: FontSize.S)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    func setupNavigationBar_Cross_back(withTitle: String, subtitle: String? = nil, barTintColor: UIColor? = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.0), tintColor: UIColor? = UIColor(red: 21/255.0, green: 170/255.0, blue: 191/255.0, alpha: 1.0), noShadow: Bool? = false, titleColor: UIColor? = UIColor.black) {
        
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.setupLeftNavigationBarButtonWithImage_Cross_back()
        self.navigationController?.navigationBar.tintColor = tintColor?.withAlphaComponent(0.7)
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textColor = (nil != titleColor) ? titleColor : tintColor
        titleLabel.numberOfLines = 0
        titleLabel.text = ""
        
        titleLabel.text = withTitle
        //            titleLabel.font = UIFont.appFont(fontType: FontType.bold, fontSize: FontSize.S)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    
    func setupNavigationBar_Back(withTitle: String, subtitle: String? = nil, barTintColor: UIColor? = UIColor.white, tintColor: UIColor? = UIColor(red: 21/255.0, green: 170/255.0, blue: 191/255.0, alpha: 1.0), noShadow: Bool? = false, titleColor: UIColor? = UIColor.black) {
        
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 8, width: UIScreen.main.bounds.width, height: 20))
        titleLabel.textColor = UIColor.black
        //            titleLabel.font = UIFont.appFont(fontType: FontType.bold, fontSize: FontSize.S)
        titleLabel.numberOfLines = 0
        titleLabel.text = withTitle
        
        let titleView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.navigationController?.navigationBar.frame.height)!))
        titleView.backgroundColor = UIColor.white
        titleView.addSubview(titleLabel)
        
        self.navigationItem.titleView = titleView
        
        
        //            self.navigationController?.navigationBar.shadowImage = UIColor.blue
        //            self.navigationController?.navigationBar.shadowImage = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08).as1ptImage()
        self.setupLeftNavigationBarButtonWithImage_Back(image: UIImage(named: "leftblue.png")!)
        self.navigationController?.navigationBar.tintColor = tintColor?.withAlphaComponent(0.7)
        self.navigationController?.navigationBar.isTranslucent = false
        
        if (noShadow == true) {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
    }
    
    func setupLeftNavigationBarButtonWithImage_Back(image: UIImage) {
        self.navigationController?.navigationBar.backIndicatorImage = resizeImage(image: image, targetSize: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    func setupLeftNavigationBarButtonWithImage_Cross(image: UIImage) {
        let image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let barButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(leftBarButtonItemAction_Cross(sender:)))
        self.navigationItem.setLeftBarButton(barButtonItem, animated: true)
    }
    
    func setupLeftNavigationBarButtonWithImage_Cross_back() {
        let attributes = [NSAttributedString.Key.font:  loadFonts.loadFontWithSize(.S12, .MontserratRegular)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //             self.navigationController?.navigationBar.shadowImage = UIColor.blue
        //            self.navigationController?.navigationBar.shadowImage = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08).as1ptImage()
    }
    
    func resizeImage(image: UIImage, targetSize: CGRect) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @objc func leftBarButtonItemAction_Cross(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func leftBarButtonItemAction_Cross_back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func leftBarButtonItemAction_Back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func SetRightSIDEImage(TextField: UITextField, ImageName: String){
        let rightImageView = UIImageView()
        rightImageView.contentMode = .scaleAspectFit
        
        let rightView = UIView()
        
        rightView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        rightImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        TextField.rightViewMode = .always
        TextField.rightView = rightView
        
        let image = UIImage(named: ImageName)?.withRenderingMode(.alwaysTemplate)
        rightImageView.image = image
        rightImageView.tintColor = UIColor(red: 106/255, green: 79/255, blue: 131/255, alpha: 1.0)
        rightImageView.tintColorDidChange()
        
        rightView.addSubview(rightImageView)
    }
    
    
    
    func testConvert(_ something: Any) {
        guard something is [AnyHashable: Any] else {
            print("\(something) couldn't be converted to Dictionary")
            return
        }
        print("\(something) successfully converted to Dictionary")
    }
    
    func toastAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(3.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
            alert.dismiss(animated: true, completion: {() -> Void in
            })
        })
    }
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x:0, y:0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func paddingTextField(textField: UITextField) {
        let paddingTextField = UIView(frame: CGRect(x:0, y:0, width:15, height:textField.frame.height))
        textField.leftView = paddingTextField
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func getTimeComponentString(olderDate older: Date,newerDate newer: Date) -> (String?)  {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.minute , .hour , .day,.month, .weekOfMonth,.year], from: older, to: newer)
        
        let year = componentsLeftTime.year ?? 0
        if  year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }
        
        
        let month = componentsLeftTime.month ?? 0
        if  month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }
        
        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if  weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }
        
        let day = componentsLeftTime.day ?? 0
        if  day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }
        
        let hour = componentsLeftTime.hour ?? 0
        if  hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if  minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }
        return nil
    }
    
    func df2so(_ price: Double) -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.negativeFormat = "(0.00)"
        currencyFormatter.positiveFormat = "#,##0.00"
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: price))!
        print("before return df2so")
        print(priceString)
        return priceString
    }
    
    
    func animate(vc: UIViewController) {
        if let window = self.window {
            
            let snapShotView = window.snapshotView(afterScreenUpdates: true)
            
            vc.view.addSubview(snapShotView!)
            snapShotView?.layer.zPosition = 1000
            window.rootViewController = vc
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { () -> Void in
                snapShotView?.alpha = 0.0
            }) { (finished) -> Void in
                snapShotView?.removeFromSuperview()
            }
            
            window.makeKeyAndVisible()
        }
    }
    
    func decimal(with string: String) -> NSDecimalNumber {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        return formatter.number(from: string) as? NSDecimalNumber ?? 0
    }
    
    func showErrorPage(mainTitle: String, subTitle: String, errorNo: String, buttonTitle: String, fromPage: String) {
        //        let vc = popUpScreenViewController()
        //        vc.titlePertamaTemp = mainTitle
        //        vc.isiLabelTemp = subTitle
        //        vc.btn = buttonTitle
        //        vc.asal = fromPage
        //        vc.code = errorNo
        //        self.present(vc, animated: true, completion: nil)
    }
    /*
     func showErrorPage(mainTitle: String, subTitle: String, errorNo: String, buttonTitle: String, fromPage: String) {
     let vc = ErrorMessagingSingleBtnViewController()
     vc.mainTitle = mainTitle
     vc.subTitle = subTitle
     vc.btn = buttonTitle
     vc.asal = fromPage
     vc.code = errorNo
     self.present(vc, animated: true, completion: nil)
     }
     
     func showErrorPageDoubleButton(mainTitle: String, subTitle: String, buttonTitle: String,scndButtonTitle: String, fromPage: String) {
     let vc = ErrorMessagingDoubleBtnViewController()
     vc.mainTitle = mainTitle
     vc.subTitle = subTitle
     vc.btn = buttonTitle
     vc.scndbtn = scndButtonTitle
     vc.asal = fromPage
     self.present(vc, animated: true, completion: nil)
     }
     
     func showErrorPage(mainTitle: String, buttonTitle: String, fromPage: String) {
     let vc = ErrorMessagingSingleBtnViewController()
     vc.mainTitle = mainTitle
     vc.btn = buttonTitle
     vc.asal = fromPage
     self.present(vc, animated: true, completion: nil)
     }
     */
    func navTransparant() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    func noDuplicates(_ arrayOfDicts: [[String: Any]]) -> [[String: Any]] {
        var noDuplicates = [[String: Any]]()
        var transactionId = [Int]()
        for dict in arrayOfDicts {
            if let id = dict["transactionId"], !transactionId.contains(id as! Int) {
                noDuplicates.append(dict)
                transactionId.append(id as! Int)
            }
        }
        return noDuplicates
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
