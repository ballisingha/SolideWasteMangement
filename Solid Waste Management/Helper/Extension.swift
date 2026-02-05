//
//  Extension.swift

import UIKit
import MobileCoreServices
//import GoogleMaps  sid




extension UIApplication {
var statusBarUIView: UIView? {

    if #available(iOS 13.0, *) {
        let tag = 3848245

        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first

        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }

    } else {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}

class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
         return .default
    }
 
}

extension UIViewController {
   
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}

extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endEditing(true)
    }
}

extension UIButton {
    
  
    
    // MARK:- Image View
    
    @IBInspectable var rightImage : UIImage?{
        get{
            return self.rightImage
        }set{
            self.setImage(UIImage(named: "white-rightside-arrow"), for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.frame.width-40, bottom: 0, right: 5)
        }
    }
}

extension UITextView {
    func leftSpace() {
        self.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
        func adjustUITextViewHeight() {
            self.translatesAutoresizingMaskIntoConstraints = true
            self.sizeToFit()
            self.isScrollEnabled = false
        }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor?{
        get {
            return self.placeHolderColor
        } set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
                                                            attributes: [
                                                                NSAttributedString.Key.foregroundColor: newValue!,
                                                                //NSAttributedString.Key.font: Config.shared.AppFont(11, fontType: .regular)
                                                            ]
            )
        }
    }
    
    @IBInspectable var padding: CGFloat {
        get {
            return self.padding
        } set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    @IBInspectable var clearBtn: Bool {
        get {
            return true
        } set {
            self.clearButtonMode = .whileEditing
        }
    }
    
    //MARK: - Set TextField right image
    func applyRightArrow(_ imgStr : String){
        let dropdownButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: self.frame.height))
        dropdownButton.backgroundColor = .clear
        dropdownButton.setImage(UIImage(named: imgStr), for: UIControl.State())
        dropdownButton.tintColor = UIColor.lightGray
        let container = UIView(frame: dropdownButton.frame)
        container.backgroundColor = .clear
        container.addSubview(dropdownButton)
        self.rightView = container
        self.rightViewMode = .always
    }
    
    func applyleftImage(_ imgStr : String, Width : CGFloat){
        let dropdownButton = UIButton(frame: CGRect(x: 0, y: 0, width: Width, height: 30))
        dropdownButton.backgroundColor = .clear
        dropdownButton.setImage(UIImage(named: imgStr), for: UIControl.State())
        dropdownButton.tintColor = UIColor.lightGray
        let container = UIView(frame: dropdownButton.frame)
        container.backgroundColor = .clear
        container.addSubview(dropdownButton)
        self.leftView = container
        self.leftViewMode = .always
    }
}

extension UIImage {

    //MARK:- To resize Image or compress image
    func resizedTo2MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > 2024 { // ! Or use 1024 if you need KB but not kB
            
            guard let resizedImage = resizingImage.resized(withPercentage: 0.9),
                let imageData = resizedImage.pngData()
                else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1000.0 // ! Or devide for 1024 if you need KB but not kB
        }
        return resizingImage
    }
    
    //MARK:- To resize Image or compress image
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func get_Currency(_ amount :String)->String {
        return "$\(amount)"
    }
    
    func openSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }

    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var bottomBarheight: CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0.0
    }
    
