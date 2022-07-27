//
//  XJRootViewController.swift
//  XJTransition
//
//  Created by xj on 2022/7/19.
//

import UIKit

let statusBarH: CGFloat = UIApplication.shared.statusBarFrame.size.height

class XJRootViewController: UIViewController {

    lazy var bgImage: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.backgroundColor = UIColor(hexString: "#FAEBD7")
        return imageView
    }()
    
    fileprivate var listModel: [ListModel] = ListModel.getListModels()
    
    let footerH: CGFloat = 0.01
    let headerH: CGFloat = 50
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "动画"
        
        setupUI()
    }

}

extension XJRootViewController {
    fileprivate func setupUI() {
        
        self.view.addSubview(bgImage)
        
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: statusBarH, left: 0, bottom: 0, right: 0)
        self.view.addSubview(tableView)
    }
}

extension XJRootViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // 返回组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return listModel.count
    }
    
    // 返回每组个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel[section].models.count
    }
    
    // 返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = Cell.tableViewCell(tableView: tableView)
        cell.setBtnIndexPath(indexPath)
        let model = self.listModel[indexPath.section]
        cell.model = model.models[indexPath.row]
        cell.btnClickBlock = {[weak self] (type, indexPath) in
            guard let self = self else { return }
            self.clickAction(type: type, indexPath: indexPath)
        }
        return cell
    }
    
    // 返回cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // 点击cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let pushVc = XJPushViewController()
                self.navigationController?.pushViewController(pushVc, animated: true)
            } else {
                let presentVc = XJPresentViewController()
                if indexPath.row < 4 {
                    presentVc.modalPresentationStyle = .popover
                } else {
                    presentVc.modalPresentationStyle = .fullScreen
                }
                
                /// partialCurl存在系统bug
                presentVc.modalTransitionStyle = UIModalTransitionStyle(rawValue: (indexPath.row - 1) % 3)!
                
                self.present(presentVc, animated: true)
            }
        }
    }

    // 返回header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //if section == 0 { return nil }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: headerH))
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hexString: "#FF4500")
        label.text = listModel[section].title
        label.frame = CGRect(x: 15, y: 0, width: 200, height: headerH)
        header.addSubview(label)
        return header
    }

    // 返回header高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //if section == 0 { return 0.01}
        return headerH
    }

    // 返回footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    // 返回footer高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerH
    }
}


// MARK: - 处理点击事件
extension XJRootViewController {
    func clickAction(type: Int, indexPath: IndexPath) {
        print(indexPath)
        
        var animationType: XJTransitionAnimationType = .normal
        
        // 系统动画
        if indexPath.section == 1 {
            animationType = XJTransitionAnimationType(rawValue: indexPath.row + 1) ?? .normal
            
        // 自定义动画
        } else if indexPath.section == 2 {
            animationType = XJTransitionAnimationType(rawValue: indexPath.row + 34) ?? .normal
        }
        
        print(animationType)
        
        // push
        if type == 1 {
            let pushVc = XJPushViewController()
            self.navigationController?.xj_pushViewController(viewController: pushVc, animationType: animationType)
        // present
        } else {
            let presentVc = XJPresentViewController()
            self.xj_presentViewController(viewController: presentVc, animationType: animationType, completion: nil)
        }
    }
}

/**************************************************************************************************/
class Cell: UITableViewCell {
    
