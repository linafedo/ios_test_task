//
//  CropEdgesImageProcessor.swift
//  test task
//
//  Created by Galina Fedorova on 09/05/2018.
//  Copyright © 2018 Galina Fedorova. All rights reserved.
//

import Foundation
import Kingfisher

public struct CropEdgesImageProcessor : ImageProcessor {
    
    public var identifier = "com.galina.fedorova.test-task.CropEdgesImageProcessor"
    private var xPoint:CGFloat
    private var yPoint:CGFloat
    
    init(xPoint:CGFloat,yPoint:CGFloat){
        self.xPoint = xPoint
        self.yPoint = yPoint
    }
    
    public func process(item: ImageProcessItem, options: KingfisherOptionsInfo) -> Image? {
        
        switch item {
        case .image(let image):
            
            let rect = CGRect(x: xPoint, y: yPoint, width: image.size.width-xPoint*2, height: image.size.height-yPoint*2)
            if let cropImage = image.cgImage?.cropping(to: rect) {
                return UIImage(cgImage: cropImage)
            }
            return nil
            
        case .data(_):
            return (DefaultImageProcessor.default >> self).process(item: item, options: options)
        }
    }
    
}