//    func setNavigationBar() {
//         self.navigationController?.navigationBar.isTranslucent = false
//         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Config.shared.AppFont(20, fontType: .regular),NSAttributedString.Key.foregroundColor: UIColor.black]
//
//         self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-arrow-black-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.toggleLeft))
//    }
    
    func RootViewControllerWithNav(_ RootViewController: UIViewController){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.duration = 1
        slideInFromLeftTransition.type = .fade
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom;
        self.view.window?.layer.add(slideInFromLeftTransition, forKey: kCATransition)
        self.view.window?.rootViewController = UINavigationController (rootViewController: RootViewController)
    }
    
    func pushViewController(_ PushController: UIViewController){
        let DetailVC = PushController
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
	func presentViewController(_ PresentController: UIViewController){
		let DetailVC = PresentController
		let navctrl = UINavigationController(rootViewController: DetailVC)
		navctrl.modalPresentationStyle = .fullScreen
		self.present(navctrl, animated: true, completion: nil)
	}
	
	func presentFull(_ PresentController: UIViewController){
		let DetailVC = PresentController
		DetailVC.modalPresentationStyle = .fullScreen
		self.present(DetailVC, animated: true, completion: nil)
	}
	
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
//    func RootViewWithSideMenu(){
//
//        let homeVC = mainStb.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        let nvc: UINavigationController = UINavigationController(rootViewController: homeVC)
//
//        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: LeftViewController())
//        self.view.window?.rootViewController = slideMenuController
//    }
    
    func RootViewController(_ RootViewController: UIViewController){
        let slideInFromLeftTransition = CATransition()
        slideInFromLeftTransition.duration = 1
        slideInFromLeftTransition.type = .fade
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromBottom;
        self.view.window?.layer.add(slideInFromLeftTransition, forKey: kCATransition)
        self.view.window?.rootViewController = RootViewController
    }
    
    func showViewWithFadeIn(_ View: UIView){
       // self.pleaseWait()
        let animationDuration = 0.35
        View.transform = View.transform.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            View.transform = CGAffineTransform.identity
            View.isHidden = false
            //self.clearAllNotice()
        })
    }
    
    func hideViewWithFadeIn(_ View: UIView){
        let animationDuration = 0.35
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            View.transform = View.transform.scaledBy(x: 0.001, y: 0.001)
        }, completion: { (completion) -> Void in
            View.isHidden = true
        })
    }
    
    func resizeImage(_ image:UIImage) -> UIImage {
        
        let actualHeight = Int(image.size.height);
        let actualWidth = Int(image.size.width);
        let compressionQuality:CGFloat = 0.3
        let newsizeWidth = CGFloat( actualWidth ) * CGFloat(compressionQuality)
        let newsizeHeight = CGFloat( actualHeight ) * CGFloat(compressionQuality)
        let newSize = CGSize(width: newsizeWidth , height: newsizeHeight);
        // Scale the original image to match the new size.
        UIGraphicsBeginImageContext(newSize);
        image.draw(in: CGRect(x: 0, y: 0 , width: newSize.width , height: newSize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return compressedImage!
    }
        
//    func getFlagFromCode(code: String) -> String {
//
//        var cuntryes = [CountryCodeModel]()
//        do {
//            if let file = Bundle.main.url(forResource: "Countries.bundle/Data/CountryCodes", withExtension: "json") {
//                let data = try Data(contentsOf: file)
//                let json = try JSON(data: data) //JSONSerialization.jsonObject(with: data, options: [])
//                for cuntry in json.array ?? [] {
//                    cuntryes.append(CountryCodeModel(json: cuntry))
//                }
//                let fcuntrys = cuntryes.filter { $0.dial_code == code }
//                return fcuntrys.first?.code ?? ""
//
//            } else {
//                print("no file")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        return ""
//    }
}

extension UIView {
    
//    @IBInspectable var shadow: Bool {
//        get {
//            return layer.shadowOpacity > 0.0
//        } set {
//            if newValue == true {
//                dropShadow(.Gray_Kit)
//            }
//        }
//    }
//
    func dropShadow(_ shadowColor : UIColor) {
        self.layer.cornerRadius = 5
       // self.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.8
    
        self.layer.shadowRadius = 1.0
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        } get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            } else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        } get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        } get {
            return layer.cornerRadius
        }
    }
    
    func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIImageView {
     func roundTwoCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UILabel{
    
    func setAttributedHtmlText(_ html: String) {
        if let attributedText = html.attributedHtmlString {
            self.attributedText = attributedText
        }
    }
    
//    func setLabel(text:String,font_size:CGFloat,text_color:UIColor,text_alignment:NSTextAlignment,fontType: OpenSansCode){
//        self.textColor = text_color
//        self.text = text
//        self.textAlignment = text_alignment
//        self.backgroundColor = UIColor.clear
//        self.font = Config.shared.AppFont(font_size, fontType: fontType)
//    }
}

extension Int {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self)/1000)
    }
}




//class CountryCodeModel: NSObject {
//    var name: String
//    var dial_code: String
//    var code: String
//
//    init(json: JSON) {
//        self.name = json["name"].string ?? ""
//        self.dial_code = json["dial_code"].string ?? ""
//        self.code = json["code"].string ?? ""
//    }
//}

