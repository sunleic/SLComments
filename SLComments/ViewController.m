//
//  ViewController.m
//  SLComments
//
//  Created by 孙磊 on 16/2/24.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "ViewController.h"
#import "Common/CommonHeader.h"
#import "SLCommentsView.h"
#import "SLCommentsModel.h"
#import "AlbumViewController.h"

@interface ViewController ()<SLCommentsViewDelegate>

@end

@implementation ViewController{

    NSMutableArray *_modelsArray;   //设置数据源
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"朋友圈";
    
    [self creatModelsWithCount:10];
}

//数据源
- (void)creatModelsWithCount:(NSInteger)count
{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"爱吃猫的老鼠",
                            @"会上树的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"我的性别你决定,我的名字你来猜"];
    
    NSArray *textArray = @[@"然而天才的道路，貌似总是曲折的，三年之前，这名声望达到巅峰的天才少年，却是突兀的接受到了有生以来最残酷的打击，不仅辛辛苦苦修炼十数载方才凝聚的斗之气旋，一夜之间，化为乌有，而且体内的斗之气，也是随着时间的流逝，变得诡异的越来越少。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然而天才的道路，貌似总是曲折的，三年之前，这名声望达到巅峰的天才少年，却是突兀的接受到了有生以来最残酷的打击，不仅辛辛苦苦修炼十数载方才凝聚的斗之气旋，一夜之间，化为乌有，而且体内的斗之气，也是随着时间的流逝，变得诡异的越来越少。",
                           @"在萧炎的心中，有一个仅有他自己知道的秘密：他并不是这个世界的人，或者说，萧炎的灵魂，并不属于这个世界，他来自一个名叫地球的蔚蓝星球，至于为什么会来到这里，这种离奇经过，他也无法解释，不过在生活了一段时间之后，他还是后知后觉的明白了过来：他穿越了！",
                           @"萧炎，斗之力，三段！级别：低级！”测验魔石碑之旁，一位中年男子，看了一眼碑上所显示出来的信息，语气漠然的将之公布了出来…"
                           ];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    
    NSArray *dateArray = @[ @"1小时前",
                            @"1天前",
                            @"两小时前",
                            @"10小时前"
                           ];
    
    
    NSArray *commentsTmpArray = @[
                                  @"@孙磊：你的性别我决定",
                                  @"@金鱼：会上树的猪",
                                  @"@李仪：逗死我了，哈哈哈",
                                  @"@浩浩：你妹的，是我的口头禅"
                                  ];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int dateRandomIndex = arc4random_uniform(4);
        
        SLCommentsModel *model = [SLCommentsModel new];
        model.headerIconStr = iconImageNamesArray[iconRandomIndex];
        model.nameStr = namesArray[nameRandomIndex];
        model.txtContentStr = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.imageArr = [temp copy];
        }
        
        //说说发表时间
        model.dateStr = dateArray[dateRandomIndex];
        
        //模拟“随机评论”
        int randomComment = arc4random_uniform(5);
        
        NSMutableArray *tempComment = [NSMutableArray new];
        for (int i = 0; i < randomComment; i++) {
            int randomIndex = arc4random_uniform(4);
            [tempComment addObject:commentsTmpArray[randomIndex]];
        }
        if (tempComment.count) {
            model.commentsArr = [tempComment copy];
        }else{
            model.commentsArr = nil;
        }
        
        [_modelsArray addObject:model];
    }
    
    [self createComments];
}


-(void)createComments{

    SLCommentsView *commentsView = [SLCommentsView shareInstance];
    commentsView.delegate = self;
    [commentsView createCommentsWithFrame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) ToView:self.view dataSource:_modelsArray];
}

#pragma mark -SLCommentsViewDelegate

-(void)headerBtnClick:(UIButton *)button{

    AlbumViewController *albumVC = [[AlbumViewController alloc]init];
    [self.navigationController pushViewController:albumVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
