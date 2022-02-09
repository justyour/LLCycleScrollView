//
//  LLCycleScrollViewCell.swift
//  LLCycleScrollView
//
//  Created by LvJianfeng on 2016/11/22.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

import UIKit

class LLCycleScrollViewCell: UICollectionViewCell {
    
    // 标题
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
            
            if title.count > 0 {
                titleBackView.isHidden = false
                titleLabel.isHidden = false
            }else{
                titleBackView.isHidden = true
                titleLabel.isHidden = true
            }
        }
    }
    
    // 标签内容
    var titleLabStr: String = ""{
        didSet{
            if titleLabStr.count > 0{
                
                titleTextLab.isHidden = false
                titleTextLab.text = titleLabStr
            }else{
                
                titleTextLab.isHidden = true
            }
        }
    }
    
    // 标题颜色
    var titleLabelTextColor: UIColor = UIColor.white {
        didSet {
            titleLabel.textColor = titleLabelTextColor
        }
    }
    
    // 标题字体
    var titleFont: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    // 文本行数
    var titleLines: NSInteger = 2 {
        didSet {
            titleLabel.numberOfLines = titleLines
        }
    }
    
    // 标题文本x轴间距
    var titleLabelLeading: CGFloat = 15 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    // 标题背景色
    var titleBackViewBackgroundColor: UIColor = UIColor.black.withAlphaComponent(0.3) {
        didSet {
            titleBackView.backgroundColor = titleBackViewBackgroundColor
        }
    }
    
    // 标签字体
    var titleTextLabFont: UIFont = UIFont.systemFont(ofSize: 11) {
        didSet {
            titleTextLab.font = titleTextLabFont
        }
    }
    
    // 标签字体颜色
    var titleTextLabTextColor: UIColor = UIColor.orange{
        didSet{
            titleTextLab.textColor = titleTextLabTextColor
        }
    }
    
    // 标签边框颜色
    var titleTextLabBoardColor: UIColor = UIColor.orange{
        didSet{
            titleTextLab.layer.borderColor = titleTextLabBoardColor.cgColor
        }
    }
    
    var titleBackView: UIView!
    
    // 标题Label高度
    var titleLabelHeight: CGFloat! = 56 {
        didSet {
            layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLabelBackView()
        setupTitleTextLabel()
        setupTitleLabel()
    }
    
    // 图片
    var imageView: UIImageView!
    fileprivate var titleLabel: UILabel!
    // 标签
    fileprivate var titleTextLab: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup ImageView
    fileprivate func setupImageView() {
        imageView = UIImageView.init()
        // 默认模式
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
    }
    
    // Setup Label BackView
    fileprivate func setupLabelBackView() {
        titleBackView = UIView.init()
        titleBackView.backgroundColor = titleBackViewBackgroundColor
        titleBackView.isHidden = true
        self.contentView.addSubview(titleBackView)
    }
    
    // Setup Title
    fileprivate func setupTitleLabel() {
        titleLabel = UILabel.init()
        titleLabel.isHidden = true
        titleLabel.textColor = titleLabelTextColor
        titleLabel.numberOfLines = titleLines
        titleLabel.font = titleFont
        titleLabel.backgroundColor = UIColor.clear
        titleBackView.addSubview(titleLabel)
    }
    
    // lab
    fileprivate func setupTitleTextLabel(){
        titleTextLab = UILabel.init()
        titleTextLab.isHidden = true
        titleTextLab.textColor = titleTextLabTextColor
        titleTextLab.numberOfLines = 0
        titleTextLab.font = titleTextLabFont
        titleTextLab.backgroundColor = UIColor.clear
        titleTextLab.textAlignment = .center
        titleBackView.addSubview(titleTextLab)
        
        titleTextLab.layer.borderColor = UIColor.orange.cgColor
        titleTextLab.layer.borderWidth = 1
        titleTextLab.layer.cornerRadius = 2
    }
    
    // MARK: layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds
        titleBackView.frame = CGRect.init(x: 0, y: self.ll_h - titleLabelHeight, width: self.ll_w, height: titleLabelHeight)
        let size = textHeightSizeWithFont(titleTextLabFont, height: 18, text: titleLabStr).width + (titleLabStr.count > 0 ? 8 : 0)
        titleTextLab.frame = CGRect(x: titleLabelLeading, y: (titleLabelHeight - 18) / 2, width: size, height: 18)
        titleLabel.frame = CGRect.init(x: titleTextLab.ll_x + titleTextLab.ll_w + (titleLabStr.count > 0 ? 8 : 0), y: 0, width: self.ll_w - (titleTextLab.ll_x + titleTextLab.ll_w + 8), height: titleLabelHeight)
    }
    
    private func textHeightSizeWithFont(_ font: UIFont, height:CGFloat,option : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin, text: String = "") -> CGSize {
        
        var textSize:CGSize!
        
        let size = CGSize(width: 10000, height: height)
        
        if size.equalTo(CGSize.zero) {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            textSize = text.size(withAttributes: attributes)
            
        } else {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            let stringRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
            
            textSize = stringRect.size
        }
        return textSize
    }
}
