//
//  AlbumViewController.m
//  SLComments
//
//  Created by 孙磊 on 16/2/27.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "AlbumViewController.h"
#import "CommonHeader.h"
#import "AlbumTableViewCell.h"
#import "IssueViewController.h"

@interface AlbumViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AlbumViewController{

    UITableView *_albumTC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"相册";
    
    [self creatAlbumTC];
}

-(void)creatAlbumTC{
    if (!_albumTC) {
        _albumTC = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
        _albumTC.delegate = self;
        _albumTC.dataSource = self;
    }
    
    _albumTC.tableHeaderView = [self createHeaderView];
    
    [self.view addSubview:_albumTC];
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

#pragma mark - tableView相关代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"albumCell";
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AlbumTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (0 == indexPath.row) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photo:)];
        [cell.picsImgView addGestureRecognizer:tap];
        cell.dateLbl.text = @"今天";
        cell.picsImgView.image = [UIImage imageNamed:@"photo"];
        cell.txtLbl.text = @"";
        cell.numPicLbl.text = @"";
    }
    
    return cell;
}

-(void)photo:(UITapGestureRecognizer *)tap{

    IssueViewController *issueVC = [[IssueViewController alloc]init];
    
    [self presentViewController:issueVC animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.row) {
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
