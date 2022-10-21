//
//  XJTransitionInteractive.swift
//  XJTransition
//
//  Created by xj on 2022/10/21.
//

import UIKit

// MARK: - 自定义手势交互
class XJPercentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    /// 手势类型
    var gestureType: XJGestureType = .none
    
    /// 控制器操作方式
    var transitionType: XJTransitionType = .none
    
    /// 操作控制器，需使用弱引用
    weak var controller: UIViewController?
    
    var isInteractive: Bool = false
    
    /// 手势滑动进度
    var percent: CGFloat = 0
    
    let screenW: CGFloat = UIScreen.main.bounds.size.width
    let screenH: CGFloat = UIScreen.main.bounds.size.height
    
    /// 交互结束在XJTransitionManager执行一些操作
    var endInteractiveBlock: ((_ success: Bool) -> Void)?
    
    /// 定时器相关参数
    var remainDuration: CGFloat = 0
    var remaincount: CGFloat = 0
    var oncePercent: CGFloat = 0
    var toFinish: Bool = false
    
    /// 定时器
    var link: CADisplayLink?
    
    /// 单例对象
    static var shared = XJPercentDrivenInteractiveTransition()
    
    convenience init(type: XJGestureType) {
        self.init()
        
        self.gestureType = type
    }
    
    /// 为控制器添加交互手势
    /// - Parameters:
    ///   - controller: 交互控制器
    ///   - openEdgeGesture: 是否使用系统边缘手势 push才有效
    func addPanGesture(controller: UIViewController?, openEdgeGesture: Bool = false) {
        
        self.controller = controller
        
        /// 添加边缘手势
        if openEdgeGesture {
            let edgePanFromLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePan(_:)))
            edgePanFromLeft.edges = .left
            edgePanFromLeft.delegate = self
            controller?.view.addGestureRecognizer(edgePanFromLeft)
        }
        
        /// 添加手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        self.controller?.view.addGestureRecognizer(pan)
    }
    
    /// 处理边缘手势
    @objc func handleEdgePan(_ edgPan: UIScreenEdgePanGestureRecognizer) {
        self.panGesture(edgPan)
    }
}

// MARK: - Action
extension XJPercentDrivenInteractiveTransition {
    
    @objc func panGesture(_ pan: UIPanGestureRecognizer) {
        percent = 0
        
        let x = pan.translation(in: pan.view).x
        let y = pan.translation(in: pan.view).y
        
        switch self.gestureType {
        case .left:
            percent = -(x / screenW)
        case .right:
            percent = (x / screenW)
        case .down:
            percent = (y / screenH)
        case .up:
            percent = -(y / screenH)
        default: break
        }
        
        print("percent = \(percent)")
        
        switch pan.state {
        case .began:
            break
        case .changed:
            if !isInteractive {
                self.hiddenBeganTranslationX(x: x)
            } else {
                self.updateInteractiveTransition()
            }
            break
        case .ended,
             .cancelled:
            self.endInteractiveTransition()
            break
            
        default:
            break
        }
    }

    func hiddenBeganTranslationX(x: CGFloat) {
        print("hiddenBeganTranslationX")
        
        self.isInteractive = true
        
        if transitionType == .dismiss {
            self.controller?.dismiss(animated: true)
        } else if transitionType == .pop {
            self.controller?.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateInteractiveTransition() {
        percent = CGFloat(fminf(fmaxf(Float(percent), 0.03), 0.97))
        self.update(percent)
    }
    
    func endInteractiveTransition() {
        print("endInteractiveTransition")
        self.isInteractive = false
        
        startTimerAnimationWithFinishTransition(percent > 0.4)
    }
    
    func startTimerAnimationWithFinishTransition(_ finish: Bool) {
        print("startTimerAnimationWithFinishTransition--\(finish)")
        if finish && percent >= 1 {
            self.finish(); return
        } else if !finish && percent <= 0 {
            self.cancel(); return
        }
        
        toFinish = finish
        
        remainDuration = finish ? self.duration * (1 - percent) : self.duration * percent
        remaincount = 60 * remainDuration
        oncePercent = finish ? ((1 - percent) / remaincount) : (percent / remaincount)
        
        starDisplayLink()
    }
    
    /// 创建定时器
    func starDisplayLink() {
        self.link = CADisplayLink(target: self, selector: #selector(updateLink))
        self.link?.add(to: RunLoop.current, forMode: .common)
    }
    
    /// 销毁定时器
    func stopDisplayerLink() {
        if self.link != nil {
            self.link?.invalidate()
            self.link = nil
        }
    }
    
    /// 定时执行
    @objc func updateLink() {
        if percent > 0.97 && toFinish {
            self.stopDisplayerLink()
            self.finish()
        } else if percent <= 0.03 && !toFinish {
            self.stopDisplayerLink()
            self.cancel()
        } else {
            if toFinish {
                percent += oncePercent
            } else {
                percent -= oncePercent
            }
            let p = fminf(fmaxf(Float(percent), 0.03), 0.97)
            self.update(CGFloat(p))
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension XJPercentDrivenInteractiveTransition: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        return false
    }
}

