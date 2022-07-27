//
//  XJPushViewController.swift
//  XJTransition
//
//  Created by xj on 2022/7/19.
//

import UIKit

class XJPushViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let image = UIImageView(frame: self.view.bounds)
        image.backgroundColor = UIColor(hexString: "#87CEEB")
        self.view.addSubview(image)
        
        let button = UIButton()
        button.setTitle("点击Pop返回", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.frame.size = CGSize(width: self.view.frame.size.width - 100, height: 40)
        button.center = self.view.center
        button.addTarget(self, action: #selector(pop(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "#333333")?.cgColor
        
        self.view.addSubview(button)
    }
    
    @objc func pop(_ btn: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("\(self)-----dealloc")
    }

}
