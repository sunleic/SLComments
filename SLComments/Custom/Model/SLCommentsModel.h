//
//  SLCommentsModel.h
//  SLComments
//
//  Created by 孙磊 on 16/2/23.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLCommentsModel : NSObject

@property (nonatomic, copy)    NSString *headerIconStr;
@property (nonatomic, copy)    NSString *nameStr;
@property (nonatomic, copy)    NSString *txtContentStr;
@property (nonatomic, strong)  NSArray  *imageArr;
@property (nonatomic, strong)  NSArray  *commentsArr;
@property (nonatomic, copy)    NSString *dateStr;

@end
