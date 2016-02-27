//
//  AlbumTableViewCell.m
//  SLComments
//
//  Created by 孙磊 on 16/2/27.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "AlbumTableViewCell.h"
#import "CommonHeader.h"

@implementation AlbumTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createContents];
    }
    return self;
}


-(void)createContents{

    self.dateLbl = [UILabel new];
    self.picsImgView = [UIImageView new];
    self.txtLbl = [UILabel new];
    self.numPicLbl = [UILabel new];
    
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.picsImgView];
    [self.contentView addSubview:self.txtLbl];
    [self.contentView addSubview:self.numPicLbl];
}

-(void)setModel:(AlbumModel *)model{
    _model = model;
    //
    
    
}

//先清除，避免复用的时候内容重复
-(void)removeAllSubviews{
    self.dateLbl.text = @"";
    self.picsImgView.image = nil;
    self.txtLbl.text = @"";
    self.numPicLbl.text = @"";
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self removeAllSubviews];
    
    self.dateLbl.frame = CGRectMake(5, 5, 50, 20);
    self.dateLbl.backgroundColor = [UIColor redColor];
    self.picsImgView.frame = CGRectMake(self.dateLbl.frame.origin.x + self.dateLbl.frame.size.width + 5, self.dateLbl.frame.origin.y, 60, 60);
    self.picsImgView.backgroundColor = [UIColor redColor];
    self.txtLbl.frame = CGRectMake(self.picsImgView.frame.origin.x + self.picsImgView.frame.size.width + 5, self.dateLbl.frame.origin.y, SCREEN_W - (self.dateLbl.frame.size.width + self.picsImgView.frame.size.width + 15 + 10), self.picsImgView.frame.size.height * 0.7);
    self.txtLbl.backgroundColor = [UIColor redColor];
    self.numPicLbl.frame = CGRectMake(self.txtLbl.frame.origin.x, self.txtLbl.frame.origin.y + self.txtLbl.frame.size.height + self.picsImgView.frame.size.height * 0.1, 20, self.picsImgView.frame.size.height * 0.2);
    self.numPicLbl.backgroundColor = [UIColor redColor];
    
}

@end
