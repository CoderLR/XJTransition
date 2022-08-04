//
//  XJCollectionViewController.swift
//  XJTransition
//
//  Created by xj on 2022/8/4.
//

import UIKit

// StatusBar
let KStatusBarH: CGFloat = UIApplication.shared.statusBarFrame.height

// Navbar
let KNavBarH: CGFloat = KStatusBarH + 44

class XJCollectionViewController: UIViewController {
    
    let screenW = UIScreen.main.bounds.size.width
    let screenH = UIScreen.main.bounds.size.height
    let margin = 15.0
    var cellWH: CGFloat = 0
    
    // 传值
    var anitionType: XJTransitionAnimationType = .normal
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellWH = (self.screenW - self.margin * 4) / 3
        self.view.backgroundColor = UIColor.white

        steupUI()
    }
    
    deinit {
        print("\(self)-----dealloc")
    }
}

extension XJCollectionViewController {
    
    func steupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        /*
         layout.itemSize = CGSize(100, 100)
         layout.minimumLineSpacing = 0
         layout.minimumInteritemSpacing = 0
         */
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: KNavBarH, width: screenW, height: screenH - KNavBarH), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        // 适配ios11
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        collectionView.register(XJCollectionCell.self, forCellWithReuseIdentifier: "XJCollectionCell")
        self.view.addSubview(collectionView)
    }
}

extension XJCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 返回组数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 返回cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XJCollectionCell", for: indexPath)
        return cell
    }
    
    // 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? XJCollectionCell else { return }
        
        let detailVc = XJDetailViewController()
        detailVc.imgColor = cell.imageView.backgroundColor
        
        let property = XJTransitionProperty()
        property.animationType = self.anitionType
        property.startView = cell.imageView
        property.targetView = detailVc.imageView
        self.xj_presentViewController(viewController: detailVc, property: property)
    }
    
    // 定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWH, height: cellWH)
    }
    
    // 定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    // 这个是两行cell之间的间距（上下行cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    // 两个cell之间的间距（同一行的cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}

class XJCollectionCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "")
        img.contentMode = .scaleAspectFit
        img.backgroundColor = UIColor.randomColor
        return img
    }()
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载UI
    fileprivate func setupUI() {
        contentView.addSubview(imageView)
    }
    
    // 布局UI
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}


class XJDetailViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "")
        img.contentMode = .scaleAspectFit
        img.backgroundColor = imgColor
        return img
    }()
    
    // 传值
    var imgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        self.view.addGestureRecognizer(tap)
    }
    
    deinit {
        print("\(self)-----dealloc")
    }
                                         
    @objc func tapAction(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true)
    }
}
