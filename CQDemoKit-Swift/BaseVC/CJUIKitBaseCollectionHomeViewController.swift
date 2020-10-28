//
//  CJUIKitBaseCollectionHomeViewController.swift
//  CJStandardProjectSwiftDemo
//
//  Created by 李超前 on 2020/10/28.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CJUIKitBaseCollectionHomeViewController: CJUIKitBaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!;
    var sectionDataModels: NSMutableArray!;
    
    func automaticallyAdjustsScrollViewInsets() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.navigationItem.title = NSLocalizedString("XXX首页", comment: "")
        //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
        self.setupViews()
        let sectionDataModels: NSMutableArray = NSMutableArray()
        self.sectionDataModels = sectionDataModels
    }
    
    func setupViews() {
        let layout: UICollectionViewLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        /* 设置Register的Cell或Nib */
        // CJUIKitCollectionViewCell *registerCell = [[CJUIKitCollectionViewCell alloc] init];
        collectionView.register(CJUIKitCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        /* 设置DataSource */
        collectionView.dataSource = self
        /* 设置Delegate */
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        // [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //     make.edges.mas_equalTo(self.view);
        // }];
        self.collectionView = collectionView
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    // 此部分已在父类中实现
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionViewCellWidth: CGFloat = 0
        if false {
        } else {
            let cellWidthFromPerRowMaxShowCount: Int = 3
            let sectionInset: UIEdgeInsets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
            let minimumInteritemSpacing: CGFloat = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
            let width: CGFloat = collectionView.frame.width
            let validWith: CGFloat = width-sectionInset.left-sectionInset.right-minimumInteritemSpacing*CGFloat((cellWidthFromPerRowMaxShowCount-1))
            collectionViewCellWidth = validWith/CGFloat(cellWidthFromPerRowMaxShowCount)
//            collectionViewCellWidth = floorf(collectionViewCellWidth)
        
        }
        let collectionViewCellHeight: CGFloat = collectionViewCellWidth
        return CGSize(width:collectionViewCellWidth, height: collectionViewCellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    ////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionDataModel: CQDMSectionDataModel = self.sectionDataModels![indexPath.section] as! CQDMSectionDataModel
        let dataModels: NSMutableArray = sectionDataModel.values
        let moduleModel: CQDMModuleModel = dataModels[indexPath.row] as! CQDMModuleModel
        self.execModuleModel(moduleModel: moduleModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionDataModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionDataModel: CQDMSectionDataModel = self.sectionDataModels![section] as! CQDMSectionDataModel
        let dataModels: NSMutableArray = sectionDataModel.values
        return dataModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionDataModel: CQDMSectionDataModel = self.sectionDataModels![indexPath.section] as! CQDMSectionDataModel
        let dataModels: NSMutableArray = sectionDataModel.values
        let moduleModel: CQDMModuleModel = dataModels[indexPath.row] as! CQDMModuleModel
        let cell: CJUIKitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CJUIKitCollectionViewCell
        var image: UIImage = UIImage(named: "icon")!
        if (moduleModel.normalImage != nil) {
            image = moduleModel.normalImage!
        }
        cell.imageView?.image = image
        cell.textLabel?.text = moduleModel.title
        return cell
    }
    
    func execModuleModel(moduleModel: CQDMModuleModel) {
        if (moduleModel.actionBlock != nil) {
            moduleModel.actionBlock!()
            
        } else if (moduleModel.selector != nil) {
            self.performSelector(onMainThread: moduleModel.selector!, with: nil, waitUntilDone: false)
            
        } else {
            var viewController: UIViewController? = nil
            let classEntry: AnyClass = moduleModel.classEntry!
            let viewControllerClass: UIViewController.Type = classEntry as! UIViewController.Type
            
            let clsString: String = NSStringFromClass(moduleModel.classEntry!)
            if clsString.isEqual(NSStringFromClass(UIViewController.self)) {
                viewController = viewControllerClass.init()
                viewController!.view.backgroundColor = UIColor.white
            } else {
                if moduleModel.isCreateByXib! {
                    viewController = viewControllerClass.init(nibName: clsString, bundle: nil)
                } else {
                    viewController = viewControllerClass.init()
                    
                }
            }
            viewController!.title = NSLocalizedString(moduleModel.title, comment: moduleModel.title)
            viewController!.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

