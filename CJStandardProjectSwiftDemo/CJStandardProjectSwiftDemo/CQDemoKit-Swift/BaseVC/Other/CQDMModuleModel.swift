//
//  CQDMModuleModel.swift
//  CJStandardProjectSwiftDemo
//
//  Created by ciyouzen on 2020/10/28.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation
import UIKit

class CQDMModuleModel: NSObject {
    var title: String!;
    var content: String?;
    var normalImage: UIImage?;
    var selectedImage: UIImage?;

    var indexPath: IndexPath?;   /**< 该模块所在的位置 */

    /// 以下三个方法只会执行一个，检查顺序依次为 actionBlock -> selector -> classEntry
    //①控制器
    var classEntry: UIViewController.Type?;     /**< 点击后进入的控制器 */
    var isCreateByXib: Bool?;   /**< 控制器是否要由interface来生成 */
    //②③事件
    var  selector: Selector?;           /**< 点击后执行的方法 */
    var actionBlock: (()->Void)?;     /**< 点击后执行的方法 void(^actionBlock)(void); */

    var userInfo: NSDictionary?;   /**< 该模块的其他信息 */
    var unReadNumber: NSInteger?;   /**< 未读消息数 */

}
