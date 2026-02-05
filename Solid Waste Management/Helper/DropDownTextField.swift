//
//  DropDownTextField.swift
//  Kit
//
//  Created by Gipl Mac min i5quad on 09/08/21.
//

import Foundation
import UIKit

class NameIdModelDropDown {
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


class DropDownTextField: UITextField {
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    var pickerItems     = [NameIdModelDropDown]()
    var row             = Int()
    var id              = String()
    var selectedItems   = [Int]()
    var isCancelTap     = false
    
    var pickItem = [String]()
    let animationDuration = 0.3
    
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    
    // MARK:- Init
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
    }
    
    func setupBorder() {
        self.borderStyle = .none
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.systemGray5.cgColor
     //   self.cornerRadius = 10
       // self.layer.borderColor = UIColor.yellowColor.cgColor
        self.backgroundColor = .white
    }
    
    @IBInspectable var Border: Bool = false { didSet{ setupBorder() } }
    @IBInspectable var leftSpace: CGFloat = 0.0 { didSet{ setLeftSpace() } }

    func setLeftSpace() {
        let leftVw = UIView(frame:CGRect(x: 0,y: 0,width: leftSpace, height: 40))
        leftVw.isUserInteractionEnabled = false
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = leftVw
    }
    
    
        
        func setEyeBtn(){
            let eyePassBtn = UIButton(frame:CGRect(x: 0,y: 0,width: 30,height: self.frame.height))
            eyePassBtn.setImage(UIImage(named: "visibility"), for: .normal)
            eyePassBtn.addTarget(self, action: #selector(eyeBtnAction(_:)), for: .touchUpInside)
            let container = UIView(frame: CGRect(x: 0,y: 0,width: 35,height: self.frame.height))
            container.addSubview(eyePassBtn)
            self.rightView = container
            self.rightViewMode = UITextField.ViewMode.always
        }
        
        @objc func eyeBtnAction(_ sender : UIButton){
            self.isSecureTextEntry = !self.isSecureTextEntry
            sender.setImage(self.isSecureTextEntry ? UIImage(named: "visibility") : UIImage(named: "unvisibility"), for: .normal)
        }
    
    
    @IBInspectable var EyeBtn: Bool = false { didSet{ setEyeBtn() } }

    // MARK:- Image View
    
    @IBInspectable var leftImage : UIImage? { didSet{ leftImageView() } }
    @IBInspectable var rightImage : UIImage? { didSet{ rightImageView() } }
    
    func leftImageView() {
        
        let leftVw = UIButton(frame:CGRect(x: 0,y:0,width: 30,height: self.frame.height))
        leftVw.setImage(leftImage, for: .normal)
        leftVw.backgroundColor = .clear
        
        let container = UIView(frame: leftVw.frame)
        container.backgroundColor = .clear
        container.addSubview(leftVw)
        self.leftView = container
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func rightImageView() {
        
        let rightVw = UIButton(frame:CGRect(x: 0,y: 0,width: 30,height: self.frame.height))
        rightVw.setImage(rightImage, for: .normal)
        rightVw.isUserInteractionEnabled = false
        
        let container = UIView(frame: CGRect(x: 0,y: 0,width: 35,height: self.frame.height))
        container.isUserInteractionEnabled = false
        container.backgroundColor = .clear
        container.addSubview(rightVw)
        self.rightView = container
        self.rightViewMode = UITextField.ViewMode.always
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
            border.frame = CGRect(x: 0.0, y: frame.size.height - linesWidth, width: frame.size.width, height: linesWidth)
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
extension DropDownTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    
    @objc func pickerDoneAction() {
        
        self.tag = 4
        self.text = self.pickerItems[row].name
        self.text = self.pickerItems[row].name
        self.id = self.pickerItems[row].id
        self.resignFirstResponder()
    }
    
  //MARK:- Function for dropdown of name id model type
    func setInputPickerView(_ pickerItems: [NameIdModelDropDown]) {
        
        self.tintColor = .clear
        
        self.endEditing(true)
        //self.isEditing = false
        //self.isEnabled = false
        
        self.pickerItems = pickerItems
        
        if self.pickerItems.count == 0 {
            self.pickerItems.append(NameIdModelDropDown(_id: "", _name: ""))
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
        toolBar.tintColor = .black //sid
        
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


extension DropDownTextField {
    
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
