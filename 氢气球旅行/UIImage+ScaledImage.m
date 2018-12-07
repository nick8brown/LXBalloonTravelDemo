//
//  UIImage+ScaledImage.m
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import "UIImage+ScaledImage.h"

@implementation UIImage (ScaledImage)

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
