//
//  CQDMSectionDataModel.swift
//  CJStandardProjectSwiftDemo
//
//  Created by 李超前 on 2020/10/28.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation

class CQDMSectionDataModel: NSObject {
    var type: NSInteger?;           /**< section的类型 */
    var theme: String!;             /**< section的名字 */
    var values: NSMutableArray!;    /**< section的数据 */

    var selected: Bool?;            /**< section是否选中(比较少用，常用比如打开section) */

}
