# 让你不知道怎么死的RAC

### 前言：RAC学习起来的特点

- 学习起来比较难
- 团队开发的时候需要谨慎使用
- 团队代码需要不断的评审,保证团队中所有人代码的风格一致!避免阅读代码的困难



[TOC]


## 一、RAC双向绑定UITextField的正确姿势

#### 1、先说结果

```objective-c
    // textField1: 键盘修改textField有问题的例子
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);
    
    // textField2: 代码修改textField有问题的例子
    RACChannelTo(self.viewModel, text2) = self.textField2.rac_newTextChannel;
    
    // textField3: 键盘和代码修改textField都没问题的例子
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);
    [self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];
```



比较结果如下列表所示：

|                         | 未完整的双向绑定1                                            | 未完整的双向绑定2                                            | 完整的双向绑定                                               |
| ----------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 代码文本                | ![RACBindTextField1](./Screenshots/RAC/RACBindTextField1.png) | ![RACBindTextField2](./Screenshots/RAC/RACBindTextField2.png) | ![RACBindTextField3](./Screenshots/RAC/RACBindTextField3.png) |
| 代码截图                | ```// textField1: 键盘修改textField有问题的例子```<br/>```RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);``` | ```// textField2: 代码修改textField有问题的例子```<br/>```RACChannelTo(self.viewModel, text2) = self.textField2.rac_newTextChannel;``` | ```// textField3: 键盘和代码修改textField都没问题的例子```<br/>```RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);```<br/>```[self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];``` |
| textField               | textField1: 键盘修改textField有问题的例子                    | textField2: 代码修改textField有问题的例子                    | textField3: 键盘和代码修改textField都没问题的例子            |
| (通过代码)改变model时   | textField会改变                                              | textField会改变                                              | textField会改变                                              |
| 通过代码改变textField时 | model会改变                                                  | <u>model不会改变</u>                                         | model会改变                                                  |
| 通过键盘改变textField时 | <u>model不会改变</u>                                         | model会改变                                                  | model会改变                                                  |

#### 2、分析原因

要弄清为什么通过如上两种方式分别对textField1和textField2进行双向绑定会有问题，那么你需要先认识一下以下两个与textField有关的值的比较

|      |                                                              |                                                              |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
|      | ```RACChannelTo(self.textField, text)```                     | ```self.textField.rac_newTextChannel```                      |
| 原理 | 当通过code改变self.textField.text的值的时候,才会把RACChannelTo(self.textField, text)这个值发送出去 | 当通过键盘改变self.textField.text的值的时候,才会把self.textField.rac_newTextChannel这个值发送出去 |
| 后果 | 所以只使用这个时，键盘修改textField会有问题                  | 所以只使用这个时，代码修改textField会有问题                  |



如果你还存疑惑，那么我们拿`textField1: 键盘修改textField有问题的例子`来说明：

```objective-c
    // textField1: 键盘修改textField有问题的例子
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);
```

我们在`RACKVOProxy`中的`observeValueForKeyPath`处设置断点，会发现，当我们只设置如上代码时候，通过键盘改变textField的值的时，其并未走入所设断点中，即其此时并未能检测到文本框的文本已经改变了。所以，也就出现了只设置如上代码，会出现当通过键盘改变文本框(键盘未收起)的时候，viewModel中的值没法改变的情况。

> ![RACKVOProxy observeValueForKeyPath](./Screenshots/RAC/RACKVOProxy observeValueForKeyPath.png)

同理，另一个的验证也如此。



#### 3、解决问题

下面我们对`RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);`绑定方式进行键盘修改的完善，完善方式如下：

```objective-c
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);
    @weakify(self);
    [self.textField3.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.viewModel.text3 = x;
    }];
```

该部分代码，可简化为：

```objective-c
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);
    [self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];
```

即我们上诉开头时候的正确代码。



#### 4、实际应用中还存在的bindViewModel的问题

###### 4.1、在RAC绑定常见view中的textField的例子`RACBindNorTextFieldViewController`中

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC Bind Normal TextField", nil);
    [self setupViews];
    
    [self bindViewModel];
}
```



###### 4.2、在RAC绑定tableView中的textField的例子`RACBindTvTextFieldViewController`中

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RACTextFieldBindTableViewCell *cell = (RACTextFieldBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RACTextFieldBindTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    if (indexPath.row == 0) {
        self.textField1 = cell.textField;
    } else if (indexPath.row == 1) {
        self.textField2 = cell.textField;
    } else if (indexPath.row == 2) {
        self.textField3 = cell.textField;
    }
    return cell;
}
```

