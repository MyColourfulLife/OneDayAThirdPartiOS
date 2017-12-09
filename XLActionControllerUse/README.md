`XLActionController` 是一个支持各种自定义的底部选择框。

对于各种底部弹框非常好用，这个是我写的demo，二话不说先上图。

![XLActionController.gif](https://raw.githubusercontent.com/wiki/MyColourfulLife/OneDayAThirdPartiOS/XLActionController.gif)



### 第一步引入第三方库

我习惯使用pod引入

在Podfile中加入下面代码

```
platform :ios, '9.0'
use_frameworks!

target '<Your App Target>' do
  # This will install just the library's core, won't include any examples
  pod 'XLActionController'

  # Uncomment depending on the examples that you want to install
  #pod 'XLActionController/Periscope'
  #pod 'XLActionController/Skype'
  #pod 'XLActionController/Spotify'
  #pod 'XLActionController/Tweetbot'
  #pod 'XLActionController/Twitter'
  #pod 'XLActionController/Youtube'
end
```

如果只pod XLActionController则是引入了核心库，实例中的效果则需要自己实现，我自己跟着实现了一下，没问题是没问题，就是太费事了。使用第三方目的就是提高生产力，如果太麻烦还不如自己写。所以，强烈建议，引入上述其他包，或者根据效果引入。



因为我自己实现过一次，且命名中有一个ActionData.swift。自己实现和后续引入的第三方库会有冲突。会抱一个错，意思是不能把`Action<ActionData>`转换成`Action<ActionData>`是不是非常奇怪，明明是一个数据类型，为何还要转换，关键是转不了。后来才发现是自己写的和第三方的库的冲突了。因此最好我还是删了自己的实现。



所以直接使用第三方的就好了。

Podfile文件写好之后，根据需要使用下列命令，安装依赖库

```
pod install
or
pod update
```



### 使用

使用是先导入第三方库

```
import XLActionController
```



下面的示例展示了如何弹出一个Tweetbot类型的底部弹窗

```Swift
let actionController = TweetbotActionController()

actionController.addAction(Action("View Details", style: .default, handler: { action in
  // do something useful
}))
actionController.addAction(Action("View Retweets", style: .default, handler: { action in
  // do something useful
}))
actionController.addAction(Action("View in Favstar", style: .default, handler: { action in
  // do something useful
}))
actionController.addAction(Action("Translate", style: .default, executeImmediatelyOnTouch: true, handler: { action in
  // do something useful
}))

actionController.addSection(Section())
actionController.addAction(Action("Cancel", style: .cancel, handler:nil))

present(actionController, animated: true, completion: nil)
```

使用起来和UIAlertController非常像。

动作行为通常都是在弹框从屏幕消失才触发的，你可以改变这种触发模式，让它立刻触发。你需要构建动作时，把`executeImmediatelyOnTouch`参数设置为真。



#### 自定义ActionController

ActionController使用的是UICollectionView来展示动作和头部视图的 。动作展示是由UICollectionViewCell渲染得到的。

你可以在ActionController的声明里指定它来使用自己继续自UICollectionViewCell的子类。此外，ActionController允许你指定一个全局的头部和组视图。

`ActionController`这儿类是一个通用类型，在cell，头部，组头都可已使用。它关联任意类型。

XLActionController提供了扩展，来制定一个全新的外观和感觉，下面是自定义视图控制器的一个例子。

```swift
// As first step we should extend the ActionController generic type
public class PeriscopeActionController: ActionController<PeriscopeCell, String, PeriscopeHeader, String, UICollectionReusableView, Void> {

    // override init in order to customize behavior and animations
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // customizing behavior and present/dismiss animations
        settings.behavior.hideOnScrollDown = false
        settings.animation.scale = nil
        settings.animation.present.duration = 0.6
        settings.animation.dismiss.duration = 0.5
        settings.animation.dismiss.options = .curveEaseIn
        settings.animation.dismiss.offset = 30

        // providing a specific collection view cell which will be used to display each action, height parameter expects a block that returns the cell height for a particular action.
        cellSpec = .nibFile(nibName: "PeriscopeCell", bundle: Bundle(for: PeriscopeCell.self), height: { _ in 60})
        // providing a specific view that will render each section header.
        sectionHeaderSpec = .cellClass(height: { _ in 5 })
        // providing a specific view that will render the action sheet header. We calculate its height according the text that should be displayed.
        headerSpec = .cellClass(height: { [weak self] (headerData: String) in
            guard let me = self else { return 0 }
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: me.view.frame.width - 40, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.font = .systemFontOfSize(17.0)
            label.text = headerData
            label.sizeToFit()
            return label.frame.size.height + 20
        })

        // once we specify the views, we have to provide three blocks that will be used to set up these views.
        // block used to setup the header. Header view and the header are passed as block parameters
        onConfigureHeader = { [weak self] header, headerData in
            guard let me = self else { return }
            header.label.frame = CGRect(x: 0, y: 0, width: me.view.frame.size.width - 40, height: CGFloat.greatestFiniteMagnitude)
            header.label.text = headerData
            header.label.sizeToFit()
            header.label.center = CGPoint(x: header.frame.size.width  / 2, y: header.frame.size.height / 2)
        }
        // block used to setup the section header
        onConfigureSectionHeader = { sectionHeader, sectionHeaderData in
            sectionHeader.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        }
        // block used to setup the collection view cell
        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            cell.setup(action.data, detail: nil, image: nil)
            cell.separatorView?.isHidden = indexPath.item == self!.collectionView.numberOfItems(inSection: indexPath.section) - 1
            cell.alpha = action.enabled ? 1.0 : 0.5
            cell.actionTitleLabel?.textColor = action.style == .destructive ? UIColor(red: 210/255.0, green: 77/255.0, blue: 56/255.0, alpha: 1.0) : UIColor(red: 0.28, green: 0.64, blue: 0.76, alpha: 1.0)
        }
    }
}
```

ActionController的类型声明：

```swift
public class ActionController<ActionViewType: UICollectionViewCell, ActionDataType, HeaderViewType: UICollectionReusableView, HeaderDataType, SectionHeaderViewType: UICollectionReusableView, SectionHeaderDataType>
```

当继承ActionController时，我们必须指定这三种类型

`ActionViewType, HeaderViewType, SectionHeaderViewType`

就是用这些来渲染cell和头部视图及组视图。

每一个type都有与之相关的数据`ActionDataType, HeaderDataType, SectionHeaderDataType`

如果视图没有头部视图，可以使用`UICollectionReusableView`替代，使用`Void`来替代`HeaderDataType`



####  修改UICollectionView的行为、样式和动画设置

行为

```swift
// Indicates if the action controller must be dismissed when the user taps the background view. `true` by default.
settings.behavior.hideOnTap: Bool
// Indicates if the action controller must be dismissed when the user scrolls down the collection view. `true` by default.
settings.behavior.hideOnScrollDown: Bool
// Indicates if the collectionView's scroll is enabled. `false` by default.
settings.behavior.scrollEnabled: Bool
// Controls whether the collection view scroll bounces past the edge of content and back again. `false` by default.
settings.behavior.bounces: Bool
// Indicates if the collection view layout will use UIDynamics to animate its items. `false` by default.
settings.behavior.useDynamics: Bool
```

样式

```swift
// Margins between the collection view and the container view's margins. `0` by default
settings.collectionView.lateralMargin: CGFloat
// Cells height when UIDynamics is used to animate items. `50` by default.
settings.collectionView.cellHeightWhenDynamicsIsUsed: CGFloat
```



动画缩放

```swift
// Used to scale the presenting view controller when the action controller is being presented. If `nil` is set, then the presenting view controller won't be scaled. `(0.9, 0.9)` by default.
settings.animation.scale: CGSize? = CGSize(width: 0.9, height: 0.9)
```

出现动画设置

```swift
// damping value for the animation block. `1.0` by default.
settings.animation.present.damping: CGFloat
// delay for the animation block. `0.0` by default.
settings.animation.present.delay: TimeInterval
// Indicates the animation duration. `0.7` by default.
settings.animation.present.duration: TimeInterval
// Used as `springVelocity` for the animation block. `0.0` by default.
settings.animation.present.springVelocity: CGFloat
// Present animation options. `UIViewAnimationOptions.curveEaseOut` by default.
settings.animation.present.options: UIViewAnimationOptions
```

消失动画设置

```swift
// damping value for the animation block. `1.0` by default.
settings.animation.dismiss.damping: CGFloat
// Used as delay for the animation block. `0.0` by default.
settings.animation.dismiss.delay: TimeInterval
// animation duration. `0.7` by default.
settings.animation.dismiss.duration: TimeInterval
// springVelocity for the animation block. `0.0` by default
settings.animation.dismiss.springVelocity: CGFloat
// dismiss animation options. `UIViewAnimationOptions.curveEaseIn` by default
settings.animation.dismiss.options: UIViewAnimationOptions
```

状态栏样式

```swift
// Indicates if the status bar should be visible or hidden when the action controller is visible. Its default value is `true`
settings.statusBar.showStatusBar: Bool
// Determines the style of the device’s status bar when the action controller is visible. `UIStatusBarStyle.LightContent` by default.
settings.statusBar.style: UIStatusBarStyle
// Determines whether the action controller takes over control of status bar appearance from the presenting view controller. `true` by default.
settings.statusBar.modalPresentationCapturesStatusBarAppearance: Bool
```

取消视图 的样式

```swift
 // Indicates if the cancel view is shown. `false` by default.
settings.cancelView.showCancel: Bool
 // Cancel view's title. "Cancel" by default.
settings.cancelView.title: String?
 // Cancel view's height. `60` by default.
settings.cancelView.height: CGFloat
 // Cancel view's background color. `UIColor.black.withAlphaComponent(0.8)` by default.
settings.cancelView.backgroundColor: UIColor
// Indicates if the collection view is partially hidden by the cancelView when it is pulled down.
settings.cancelView.hideCollectionViewBehindCancelView: Bool
```

如果上面的动画设置还满足不了你，你可以重写下面的方法来改变出现和消失的动画

出现动画

```Swift
open func presentView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?)
```

上面的功能负责制作当前的动画。它将如何表现进行调用onwillpresentview，performcustompresentationanimation和ondidpresentview

因此我们通常不用重写上面的动画。而是重写上述三个钟的一个或两个就够了。

`onWillPresentView`在动画之前开始调用，这里的任何更改都不是动画的，这里是为了初始化一些动画的属性值。

`performCustomPresentationAnimation`执行动画主要走这个函数。

动画完成之后，presentView会调用`onDidPresentView`

同样的，消失动画，的重写

```swift
open func dismissView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?)
```

也通常是重写`onWillDismissView`, `performCustomDismissingAnimation` and `onDidDismissView`



目前使用时，有一个地方会崩溃，就是在使用TweetbotActionController时，会报错。
我想后续肯定会解决的。目前的临时解决办法请参考一下链接。
https://github.com/xmartlabs/XLActionController/issues/75



