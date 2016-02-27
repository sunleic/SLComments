//
//  SLCommentsView.h
//  SLComments
//
//  Created by 孙磊 on 16/2/22.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLCommentsViewDelegate <NSObject>

-(void)headerBtnClick:(UIButton *)button;

@end

@interface SLCommentsView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, assign) id<SLCommentsViewDelegate> delegate;

+(SLCommentsView *)shareInstance;
-(void)createCommentsWithFrame:(CGRect)frame ToView:(UIView *)targetView dataSource:(NSMutableArray *)dataArr;

@end
