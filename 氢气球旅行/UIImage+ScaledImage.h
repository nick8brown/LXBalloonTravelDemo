//
//  UIImage+ScaledImage.h
//  氢气球旅行
//
//  Created by 曾令轩 on 16/1/8.
//  Copyright © 2016年 曾令轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaledImage)
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
