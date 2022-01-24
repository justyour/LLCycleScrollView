//
//  EMPageControl.swift
//  Example
//  自定义pageControl
//  Created by Illusion on 2018/6/16.
//  Copyright © 2017年 Illusion. All rights reserved.
//
import UIKit

class LLCustomPageControl: UIView {
    let pageControlDiameter: Float = 5
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
                            dotFrame.size.width = CGFloat(self.pageControlDiameter * 2.0)
                            dot.backgroundColor = self.currentColor
                            dot.frame = dotFrame
                            
                        } else if dot.tag <= oldValue && dot.tag > self.currentPage {
                            dotFrame.origin.x += CGFloat(self.pageControlDiameter)
                            dotFrame.size.width = CGFloat(self.pageControlDiameter)
                            dot.backgroundColor = self.defaultColor
                            dot.frame = dotFrame
                            dot.layer.cornerRadius = dotFrame.size.width / 2
                        }
                    }
                })
                
            } else {// 向左拉伸
                UIView.animate(withDuration: 0.3, animations: {
                    for dot in self.subviews {
                        var dotFrame = dot.frame
                        if dot.tag == self.currentPage {
                            dotFrame.size.width = CGFloat(self.pageControlDiameter * 2.0)
                            dotFrame.origin.x -= CGFloat(self.pageControlDiameter)
                            dot.backgroundColor = self.currentColor
                            dot.frame = dotFrame
                            
                        } else if dot.tag > oldValue && dot.tag < self.currentPage {
                            dotFrame.origin.x -= CGFloat(self.pageControlDiameter)
                            dot.frame = dotFrame
                            
                        } else if dot.tag == oldValue {
                            dotFrame.size.width = CGFloat(self.pageControlDiameter)
                            dot.backgroundColor = self.defaultColor
                            dot.frame = dotFrame
                            dot.layer.cornerRadius = dotFrame.size.width / 2
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

            var dotX: Float = 0;
            var dotW: Float = pageControlDiameter;
            var bgColor: UIColor
            for i in 0..<numberOfPages {
                if i <= currentPage {
                    dotX = pageControlDiameter * 2.0 * Float(i)
                } else {
                    dotX = pageControlDiameter * 2 * Float(i) + pageControlDiameter
                }
                
                if i == currentPage {
                    dotW = pageControlDiameter * 2;
                    bgColor = currentColor
                } else {
                    dotW = pageControlDiameter;
                    bgColor = defaultColor
                }

                let temp = UIView()
                temp.frame = CGRect(x: CGFloat(dotX), y: CGFloat(0), width: CGFloat(dotW), height: CGFloat(pageControlDiameter))
                temp.layer.cornerRadius = CGFloat(pageControlDiameter * 0.5)
                temp.layer.masksToBounds = true
                temp.backgroundColor = bgColor
                temp.layer.cornerRadius = CGFloat(dotW / 2)
                temp.tag = i
                addSubview(temp)
            }

        }
    }
    
}
