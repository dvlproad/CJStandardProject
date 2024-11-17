//
//  ViewController.swift
//  CQWidgetDemo
//
//  Created by qian on 2024/11/15.
//

import UIKit
import SwiftUI
import CQCommonViewFramework

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
        
        // 添加为子视图控制器
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // 设置约束
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
