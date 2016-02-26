//
//  SLCommentsCell.h
//  SLComments
//
//  Created by 孙磊 on 16/2/23.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCommentsModel.h"

@interface SLCommentsCell : UITableViewCell

@property (nonatomic, strong) SLCommentsModel *model;

@property (nonatomic, strong) UIImageView *headerIconImgView;
@property (nonatomic, strong) UILabel     *nameLbl;
@property (nonatomic, strong) UILabel     *txtContentLbl;
@property (nonatomic, strong) UIView      *imgContentView;
@property (nonatomic, strong) UILabel     *dateLbl;
@property (nonatomic, strong) UIButton    *zanBtn;
@property (nonatomic, strong) UIButton    *commentBtn;
@property (nonatomic, strong) UIView      *commentsView;
//返回次cell的高度
-(CGFloat)cellHeight;

@end