// sid
//extension GMSMapView {
//
//    func drowPath(originLat: String, originLon: String, desLat: String, desLong: String, clear: Bool = true) {
//
//        guard let originLat = Double(originLat),
//            let originLon = Double(originLon),
//            let desLat = Double(desLat),
//            let desLong = Double(desLong) else {
//                print("ERROR: COULDN'T CAST VALUE STRING TO DOUBLE")
//                return
//        }
//
//        let origin = CLLocationCoordinate2D(latitude: originLat, longitude: originLon)
//        let destination = CLLocationCoordinate2D(latitude: desLat, longitude: desLong)
//
//
//
//        print(origin)
//        print(destination)
//        self.drowPath(origin: origin, destination: destination, clear: clear)
//    }
//
//    func drowPath(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, clear: Bool = true) {
//
//        let mapOrigin = "\(origin.latitude),\(origin.longitude)"
//        let mapDestination = "\(destination.latitude),\(destination.longitude)"
//
//        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(mapOrigin)&destination=\(mapDestination)&mode=driving&key=\(Config.shared.googleDirectionKey)"
//
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url, completionHandler: {
//            (data, response, error) in
//            if(error != nil){
//                print("error")
//            }else{
//
//                do{
//                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
//
//                    let routes = json["routes"] as! NSArray
//                    if clear {
//
//
//                        DispatchQueue.main.async {
//
//                            self.clear()
//                        }
//                    }
//
//                    for route in routes {
//                        DispatchQueue.main.async {
//                            UIView.animate(withDuration: 0.1) {
//
//                                let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
//                                let points = routeOverviewPolyline.object(forKey: "points")
//                                let path = GMSPath.init(fromEncodedPath: points! as! String)
//                                let polyline = GMSPolyline.init(path: path)
//                                polyline.strokeWidth = 4
//                                polyline.strokeColor = UIColor.black
//
//                                let bounds = GMSCoordinateBounds(path: path!)
//                                self.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
//
//                                polyline.map = self
//
//                                self.drowMarker("ic_Pin-black", position: destination)
//                                self.drowMarker("current-green", position: origin)
//
//                               // self.defaultmarkerWithColor(position: destination, color: .red)
//                            }
//                        }
//                    }
//                }catch let error as NSError{
//                    print("error:\(error)")
//                }
//            }
//        }).resume()
//    }
//
//    func drowMarker(_ image: String, position: CLLocationCoordinate2D) {
//        let marker = GMSMarker()
//        let markerImage = UIImage(named: image)
//        let markerView = UIImageView(image: markerImage)
//        markerView.frame = CGRect(x: 0, y: 10, width: 30, height: 30)
//        markerView.contentMode = .scaleAspectFit
//        marker.position = position
//        marker.iconView = markerView
//        marker.map = self
//        self.selectedMarker = marker
//    }
//
////    func drawCircleCenter(position: CLLocationCoordinate2D) {  // not sid
////
////        let circ = GMSCircle(position: position, radius: 200)
////        circ.fillColor = UIColor.appYellowColor.withAlphaComponent(0.3)
////        circ.strokeColor = UIColor.clear
////        circ.strokeWidth = 0.0
////        circ.map = self
////    }
//
//
//    func defaultmarkerWithColor(position: CLLocationCoordinate2D, color :UIColor){
//            let marker = GMSMarker()
//            marker.position = position
//            marker.map = self
//            marker.icon = GMSMarker.markerImage(with: color)
//            self.selectedMarker = marker
//        }
//
//}
//sid




extension String {
    
    var utfData: Data {
           return Data(utf8)
       }

    var attributedHtmlString: NSAttributedString? {
        do {
            return try NSAttributedString(data: utfData,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
    
    func capitalizingFirstLetter() -> String {
        let first = self.prefix(1).capitalized//String().prefix(1).capitalized//string.prefix(1).//String(str.prefix(1)).capitalized
        let other = self.dropFirst()
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    
   
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // *********Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        //****** Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        //*******Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        //******** Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
    
    
   

    

}


extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}




extension Double {
    var string: String {
        //let rounded = (self * 1000).rounded() / 1000
        // return String(format: "%g", self)
        return String(format: "%.2f", self)
    }
}





extension Double {
    var twoDigitString: String {
        //let rounded = (self * 1000).rounded() / 1000
        // return String(format: "%g", self)
        return String(format: "%.2f", self)
    }
}


extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
