//
//  Tools.h
//  SLComments
//
//  Created by 孙磊 on 16/2/25.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

//裁剪图片
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
//按比例改变图片大小
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

@end
