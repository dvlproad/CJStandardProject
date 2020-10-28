//
//  CJUIKitCollectionViewCell.swift
//  CJStandardProjectSwiftDemo
//
//  Created by ciyouzen on 2020/10/28.
//  Copyright © 2020 dvlproad. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CJUIKitCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel?;
    var detailTextLabel: UILabel?;
    var imageView: UIImageView?;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0).cgColor
        // #f2f2f2
        let parentView: UIView = self.contentView
        let imageView: UIImageView = UIImageView()
        parentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(parentView).offset(30);
            make.centerX.equalTo(parentView);
            make.top.equalTo(parentView).offset(10);
            make.height.equalTo(imageView.snp_width);
        }
        self.imageView = imageView
        let textLabel: UILabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 17)
        textLabel.minimumScaleFactor = 0.4
        textLabel.textColor = UIColor.black
        parentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(parentView).offset(10);
            make.right.equalTo(parentView).offset(-10);
            make.top.equalTo(imageView.snp_bottom).offset(10);
            make.height.equalTo(20);
        }
        self.textLabel = textLabel
    }
    
}


