# iOS动画集
动画类型
```
// MARK: - 动画类型
enum XJTransitionAnimationType: Int {
    
    case normal     // 默认
    
    // MARK: - 系统动画
    
    // 淡入淡出
    case fade
    
    // Push
    case pushFromRight
    case pushFromLeft
    case pushFromBottom
    case pushFromTop
    
    // 揭开
    case revealFromRight
    case revealFromLeft
    case revealFromBottom
    case revealFromTop
    
    // 覆盖
    case moveInFromRight
    case moveInFromLeft
    case moveInFromBottom
    case moveInFromTop
    
    // 立方体
    case cubeFromRight
    case cubeFromLeft
    case cubeFromBottom
    case cubeFromTop
    
    // 吮吸 无效
    case suckEffect
    
    // 翻转
    case oglFlipFromRight
    case oglFlipFromLeft
    case oglFlipFromBottom
    case oglFlipFromTop
    
    // 波纹 无效
    case rippleEffect
    
    // 翻页
    case pageCurlFromRight
    case pageCurlFromLeft
    case pageCurlFromBottom
    case pageCurlFromTop
    
    // 反翻页
    case pageUnCurlFromRight
    case pageUnCurlFromLeft
    case pageUnCurlFromBottom
    case pageUnCurlFromTop
    
    // 开镜头 无效
    case cameraIrisHollowOpen
    // 关镜头 无效
    case cameraIrisHollowClose
    
    // MARK: - 自定义动画
    
    // 翻页效果
    case pageFromRight
    case pageFromLeft
    case pageFromBottom
    case pageFromTop
    
    // 收缩
    case cover
    
    // 线扩散
    case spreadFromRight
    case spreadFromLeft
    case spreadFromBottom
    case spreadFromTop
    
    // 点扩散
    case pointSpread
    
    // 炸弹效果
    case boom
    
    // 窗帘效果
    case brickOpenVertical
    case brickOpenHorizontal
    case brickCloseVertical
    case brickCloseHorizontal
    
    // 下面收边
    case inside
    
    // 碎片效果
    case fragmentShowFromRight
    case fragmentShowFromLeft
    case fragmentShowFromBottom
    case fragmentShowFromTop

    // 碎片隐藏效果
    case fragmentHideFromRight
    case fragmentHideFromLeft
    case fragmentHideFromBottom
    case fragmentHideFromTop
    
    // 折叠效果
    case flipFromRight
    case flipFromLeft
    case flipFromBottom
    case flipFromTop
}
```
