//
//  FloatLabelTextField.swift
//  Dcomfy
//
//  Created by Fahim Farook on 28/11/14.
//  Copyright (c) 2014 RookSoft Ltd. All rights reserved.
//

import UIKit

class NameIdModel {
    var name: String
    var id: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.id = json["_id"].stringValue
    }
    
    init(_id: String, _name: String) {
        self.name       = _name
        self.id         = _id
    }
    
}


class CustomTextField: UITextField {
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    var pickerItems     = [NameIdModel]()
    var row             = Int()
    var id              = String()
    var selectedItems   = [Int]()
    var isCancelTap     = false
    
    var pickItem = [String]()
    let animationDuration = 0.3
    
    var title = UILabel()
    
    
    // MARK:- Properties
    override var accessibilityLabel:String? {
        get {
            if text!.isEmpty {
                return title.text
            } else {
                return text
            }
        }
        set {
            self.accessibilityLabel = newValue
        }
    }
    
    override var placeholder:String? {
        didSet {
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    override var attributedPlaceholder:NSAttributedString? {
        didSet {
            title.text = attributedPlaceholder?.string
            title.sizeToFit()
        }
    }
    
    var titleFont:UIFont =  Config.shared.AppFont(16, fontType: .regular)
    {
        didSet {
            title.font = titleFont
        }
    }
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    
    @IBInspectable var titleYPadding:CGFloat = 0.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }
    
    @IBInspectable var titleTextColour:UIColor = .white{
        didSet {
            if !isFirstResponder {
                title.textColor = titleTextColour
            }
        }
    }
    
    @IBInspectable var titleActiveTextColour:UIColor! {
        didSet {
            if isFirstResponder {
                title.textColor = titleActiveTextColour
            }
        }
    }
    
    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
        
        self.font = Config.shared.AppFont(16, fontType: .regular)
    }
    
    // MARK:- Overrides
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if isResp && !text!.isEmpty {
            title.textColor = titleActiveTextColour
        } else {
            title.textColor = titleTextColour
        }
        if text!.isEmpty {
            hideTitle(isResp)
        } else {
            showTitle(isResp)
        }
    }
    
    override func textRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.textRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func editingRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.editingRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = r.inset(by: UIEdgeInsets.init(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return r.integral
    }
    
    override func clearButtonRect(forBounds bounds:CGRect) -> CGRect {
        var r = super.clearButtonRect(forBounds: bounds)
        if !text!.isEmpty {
            var top = ceil(title.font.lineHeight + hintYPadding)
            top = min(top, maxTopInset())
            r = CGRect(x:r.origin.x, y:r.origin.y + (top * 0.5), width:r.size.width, height:r.size.height)
        }
        return r.integral
    }
    
    // MARK:- Public Methods
    
    // MARK:- Private Methods
    fileprivate func setup() {
        borderStyle = UITextField.BorderStyle.none
        titleActiveTextColour = .black
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = titleTextColour
        if let str = placeholder {
            if !str.isEmpty {
                title.text = str
                title.sizeToFit()
            }
        }
        self.addSubview(title)
    }
    
    fileprivate func maxTopInset()->CGFloat {
        return max(0, floor(bounds.size.height - font!.lineHeight - 4.0))
    }
    
    fileprivate func setTitlePositionForTextAlignment() {
        let r = textRect(forBounds: bounds)
        var x = r.origin.x
        if textAlignment == NSTextAlignment.center {
            x = r.origin.x + (r.size.width * 0.5) - title.frame.size.width
        } else if textAlignment == NSTextAlignment.right {
            x = r.origin.x + r.size.width - title.frame.size.width
        }
        title.frame = CGRect(x:x, y:title.frame.origin.y, width:title.frame.size.width, height:title.frame.size.height)
    }
    
    fileprivate func showTitle(_ animated:Bool) {
        
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    @IBInspectable var leftSpace: CGFloat = 0.0 { didSet{ setLeftSpace() } }
    
    func setLeftSpace() {
        let leftVw = UIButton(frame:CGRect(x: 0,y: 0,width: leftSpace, height: 40))
        leftVw.isUserInteractionEnabled = false
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = leftVw
    }
    
    
//    @IBInspectable var placeHolderColorCustom: UIColor?{
//        get {
//            return self.placeHolderColor
//        } set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
//                                                            attributes: [
//                                                                NSAttributedString.Key.foregroundColor: newValue!,
//                                                                 NSAttributedString.Key.font: Config.shared.AppFont(16, fontType: .regular)
//                                                            ]
//            )
//        }
//    }
    
    // MARK:- Image View
    
    @IBInspectable var leftImage : UIImage? { didSet{ leftImageView() } }
    @IBInspectable var rightImage : UIImage? { didSet{ rightImageView() } }
    
    func leftImageView() {
        
        let leftVw = UIButton(frame:CGRect(x: 0,y: 5,width: 30,height: 30))
        leftVw.setImage(leftImage, for: .normal)
        leftVw.isUserInteractionEnabled = false
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = leftVw
    }
    
    func rightImageView() {
        
        let rightVw = UIButton(frame:CGRect(x: 0,y: 5,width: 30,height: 30))
        rightVw.setImage(rightImage, for: .normal)
        rightVw.isUserInteractionEnabled = false
        self.rightViewMode = UITextField.ViewMode.always
        self.rightView = rightVw
    }
    
    
    // MARK:- Line View
    
    @IBInspectable var linesWidth: CGFloat = 0.5 { didSet{ drawLines() } }
    
    @IBInspectable var linesColor: UIColor = UIColor.darkGray { didSet{ drawLines() } }
    
    @IBInspectable var leftLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var rightLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var bottomLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var topLine: Bool = false { didSet{ drawLines() } }
    
    fileprivate func drawLines() {
        
        if bottomLine {
            let border = CALayer()
            border.frame = CGRect(x: 0.0, y: frame.size.height - linesWidth, width: UIScreen.main.bounds.size.width-60, height: linesWidth)
            border.backgroundColor = linesColor.cgColor
            layer.addSublayer(border)
        }
        
        if topLine {
            let border = CALayer()
            border.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: linesWidth)
            border.backgroundColor = linesColor.cgColor
            layer.addSublayer(border)
        }
        
        if rightLine {
            let border = CALayer()
            border.frame = CGRect(x: frame.size.width - linesWidth, y: 0.0, width: linesWidth, height: frame.size.height);
            border.backgroundColor = linesColor.cgColor
            layer.addSublayer(border)
        }
        
        if leftLine {
            let border = CALayer()
            border.frame = CGRect(x: 0.0, y: 0.0, width: linesWidth, height: frame.size.height);
            border.backgroundColor = linesColor.cgColor
            layer.addSublayer(border)
        }
    }
    
}