那么bindViewModel的时机比较容易出错

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC Bind TableView TextField", nil);
    
    [self setupViews];
    //[self bindViewModel]; //textField未获取，无法进行绑定
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self bindViewModel]; //textField未获取，无法进行绑定
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self bindViewModel];   //tableView中的textField绑定的正确时机
}
```



#### 5、遗留问题

遗留问题1：为什么只有键盘没回收时候的修改文本框值才有问题，而键盘回收时候不会也存在问题？





## 二、RAC监听的属性如何正确改变值(KVO的坑)

假设有如下需求，根据viewModel中的`@property (nonatomic, assign) BOOL textFieldValid;`值修改UIViewController中textField的自定义属性`leftButtonSelected`的值，怎么做？？？

答：`RAC(self.textField, leftButtonSelected) = RACObserve(viewModel, textFieldValid);`

问题是：**是不是只要实现了这行代码就没什么问题了？或者说在实现这行代码前，你有什么需要注意的？如果你不知道，你不搞清楚原因，那么有一天RAC让你怎么死的，你都不知道。**



#### 1、下面将常见的你修改属性时候使用的代码及其效果，列举如下：

| 修改属性时候使用的代码                                       | 代码位置           | 效果 |
| ------------------------------------------------------------ | ------------------ | ---- |
| `self.inTextFieldValid1 = inTextFieldValid1;`                | viewModel中        | 正确 |
| ~~_inTextFieldValid2 = inTextFieldValid2;~~                  | viewModel中        | 错误 |
| `[self setValue:@(inTextFieldValid3) forKey:@"inTextFieldValid3"];` | viewModel中        | 正确 |
| ~~[self setValue:@(inTextFieldValid4) forKey:@"_inTextFieldValid4"];~~ | viewModel中        | 错误 |
| `self.viewModel.outTextFieldValid1 = outTextFieldValid1;`    | UIViewController中 | 正确 |
| `[self.viewModel setValue:@(outTextFieldValid2) forKey:@"outTextFieldValid2"];` | UIViewController中 | 正确 |
| ~~[self.viewModel setValue:@(outTextFieldValid3) forKey:@"_outTextFieldValid3"];~~ | UIViewController中 | 错误 |

上面正确与否的判断标准是什么？

其实如果熟悉KVO机制的你，应该知道**KVO的本质是通过`isa-swizzling`新建了一个子类，并且重写了属性的`setter`方法，在`setter`方法的头和尾分别执行了`willChangeValueForKey:`和`didChangevlueForKey:`两个方法来实现监听的。**

所以，如果你修改属性时候使用的代码不会走setter方法，那么也就无法触发监听了。因而也就出现了你明明监听了属性，却无法正确运行的情况。

如上表格中的错误方法皆是不会走setter的。

下面是一张别人的图：

![img](./Screenshots/RAC/KVO机制.png)



#### 2、有无规避方法

问：*通过如上解析，我们知道问题的根源是没调用setter，那我们可否通过编译器提示不能使用`_xxx`来规避？？？*



在这里我们补充讲下`@synthesize`

|          | 写法1                          | 写法2                           |
| -------- | ------------------------------ | ------------------------------- |
| 源代码   | @synthesize student;           | @synthesize student = _student; |
| 等价代码 | @synthesize student = student; | ----同上----                    |

synthesize的作用就是让student = ？中的后者这个变量来“代替”属性，从而可以通过操作变量来进行属性的操作。但是有一点最关键的是，使用变量进行操作，属性本身的引用计数是不会增加的，因为没有经过调用setter方法或者是getter方法。但是如果使用self.student这种操作方式的话，实质上是通过setter或者是getter方法进行操作，引用计数会随着不同的操作而改变，了解了这点后就能够更好的避免内存泄露问题。



## 三、RAC监听数组的变化(KVO的坑)

iOS默认不支持KVO的形式来监听数组的变化，数组改变的时候，只是数组里面的值变化，但数组的地址没有变化，KVO监听的对象地址的变化。

由于不支持KVO来监听数组变化，就无法使用RAC来监听数组。

######  1、传统方式(我们不需要监听时候常使用的代码)：

```objective-c
	// 只是修改数组，无法触发监听
	if (self.flawArray.count) {
    	[self.flawArray removeLastObject];
    }
```

###### 2、需要使用监听时候的数组修改

```objective-c
    // 修改数组时候同时能确保触发KVO的操作
	if (self.okArray.count) {
        NSMutableArray *kvo_okArray = [self mutableArrayValueForKey:@"okArray"];
        [kvo_okArray removeLastObject];
    }
```



## 四、RAC中监听通知的坑

请查看：[RAC中监听通知的坑！](https://blog.csdn.net/qinqi376990311/article/details/79031581)



## 五、结束语

暂时到此！感谢查阅！