    /// 标题
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.textColor = UIColor(hexString: "#00C957")
        lb.backgroundColor = UIColor.clear
        lb.textAlignment = .left
        return lb
    }()

    // push
    lazy var pushBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexString: "#87CEEB")
        btn.setTitle("push", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(pushBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    // present
    lazy var presentBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexString: "#FFB6C1")
        btn.setTitle("present", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.cornerRadius = 8
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(presentBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    // type = 1 push, type = 2 present
    var btnClickBlock: ((_ type: Int ,_ indexPath: IndexPath) -> Void)?
    
    // 模型
    var model: Model? {
        didSet {
            self.titleLabel.text = model?.name
        }
    }
    
    // 设置标识
    func setBtnIndexPath(_ indexPath: IndexPath) {
       
        pushBtn.isHidden = indexPath.section == 0 ? true : false
        presentBtn.isHidden = indexPath.section == 0 ? true : false
        
        pushBtn.indexPath = indexPath
        presentBtn.indexPath = indexPath
    }

    // 类方法初始化
    class func tableViewCell(tableView: UITableView) -> Cell {
        let reuseIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = Cell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        return cell as! Cell
    }
    
    // 实例初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载UI
    fileprivate func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(pushBtn)
        contentView.addSubview(presentBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 15, y: 15, width: 200, height: 30)
        
        presentBtn.frame = CGRect(x: self.frame.size.width - 95, y: 15, width: 80, height: 30)
        
        pushBtn.frame = CGRect(x: self.frame.size.width - 190, y: 15, width: 80, height: 30)
    }
    
    @objc func pushBtnClick(_ btn: UIButton) {
        if let btnClickBlock = btnClickBlock {
            btnClickBlock(1, btn.indexPath)
        }
    }
    
    @objc func presentBtnClick(_ btn: UIButton) {
        if let btnClickBlock = btnClickBlock {
            btnClickBlock(2, btn.indexPath)
        }
    }
}

/**************************************************************************************************/
class Model: NSObject {
    var name: String = ""
    var subName: String = ""
}

class ListModel: NSObject {
    var title: String = ""
    var models: [Model] = []
    
    class func getListModels() -> [ListModel] {
        
        let list1 = ListModel()
        list1.title = "系统动画"
        var models1: [Model] = []
        for i in 0..<33 {
            let names = ["Fade",
                         "Push Right", "Push Left", "Push Bottom", "Push Top",
                         "Reveal Right", "Reveal Left", "Reveal Bottom", "Reveal Top",
                         "MoveIn Right", "MoveIn Left", "MoveIn Bottom", "MoveIn Top",
                         "Cube Right", "Cube Left", "Cube Bottom", "Cube Top",
                         "SuckEffact",
                         "OglFlip Right", "OglFlip Left", "OglFlip Bottom", "OglFlip Top",
                         "RippleEffect",
                         "PageCurl Right", "PageCurl Left", "PageCurl Bottom", "PageCurl Top",
                         "PageUnCurl Right", "PageUnCurl Left", "PageUnCurl Bottom", "PageUnCurl Top",
                         "CameraOpen",
                         "CameraClose"]
            let model = Model()
            model.name = names[i]
            models1.append(model)
        }
        list1.models = models1
        
        let list2 = ListModel()
        list2.title = "自定义动画"
        var models2: [Model] = []
        for i in 0..<32 {
            let names = ["Page Right", "Page Left", "Page Bottom", "Page Top",
                         "Cover",
                         "Spread Right", "Spread Left", "Spread Bottom", "Spread Top",
                         "Spread Point",
                         "Boom",
                         "Brick OpenV", "Brick OpenH", "Brick CloseV", "Brick CloseH",
                         "Inside",
                         "FragmentShow Right", "FragmentShow Left", "FragmentShow Bottom", "FragmentShow Top",
                         "FragmentHide Right", "FragmentHide Left", "FragmentHide Bottom", "FragmentHide Top",
                         "Flip Right", "Flip Left", "Flip Bottom", "Flip Top",
                         "Present Right", "Present Left", "Present Bottom", "Present Top"]
            let model = Model()
            model.name = names[i]
            models2.append(model)
        }
        list2.models = models2
        
        let list3 = ListModel()
        list3.title = "默认动画"
        var models3: [Model] = []
        for i in 0..<7 {
            let names = ["Push",
                         "Present Pop coverV",
                         "Present Pop flipH",
                         "Present Pop crossD",
                         "Present full coverV",
                         "Present full flipH",
                         "Present full crossD"]
            let model = Model()
            model.name = names[i]
            models3.append(model)
        }
        list3.models = models3
        
        return [list3, list1, list2]
    }
}

fileprivate var indexPathButtonKey: String = "indexPathKey"
extension UIButton {
    var indexPath: IndexPath {
        set {
             objc_setAssociatedObject(self, &indexPathButtonKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &indexPathButtonKey)) as? IndexPath ?? IndexPath(row: 0, section: 0)
        }
    }
}

// MARK: - 颜色扩展
public extension UIColor {
    
    // MARK: 1.1、根据 RGBA 设置颜色颜色
    /// 根据 RGBA 设置颜色颜色
    /// - Parameters:
    ///   - r: red 颜色值
    ///   - g: green颜色值
    ///   - b: blue颜色值
    ///   - alpha: 透明度
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        // 提示：在 extension 中给系统的类扩充构造函数，只能扩充：遍历构造函数
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // MARK: 1.2、十六进制字符串设置颜色
    /// 十六进制字符串设置颜色
    /// - Parameters:
    ///   - hex: 十六进制字符串
    ///   - alpha: 透明度
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        let color = Self.hexStringToColorRGB(hexString: hexString)
        guard let r = color.r, let g = color.g, let b = color.b else {
            #if DEBUG
            assert(false, "不是十六进制值")
            #endif
            return nil
        }
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    // MARK: 3.1、根据 十六进制字符串 颜色获取 RGB，如：#3CB371 或者 ##3CB371 -> 60,179,113
    /// 根据 十六进制字符串 颜色获取 RGB
    /// - Parameter hexString: 十六进制颜色的字符串，如：#3CB371 或者 ##3CB371 -> 60,179,113
    /// - Returns: 返回 RGB
    static func hexStringToColorRGB(hexString: String) -> (r: CGFloat?, g: CGFloat?, b: CGFloat?) {
        // 1、判断字符串的长度是否符合
        guard hexString.count >= 6 else {
            return (nil, nil, nil)
        }
        // 2、将字符串转成大写
        var tempHex = hexString.uppercased()
        // 检查字符串是否拥有特定前缀
        // hasPrefix(prefix: String)
        // 检查字符串是否拥有特定后缀。
        // hasSuffix(suffix: String)
        // 3、判断开头： 0x/#/##
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 2)..<tempHex.endIndex])
        }
        if tempHex.hasPrefix("#") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 1)..<tempHex.endIndex])
        }
        // 4、分别取出 RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        // 5、将十六进制转成 255 的数字
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        return (r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
}
