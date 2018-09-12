# CJDemoDemo
架构Demo

实现清晰，目的明确的层次划分，并能在后续快速接入使用组件化开发。


## 前言
架构是为了良好的处理需求。

而架构的理解，最后结合设想/实际需求理解。

#### 设想需求
先插入讲下业务逻辑常处理什么？
> 答：如根据登录的用户Type，进入不同的首页；


##### 1、某个操作可能在多个模块中都需要使用
> 
```
举例：登录操作在多个模块使用。
描述：从不同页面(游客模式时候)进入登录页，登录成功后回到首页
①、未进入首页时候，会提供登录方式来正式使用首页；
②、已进入首页但未登录(如游客模式)，在点击需要登录才使用的功能(如个人信息、订单等)，需要提供登录方式来使用该功能
```

希望至少达到的目的：
>
```
复用上的考虑
①、对网络请求和DB操作：可以复用
②、对逻辑处理：如根据登录的用户Type，进入不同的首页，这边暂不处理。
```


## 层划分
* 统一网络请求与数据库操作层；
> 网络请求与数据库操作的所在的层(安卓中的Model层)：LoginUserService/LoginUserManager

* 分离业务逻辑层，视图变化层；
> 业务逻辑层：LoginLogicControl
> 
> 视图变化层：LoginViewModel

* 独立网络基础层，数据库基础层；
> 网络基础层：NetworkClient
> 
> 数据库基础层：DatabaseClient

将网络基础层，和数据库基础层，归属到用户下。

解释：
> 不同的用户会有不同的网络基础库，比如司机端和乘客端都有自己的。
> 
> 改成以类目存放。如：`#import "CJDemoServiceUserManager+Network.h"`
> 
> 同理，数据库，不同用户会有不同数据库。还是说按数据库划分。

* UIViewController处理什么？
> ①处理视图生成，布局
> 
> ②配置视图变化层`LoginViewModel`
> 
> ③利用事件点击、delegate，调用业务逻辑层`LoginLogicControl`中的方法

#### 1、处理网络请求与数据库操作的所在的层
从组件化方向分析调整处理网络请求与数据库操作的所在的层，将其命名为Service层或Manager层，如ServiceUser。并通过类目为后续的其其他模块添加相应的+Login，+Mine等，其他类似。

①、处理的事情：
> 一个操作的网络请求和DB

②、命名：

取名发展史：

```
基类：CJDemoUserService(用户服务) --> CJDemoLoginUserService(登录用户的服务) --> CJDemoServiceUser(服务的用户)

针对用户服务延展出来的用户登录服务
类别时候的命名：+Login
继承时候的命名：CJDemoUserLoginService(用户服务) --> CJDemoLoginUserLoginService(登录用户的服务) --> CJDemoServiceUserLogin(服务的用户)
可见用继承，不仅在类上少，在命名上也更好。

用户的其他服务，以此类推。
```


> `CJDemoLoginUserService+Login.h`或者继承自`CJDemoLoginUserService`的`CJDemoLoginUserLoginService.h`。

③、最终暴露的接口举例：
> 
```
>
///登录
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void (^)(NSDictionary *responseDict))success
                 failure:(void (^)(NSError *error))failure;
```


④、理解：
> 你可以理解为这是一个它ViewModel中的Model(等同于安卓的Model，而非一个简单的实体类)，之后ViewModel或者DataControl、Service、Manager等调用本类中的方法即可。

⑤、归属及能否复用：
> 归属：在这里它不依赖任何UIViewControll，所以能很好的进行复用。
> 
> 复用：能复用。

⑥、举例：
> 登录操作会有请求以及请求结束后必须进行的DB操作，那么这边提供的登录接口会执行这两部分，而外界调用该接口和处理额外的回调即可。

#### 2、业务逻辑层
①、处理的事情：
> 业务逻辑层

②、命名：
> `LoginLogicControl.h`

③、最终暴露的接口举例：

 #import "LoginLogicControl.h"的接口内容
> 
```
///登录
@property (nonatomic, weak) id<LoginLogicControlDelegate> delegate;
>
>
/**
 *  登录(有主页登录、个人中心登录等,包含是否允许进行登录，登陆成功后进入什么页面等逻辑处理)
 *
 *  @param account          用户信息--用户名
 *  @param password         用户信息--用户密码
 */
- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password;
```

`LoginLogicControlDelegate`的接口内容
>
```
@protocol LoginLogicControlDelegate <NSObject>
>
- (void)goLoginViewControllerFromMain;
- (void)goLoginViewController;
>
@end
```

④、理解：
> 你可以理解为是将ViewModel中的业务逻辑抽离出来处理的DataControl或者Logic。
> 
> 回调内容：
> 
> LogicControl是处理业务逻辑的，所以显然业务逻辑处理完后是肯定会有回调的，这些回调经常需要涉及到对视图的某些处理，如常见的登录成功后进入对应的控制器，或者请求到数据后刷新视图控制器的视图，
> 
> 回调方式选择：
> 
> 那针对LogicControl的callback使用block还是delegate的问题，最后选择delegate的原因是使用比较法得出来的。首先我们明白逻辑处理结束的最后在归于是对逻辑处理结果的一个各种判断执行各种不同操作的，如根据登录的用户Type，进入不同的首页；如根据该登录视图是从哪进来的进入首页；所以在最后可能会有多种callback，如果使用block你为了不让该方法太常，你还是得写方法出来。那还不如直接放在LogicControl这一层处理掉。

⑤、归属及能否复用：
> 归属：归属于每个UIViewController，一个UIViewController可能有多个。
> 
> 复用：不能复用。


⑥、举例：
> 

#### 3、视图变化层

①、处理的事情：
> 视图变化层

②、命名：
> `LoginViewModel.h`，但在该类中它不使用RAC，且只处理视图变化

③、最终暴露的接口举例：
  #import "LoginViewModel.h"
> 
```
@property (nonatomic, copy) void (^loginButtonEnableChangeBlock)(BOOL loginButtonEnable);   /**< 监听登录按钮，是否可登录的状态的回调 */
>
- (void)userNameChangeEvent:(NSString *)userName;   /**< 用户名文本框开始改变 */
- (void)passwordChangeEvent:(NSString *)password;   /**< 密码文本框开始改变 */
```


④、理解：
> 可以理解为MVVM中的ViewModel，但此ViewModel只处理视图变化，且不是双向绑定。
> 如：文本框变化时候调用`-userNameChangeEvent:`，满足条件后执行`loginButtonEnableChangeBlock`

⑤、归属及能否复用：
> 归属：
> 
> 复用：不能复用。

⑥、举例：
> 常规登录界面



## 其他
#### 其他模式的参考文章
* [iOS 关于MVVM Without ReactiveCocoa设计模式的那些事](https://www.jianshu.com/p/db8400e1d40e)
* [iOS VIPER架构实践(二)：VIPER详解与实现](https://blog.csdn.net/zhanggenpin/article/details/79095682)


<p id="版本介绍/更新记录"></p>
## 版本介绍/更新记录
* 2018-09-05

> 对①网络请求与数据库操作的所在的层、②业务逻辑层进行处理
> 更新UserService为LoginUserService，而后又更为ServiceUser，使得更易了解。同时增加对user或者orderlist的处理。


## Author Or Contact
* [邮箱：studyroad@qq.com](studyroad@qq.com)
* [简书：https://www.jianshu.com/u/498d9e6a26e1](https://www.jianshu.com/u/498d9e6a26e1)
* [Github：https://github.com/dvlproad](https://github.com/dvlproad)


## 结束语
欢迎Stat、Follow、Fork、Pull Request！
