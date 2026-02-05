//
//  LoginVC.swift
//  Solid Waste Management
//
//  Created by Guriqbal Singh Amroke on 08.01.26.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var btnGerman: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEnglish.roundCorner([.topLeft, .bottomLeft], radius: CGFloat(10))
        btnEnglish.layer.borderWidth = 1
        btnEnglish.layer.borderColor = UIColor.BorderColor.cgColor
        btnGerman.roundCorner([.topRight, .bottomRight], radius: CGFloat(10))
        btnGerman.layer.borderWidth = 1
        btnGerman.layer.borderColor = UIColor.BorderColor.cgColor
        
    }
    @IBAction func englishBtnPressed(_ sender: Any) {
        btnEnglish.backgroundColor = UIColor.TextColor
        btnEnglish.setTitleColor(UIColor.white, for: .normal)
        btnGerman.backgroundColor = UIColor.white
        btnGerman.setTitleColor(UIColor.gray, for: .normal)
    }
    
    @IBAction func germanBtnPressed(_ sender: Any) {
        btnGerman.backgroundColor = UIColor.TextColor
        btnGerman.setTitleColor(UIColor.white, for: .normal)
        btnEnglish.backgroundColor = UIColor.white
        btnEnglish.setTitleColor(UIColor.gray, for: .normal)
    }
}
