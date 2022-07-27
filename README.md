## iOS动画集

###动画效果
- brickOpenHorizontal  
![brickCloseH.gif](https://upload-images.jianshu.io/upload_images/28320442-08fb1c3cc3ea12a9.gif?imageMogr2/auto-orient/strip)
- pointSpread  
![page.gif](https://upload-images.jianshu.io/upload_images/28320442-74ca4d95e59a6e1f.gif?imageMogr2/auto-orient/strip)
- pageFromLeft  
![spreadPoint.gif](https://upload-images.jianshu.io/upload_images/28320442-2c7f2aa06d981ee1.gif?imageMogr2/auto-orient/strip)
- spreadFromLeft  
![spreadRight.gif](https://upload-images.jianshu.io/upload_images/28320442-ca25e8d6c1f8e565.gif?imageMogr2/auto-orient/strip)
- fragmentShowFromRight  
![fragmentRight.gif](https://upload-images.jianshu.io/upload_images/28320442-2afa463735a7eb1f.gif?imageMogr2/auto-orient/strip)

###动画类型
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
    
    // 弹出效果
    case presentFromRight
    case presentFromLeft
    case presentFromBottom
    case presentFromTop
}
```
