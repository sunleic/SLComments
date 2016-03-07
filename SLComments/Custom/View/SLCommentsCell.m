//
//  SLCommentsCell.m
//  SLComments
//
//  Created by 孙磊 on 16/2/23.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "SLCommentsCell.h"
#import "CommonHeader.h"
#import "SDPhotoBrowser.h"

@interface SLCommentsCell ()<SDPhotoBrowserDelegate>

@end

@implementation SLCommentsCell{

    int numOfImg;  //图片说说部分，图片的个数
    float img_W;     //图片的宽高
    float img_H;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        img_H = 0;
        //先清除缓存
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        [self createContents];
    }
    return self;
}


-(void)createContents{

    self.headerIconImgView = [UIImageView new];
    self.nameLbl = [UILabel new];
    self.txtContentLbl = [UILabel new];
    self.imgContentView = [self imageContentView];
    self.dateLbl = [UILabel new];
    self.zanBtn = [UIButton new];
    self.commentBtn = [UIButton new];
    self.commentsView = [self commentsView];
    
    [self.contentView addSubview:self.headerIconImgView];
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.txtContentLbl];
    [self.contentView addSubview:self.imgContentView];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.zanBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.commentsView];
    
    
    //说说发表者头像
    self.headerIconImgView.frame = CGRectMake(5, 10, 40, 40);
    self.headerIconImgView.layer.cornerRadius = 20;
    self.headerIconImgView.layer.masksToBounds = YES;
    //说说发表者名字
    self.nameLbl.frame = CGRectMake(50, 12, SCREEN_W - 50 - 10, 20);
    self.nameLbl.font = [UIFont boldSystemFontOfSize:12];
    self.nameLbl.textColor = [UIColor colorWithRed:68/256.0 green:137/256.0 blue:178/256.0 alpha:1];
    //说说的文字部分
    self.txtContentLbl.frame = CGRectMake(50, 40, SCREEN_W - 50 - 10, 0);
    self.txtContentLbl.font = [UIFont systemFontOfSize:12];
    self.txtContentLbl.numberOfLines = 0;
    self.txtContentLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    //说说的图片部分
    //self.imgContentView.frame = CGRectMake(50, self.txtContentLbl.bounds.origin.y + self.txtContentLbl.bounds.size.height, SCREEN_W - 50 -10, 0);
    
    //时间
    self.dateLbl.font = [UIFont systemFontOfSize:10];
    
    //点赞
    [self.zanBtn setImage:[Tools scaleImage:[UIImage imageNamed:@"zan"] toScale:0.8] forState:UIControlStateNormal];
    self.zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.zanBtn setTitle:@"666" forState:UIControlStateNormal];
    [self.zanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.zanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.zanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

    [self.zanBtn addTarget:self action:@selector(zanBtn:) forControlEvents:UIControlEventTouchUpInside];
    //评论
    [self.commentBtn setImage:[Tools scaleImage:[UIImage imageNamed:@"comment"] toScale:0.6] forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.commentBtn setTitle:@"888" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

    [self.commentBtn addTarget:self action:@selector(commentBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)zanBtn:(UIButton *)button{
    NSLog(@"点赞");
}

-(void)commentBtn:(UIButton *)button{
    NSLog(@"评论");
}

-(UIView *)imageContentView{

    UIView *imgView = [[UIView alloc]initWithFrame:self.frame];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;

        [imgView addSubview:imageView];
    }
    
    return imgView;
}

//最多评论20条
-(UIView *)commentsView{

    UIView *commentsView = [[UIView alloc]initWithFrame:self.frame];
    
    for (int i = 0; i < 20; i++) {
        UILabel *commentLbl = [UILabel new];
        
        [commentsView addSubview:commentLbl];
    }
    return commentsView;
}


-(void)setModel:(SLCommentsModel *)model{
    //设置属性
    _model = model;
    
    //一下设置cell上添加的空间的属性
    self.headerIconImgView.image = [UIImage imageNamed:model.headerIconStr];
    self.nameLbl.text = model.nameStr;
    self.txtContentLbl.text = model.txtContentStr;
    
    //说说的文字部分
    CGRect txtContentLblRect = [self.txtContentLbl.text boundingRectWithSize:CGSizeMake(SCREEN_W - 50 - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.txtContentLbl.font} context:nil];
    self.txtContentLbl.frame = CGRectMake(50, 40, self.nameLbl.bounds.size.width, txtContentLblRect.size.height);
    
    //排版说说的图片部分
    [self layoutImgContentViewWithModel:model];
    self.imgContentView.frame = CGRectMake(50, self.txtContentLbl.frame.origin.y + self.txtContentLbl.frame.size.height + 5, self.imgContentView.bounds.size.width, [self heightForImgContentByCount:model.imageArr.count]);
    
    //时间label
    self.dateLbl.frame = CGRectMake(50, self.imgContentView.frame.origin.y + self.imgContentView.frame.size.height + 5, 100, 20);
    self.dateLbl.text = model.dateStr;
    
    //点赞按钮，评论按钮
    self.zanBtn.frame = CGRectMake(SCREEN_W - 152, self.dateLbl.frame.origin.y, 70, 20);
    self.commentBtn.frame = CGRectMake(SCREEN_W - 70, self.dateLbl.frame.origin.y, 60, 20);
    
    //评论
    self.commentsView.frame = CGRectMake(50, self.dateLbl.frame.origin.y + self.dateLbl.frame.size.height + 5, SCREEN_W - 50 -10, 20 * model.commentsArr.count);
}

#pragma mark -对图片墙布局
-(void)layoutImgContentViewWithModel:(SLCommentsModel *)model{

    //先遍历所有的的图片，并将其置空
    for (UIImageView *imgView in [self.imgContentView subviews]) {
        imgView.frame = CGRectMake(0, 0, 0, 0);
        self.imgContentView.frame = CGRectMake(50, self.txtContentLbl.bounds.origin.y + self.txtContentLbl.bounds.size.height, SCREEN_W - 50 -10, 0);
    }
    
    for (numOfImg = 0; numOfImg < model.imageArr.count; numOfImg++) {
        UIImageView *imageView = [[self.imgContentView subviews] objectAtIndex:numOfImg];
        //给带图的imageView添加单击手势
        imageView.tag = numOfImg;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[model.imageArr objectAtIndex:numOfImg]]];
        
//        NSData *picData = UIImageJPEGRepresentation(imgTmp, 0.3); //压缩图片质量
//        imageView.image = [UIImage imageWithData:picData];
//        
//        imageView.image = [Tools scaleToSize:imgTmp size:CGSizeMake(img_W, img_H* imgTmp.size.height/imgTmp.size.width)]; //切割图片质量
    }
    
    //布局
    int numOfLine = 0;
    int colu = 3;
    
    if (SCREEN_W == 320) {
        img_H = 80;
        img_W = 80;
    }else{
        img_H = 100;
        img_W = 100;
    }
    
    
    if ((model.imageArr.count <= 3) && (model.imageArr.count > 0)) {
        if (model.imageArr.count == 1) { //当只有一张图片时，按比例显示图片
            img_W = 120;
            img_H = 160;
            colu = 1;
        }
        numOfLine = 1;
        colu = (int)model.imageArr.count;
    }else if ((model.imageArr.count >3) && (model.imageArr.count <= 6)){
        if (model.imageArr.count == 4) {
            colu = 2;
        }
        numOfLine = 2;
    }else if(model.imageArr.count > 6){
        numOfLine = 3;
    }else{
        numOfLine = 0;
        img_H = 0;
        img_W = 0;
    }
    
    for (int i = 0; i < numOfLine; i++) {
        for (int j = 0; j < colu; j++) {
            UIImageView *imageView = (UIImageView *)[[self.imgContentView subviews] objectAtIndex:i * colu + j];
            imageView.frame = CGRectMake(j * (img_W + 3), i * (img_H + 3), img_W, img_H);
        }
    }
}

