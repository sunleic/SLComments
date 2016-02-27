//
//  AlbumTableViewCell.h
//  SLComments
//
//  Created by 孙磊 on 16/2/27.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface AlbumTableViewCell : UITableViewCell

@property (nonatomic, strong) AlbumModel  *model;
@property (nonatomic, strong) UILabel     *dateLbl;
@property (nonatomic, strong) UIImageView *picsImgView;
@property (nonatomic, strong) UILabel     *txtLbl;
@property (nonatomic, strong) UILabel     *numPicLbl;

@end
