[SCLAlertView](https://github.com/vikmeup/SCLAlertView-Swift)使用

SCLAlertView是个好用的弹出框，使用于Swift。可以用来代替UIAllertView和UIAlertController

下面是我做的几个简单的演示[demo地址](https://github.com/MyColourfulLife/OneDayAThirdPartiOS/tree/master/SCLAlertViewUse)

![效果演示](https://raw.githubusercontent.com/wiki/MyColourfulLife/OneDayAThirdPartiOS/SCLAlertView.gif)

很多都是可以自定义的，使用起来也是非常方便。



### 安装

我使用pod安装

在Podfile文件中添加

```
pod 'SCLAlertView'
```

然后 

```
根据情况 pod install 或者 pod update
```

使用时

```
import SCLAlertView
```

在引入第三库后，首先要做的就是编译一下，看看能不能编译通过，有问题的话赶紧解决。

我的就有问题，一开始就跑不起了，不知道为什么。

报了一连串的错误

最后试了很多方法，不知道怎么解决的。可能的解决方案有：

更改pod内容为下面这样，指定源以获取最新版本。

```
pod 'SCLAlertView', :git => 'https://github.com/vikmeup/SCLAlertView-Swift.git'
```

在Build Phases 中 删除Pods_XXXX.framework 重新导入一遍，这一次我把SCLAlertView.framework也导入了。

最后就好了。



### 起步

简单使用可以弹出提示框

```swift
SCLAlertView().showInfo("Important info", subTitle: "You are great")
```

### 更新提示框内容

```Swift
let alertViewResponder: SCLAlertViewResponder = SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")

// Upon displaying, change/close view
alertViewResponder.setTitle("New Title") // Rename title
alertViewResponder.setSubTitle("New description") // Rename subtitle
alertViewResponder.close() // Close view
```

### 常用的弹框选项

```Swift
SCLAlertView().showError("Hello Error", subTitle: "This is a more descriptive error text.") // Error
SCLAlertView().showNotice("Hello Notice", subTitle: "This is a more descriptive notice text.") // Notice
SCLAlertView().showWarning("Hello Warning", subTitle: "This is a more descriptive warning text.") // Warning
SCLAlertView().showInfo("Hello Info", subTitle: "This is a more descriptive info text.") // Info
SCLAlertView().showEdit("Hello Edit", subTitle: "This is a more descriptive info text.") // Edit
```

### 调用showTitle

```Swift
let timeout = SCLAlertView.SCLTimeoutConfiguration(timeoutValue: 2.0, timeoutAction: {
   print("well done printed after two seconds")
})
SCLAlertView().showTitle("Congratulations", subTitle: "Operation successfully completed.", timeout: timeout, completeText: "Well Done", style: .success)
```

### 自定义外观

SCLAlertView.SCLAppearanc有超过15个属性可以设置

比如：

```Swift
let appearance = SCLAlertView.SCLAppearance(
    kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
    kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
    kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
    showCloseButton: false
)

let alert = SCLAlertView(appearance: appearance)
```

#### 添加按钮

可以使用target和selector也可使用闭包

```Swfit
let alertView = SCLAlertView()
alertView.addButton("First Button", target:self, selector:Selector("firstButton"))
alertView.addButton("Second Button") {
    print("Second button tapped")
}
alertView.showSuccess("Button View", subTitle: "This alert view has buttons")
```

#### 隐藏关闭按钮

```swift
let appearance = SCLAlertView.SCLAppearance(
    showCloseButton: false
)
let alertView = SCLAlertView(appearance: appearance)
alertView.showSuccess("No button", subTitle: "You will have hard times trying to close me")
```

#### 隐藏关闭按钮并且设置几秒后自动关闭

```swift
let appearance = SCLAlertView.SCLAppearance(
    showCloseButton: false
)
let alertView = SCLAlertView(appearance: appearance)
alertView.showWarning("No button", subTitle: "Just wait for 3 seconds and I will disappear", duration: 3)
```

#### 隐藏icon

```swift
let appearance = SCLAlertView.SCLAppearance(
    showCircularIcon: false
)
let alertView = SCLAlertView(appearance: appearance)
alertView.showSuccess("No icon", subTitle: "This is a clean alert without Icon!")
```

#### 使用自定义icon

```swift
let appearance = SCLAlertView.SCLAppearance(
    showCircularIcon: true
)
let alertView = SCLAlertView(appearance: appearance)
let alertViewIcon = UIImage(named: "IconImage") //Replace the IconImage text with the image name
alertView.showInfo("Custom icon", subTitle: "This is a nice alert with a custom icon you choose", circleIconImage: alertViewIcon)
```

#### 添加文本框

```swift
// Add a text field
let alert = SCLAlertView()
let txt = alert.addTextField(title:"Enter your name")
alert.addButton("Show Name") {
    println("Text value: \(txt.text)")
}
alert.showEdit("Edit View", subTitle: "This alert view shows a text box")
```

#### 使用自定义子视图替代子标题

```Swift
        // 创建显示配置
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont:UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont:UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont:UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton:false,
            dynamicAnimatorActive:true
        )
        
        // 使用自定义显示配置创建弹出框
        let alert = SCLAlertView(appearance: appearance)
        
        //创建子视图
        let subview = UIView(frame: CGRect(x: 0, y: 0, width: 216, height: 70))
        let x = (subview.frame.width - 180 ) / 2
        
        //添加一个输入框
        let textfield1 = UITextField(frame: CGRect(x: x, y: 10, width: 180, height: 25))
        textfield1.layer.borderColor = UIColor.green.cgColor
        textfield1.layer.borderWidth = 1.5
        textfield1.layer.cornerRadius = 5
        textfield1.placeholder = "Username"
        textfield1.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield1)
        
        //添加第二个输入框
        let textfield2 = UITextField(frame: CGRect(x: x, y: textfield1.frame.maxY + 10, width: 180, height: 25))
        textfield2.isSecureTextEntry = true
        textfield2.layer.borderColor = UIColor.green.cgColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.placeholder = "Password"
        textfield2.textAlignment = NSTextAlignment.center
        subview.addSubview(textfield2)
        
        //设置弹框的自定义视图属性
        alert.customSubview = subview
        
        _ = alert.addButton("Login", action: {
            print("Logged in")
        })
        
        //添加超时按钮
        let showTimeout = SCLButton.ShowTimeoutConfiguration(prefix:"(",suffix:"s)")
        _ = alert.addButton("Timeout Button", backgroundColor: UIColor.brown, textColor: UIColor.yellow, showTimeout: showTimeout) {
            print("Timeout button tapped")
        }
        
        let timeoutValue: TimeInterval = 10.0
        let timeoutAction: SCLAlertView.SCLTimeoutConfiguration.ActionType = {
            print("Timeout occurred")
        }
        
        //显示
        alert.showInfo("Login", subTitle: "", timeout: SCLAlertView.SCLTimeoutConfiguration(timeoutValue: timeoutValue, timeoutAction: timeoutAction))
```

#### 可以自定义的属性有

```Swift
// Button 
kButtonFont: UIFont                     
buttonCornerRadius : CGFloat            
showCloseButton: Bool                   
kButtonHeight: CGFloat                  

// Circle Image
showCircularIcon: Bool
kCircleTopPosition: CGFloat
kCircleBackgroundTopPosition: CGFloat
kCircleHeight: CGFloat
kCircleIconHeight: CGFloat

// Text
kTitleFont: UIFont
kTitleTop:CGFloat
kTitleHeight:CGFloat
kTextFont: UIFont
kTextHeight: CGFloat
kTextFieldHeight: CGFloat
kTextViewdHeight: CGFloat

// View 
kDefaultShadowOpacity: CGFloat          
kWindowWidth: CGFloat
kWindowHeight: CGFloat
shouldAutoDismiss: Bool // Set this false to 'Disable' Auto hideView when SCLButton is tapped
fieldCornerRadius : CGFloat
contentViewCornerRadius : CGFloat
disableTapGesture: Bool // set this to true if adding tableview to subView
```

### 弹框风格

```Swift
enum SCLAlertViewStyle: Int {
    case success, error, notice, warning, info, edit, wait, question
}
```

#### 弹框动画风格

```swift
// Animation Styles
public enum SCLAnimationStyle {
    case noAnimation, topToBottom, bottomToTop, leftToRight, rightToLeft
}
```