#pragma mark -创建图片浏览器
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.imgContentView;
    browser.imageCount = self.model.imageArr.count;
    browser.currentImageIndex = tap.view.tag;
    browser.delegate = self;
    [browser show];
}

#pragma mark -照片墙的高度
-(CGFloat)heightForImgContentByCount:(NSInteger)count{

    if (count == 0) {
        return 0;
    }else if ((count > 0) && (count <= 3)) {
        if (count == 1) {
            return img_H;
        }
        return img_H;
    }else if((count >3) && (count <= 6)){
        return img_H + img_H + 3;
    }else if(count > 6){
        return img_H + img_H + img_H + 3 + 3;
    }else{
        NSLog(@"图片个数为负数");
        return 1000000000; //个数为负数
    }
}

#pragma mark -返回次cell的高度
-(CGFloat)cellHeight{
    
    return self.dateLbl.frame.origin.y + self.dateLbl.bounds.size.height + 5;
}

#pragma mark - SDPhotoBrowserDelegate
//返回对应占位图的高质量图的URL
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.model.imageArr[index];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    
    NSString *strTmp = [[imageName componentsSeparatedByString:@"-"] objectAtIndex:0];

    NSURL *url = [NSURL URLWithString:[strTmp stringByAppendingString:@"-sl"]];
    
    return url;
}

//返回占位图
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.imgContentView.subviews[index];
    return imageView.image;
}

@end
