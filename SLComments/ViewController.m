//
//  ViewController.m
//  SLComments
//
//  Created by 孙磊 on 16/2/24.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import "ViewController.h"
#import "SLCommentsView.h"
#import "SLCommentsModel.h"

@interface ViewController ()

@end

@implementation ViewController{

    NSMutableArray *_modelsArray;   //设置数据源
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
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

    [[SLCommentsView shareInstance] createCommentsWithFrame:self.view.frame ToView:self.view dataSource:_modelsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
