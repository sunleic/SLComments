//
//  SLCommentsView.m
//  SLComments
//
//  Created by 孙磊 on 16/2/22.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "SLCommentsView.h"
#import "CommonHeader.h"
#import "SLCommentsCell.h"

@implementation SLCommentsView{

    UITableView *_commentsTableView;
    NSMutableArray *_dataArray;  //数据源
    CGFloat _cellHeight;
}

-(void)createCommentsWithFrame:(CGRect)frame ToView:(UIView *)targetView dataSource:(NSMutableArray *)dataArr{

    if (!_commentsTableView) {
        _commentsTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _commentsTableView.delegate = self;
        _commentsTableView.dataSource = self;
    }
    _commentsTableView.tableHeaderView = [self createHeaderView];
    
    [targetView addSubview:_commentsTableView];
    
    if (dataArr) {
        _dataArray = dataArr; //设置数据源

    }else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.animationType = MBProgressHUDAnimationZoomIn;
        hud.labelText = @"加载失败！";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [MBProgressHUD hideHUDForView:targetView animated:YES];
        });
    }
}

-(UIView *)createHeaderView{
    //背景图高
    CGFloat headerView_H = 300;
    //背景图的高度
    CGFloat headerBG_H = 270;
    //头像宽高
    CGFloat headerBtn_W = 70;
    CGFloat headerBtn_H = 70;
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, headerView_H)];
    //headerView.backgroundColor = [UIColor purpleColor];
    //headerView.layer.contents = (__bridge id)[UIImage imageNamed:@"comments_header_bg"].CGImage;
    
    UIImageView *headerBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, headerBG_H)];
    headerBG.image = [UIImage imageNamed:@"comments_header_bg"];

    
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headerBtn.frame = CGRectMake(SCREEN_W - headerBtn_W - 10, headerView_H - headerBtn_H - 10, headerBtn_W, headerBtn_H);
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"sunlei.jpg"] forState:UIControlStateNormal];
    
    
    UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - headerBtn_W - 15 - 200 -10, headerBG.bounds.size.height - 20 - 5, 200, 20)];
    nameLbl.textColor = [UIColor whiteColor];
    nameLbl.textAlignment = NSTextAlignmentRight;
    nameLbl.font = [UIFont boldSystemFontOfSize:15];
    nameLbl.text = @"远方的枫叶";
    
    
    [headerView addSubview:headerBG];
    [headerView addSubview:nameLbl];
    [headerView addSubview:headerBtn];
    
    return headerView;
}

#pragma mark -UITableViewDelegate协议方法的实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *reuseID = @"commentsCell";
    SLCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (!cell) {
        cell = [[SLCommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    
    _cellHeight = [cell cellHeight];
    
    return cell;
}


+(SLCommentsView *)shareInstance{
    
    static SLCommentsView *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SLCommentsView alloc] init];
    });
    
    return sharedManager;
}

@end
