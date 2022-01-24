//
//  EMPageControl.swift
//  Example
//  自定义pageControl
//  Created by Illusion on 2018/6/16.
//  Copyright © 2017年 Illusion. All rights reserved.
//
import UIKit

class LLCustomPageControl: UIView {
    open var dotInActiveImage: UIImage = UIImage(named: "LLCycleScrollView.bundle/lldotInActive.png", in: Bundle(for: LLCycleScrollView.self), compatibleWith: nil)!
    open var dotActiveImage: UIImage = UIImage(named: "LLCycleScrollView.bundle/lldotActive.png", in: Bundle(for: LLCycleScrollView.self), compatibleWith: nil)!
    let pageControlDiameter: Int = 5
    let defaultColor: UIColor = UIColor.init(red: 10, green: 10, blue: 10, alpha: 1)
    let currentColor: UIColor = UIColor.white
    var currentPage: NSInteger = 0 {
        didSet {
            if oldValue == currentPage {
                return
            }
            
            if currentPage < oldValue {// 向右拉伸
                UIView.animate(withDuration: 0.3, animations: {
                    for dot in self.subviews {
                        var dotFrame = dot.frame
                        if dot.tag == self.currentPage {
                            dotFrame.size.width = CGFloat(self.pageControlDiameter * 2)
//                            dot.backgroundColor = self.currentColor
                            dot.frame = dotFrame
                            let imageV = dot as? UIImageView
                            imageV?.image = self.dotInActiveImage
                            
                        } else if dot.tag <= oldValue && dot.tag > self.currentPage {
                            dotFrame.origin.x += CGFloat(self.pageControlDiameter)
                            dotFrame.size.width = CGFloat(self.pageControlDiameter)
//                            dot.backgroundColor = self.defaultColor
                            dot.frame = dotFrame
//                            dot.layer.cornerRadius = dotFrame.size.width / 2
//                            dot.layer.masksToBounds = true
                            let imageV = dot as? UIImageView
                            imageV?.image = self.dotActiveImage
                        }
                    }
                })
                
            } else {// 向左拉伸
                UIView.animate(withDuration: 0.3, animations: {
                    for dot in self.subviews {
                        var dotFrame = dot.frame
                        if dot.tag == self.currentPage {
                            dotFrame.size.width = CGFloat(self.pageControlDiameter * 2)
                            dotFrame.origin.x -= CGFloat(self.pageControlDiameter)
//                            dot.backgroundColor = self.currentColor
                            dot.frame = dotFrame
                            let imageV = dot as? UIImageView
                            imageV?.image = self.dotInActiveImage
                            
                        } else if dot.tag > oldValue && dot.tag < self.currentPage {
                            dotFrame.origin.x -= CGFloat(self.pageControlDiameter)
                            dot.frame = dotFrame
                            
                        } else if dot.tag == oldValue {
                            dotFrame.size.width = CGFloat(self.pageControlDiameter)
//                            dot.backgroundColor = self.defaultColor
                            dot.frame = dotFrame
                            let imageV = dot as? UIImageView
                            imageV?.image = self.dotActiveImage
//                            dot.layer.cornerRadius = dotFrame.size.width / 2
//                            dot.layer.masksToBounds = true
                          
                        }
                    }
                })
                
            }
            
        }
    }
    var numberOfPages: NSInteger = 0 {
        didSet {
            if self.numberOfPages == 0 {
                return
            }
            if self.subviews.count > 0 {
                for view in self.subviews {
                    view.removeFromSuperview()
                }
            }

            var dotX: Int = 0;
            var dotW: Int = pageControlDiameter;
//            var bgColor: UIColor
            var image: UIImage
            for i in 0..<numberOfPages {
                if i <= currentPage {
                    dotX = pageControlDiameter * 2 * i
                } else {
                    dotX = pageControlDiameter * 2 * i + pageControlDiameter
                }
                
                if i == currentPage {
                    dotW = pageControlDiameter * 2;
//                    bgColor = currentColor
                    image = dotInActiveImage
                } else {
                    dotW = pageControlDiameter;
//                    bgColor = defaultColor
                    image = dotActiveImage
                }

                let tempImageV = UIImageView()
                tempImageV.frame = CGRect(x: dotX, y: 0, width: dotW, height: pageControlDiameter)
                tempImageV.image = image
                tempImageV.contentMode = .scaleAspectFit
//                let temp = UIView()
//                temp.frame = CGRect(x: dotX, y: 0, width: dotW, height: pageControlDiameter)
//                temp.layer.cornerRadius = CGFloat(pageControlDiameter / 2)
//                temp.layer.masksToBounds = true
//                temp.backgroundColor = bgColor
                tempImageV.tag = i
//                addSubview(temp)
                addSubview(tempImageV)
            }

        }
    }
    
}
