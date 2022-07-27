//
//  XJPresentViewController.swift
//  XJTransition
//
//  Created by xj on 2022/7/19.
//

import UIKit

class XJPresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let image = UIImageView(frame: self.view.bounds)
        image.backgroundColor = UIColor(hexString: "#FFB6C1")
        self.view.addSubview(image)
        
        let button = UIButton()
        button.setTitle("点击Dimiss返回", for: .normal)
        button.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.frame.size = CGSize(width: self.view.frame.size.width - 100, height: 40)
        button.center = self.view.center
        button.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        self.view.addSubview(button)
    }
    
    @objc func dismiss(_ btn: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("\(self)-----dealloc")
    }
}