//MARK:- UIPickerView
extension CustomTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    
    @objc func pickerDoneAction() {
        
        self.tag = 4
        self.text = self.pickerItems[row].name
        self.id = self.pickerItems[row].id
        self.resignFirstResponder()
    }
    
    //MARK:- Function for dropdown of name id model type
    func setInputPickerView(_ pickerItems: [NameIdModel]) {
        
        self.tintColor = .clear
        
        self.endEditing(true)
        //self.isEditing = false
        //self.isEnabled = false
        
        self.pickerItems = pickerItems
        
        if self.pickerItems.count == 0 {
            self.pickerItems.append(NameIdModel(_id: "", _name: ""))
        }
        
        self.row = 0
        let screenWidth = UIScreen.main.bounds.width
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        pickerView.delegate = self
        pickerView.dataSource = self
        self.inputView = pickerView
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(pickerDoneAction))
        //        barButton.tintColor = .Purple_Kit
        //        cancel.tintColor = .Purple_Kit
        toolBar.tintColor = .red //sid
        
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar
    }
    
    @objc func doneAction() {
        if self.pickItem.count > 0 {
            self.text = self.pickItem[row]
        }
        self.resignFirstResponder()
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerItems.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerItems[row].name
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    
    
    //MARK:- Date Picker
    func setInputViewDatePicker(maximumDate: Date? , minimumDate: Date? , mode: UIDatePicker.Mode) {
        
        // self.endEditing(true)
        self.tintColor = .clear
        
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = mode //2
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        if maximumDate != nil {
            datePicker.maximumDate = maximumDate
        }
        if minimumDate != nil {
            datePicker.minimumDate = minimumDate
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar()
        toolBar.sizeToFit()//4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(tapDone)) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
        toolBar.tintColor = .red //sid
    }
    
    @objc func tapCancel() {
        self.isCancelTap = true
        self.resignFirstResponder()
    }
    
    @objc func tapDone() {
//        self.isCancelTap = false
//        if let datePicker = self.inputView as? UIDatePicker {
//            let dateformatter = DateFormatter()
//            dateformatter.dateStyle = .medium
//            dateformatter.locale = Locale(identifier: "GMT+05:30")
//            dateformatter.dateFormat = Config.shared.dateFormat
//            if self.tag == 8 {
//                dateformatter.dateFormat = "hh:mm a"
//            }
//            self.text = dateformatter.string(from: datePicker.date)
//        }
//        self.resignFirstResponder()
    }
    
}


extension CustomTextField {
    
//    func setCountryCode(){
//        let CCBtn = UIButton(frame:CGRect(x: 10,y: 0,width: 30,height: self.frame.height))
//        CCBtn.setTitle("+61", for: .normal)
//        CCBtn.setTitleColor(.white, for: .normal)
//        CCBtn.titleLabel?.font = Config.shared.AppFont(16, fontType: .bold)
//        let container = UIView(frame: CGRect(x: 0,y: 0,width: 46,height: self.frame.height))
//        container.addSubview(CCBtn)
//        self.leftView = container
//        self.leftViewMode = UITextField.ViewMode.always
//    }
}
