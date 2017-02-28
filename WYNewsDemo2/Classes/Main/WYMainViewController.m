//
//  WYMainViewController.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYMainViewController.h"

@interface WYMainViewController ()

@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVC];
}

- (void)addChildVC {
    
//    WYNewsHomeViewController *news = [WYNewsHomeViewController new];
//    news.title = @"新闻";
//    news.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_icon_news_highlight"];
//    news.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal"];
    
    
    //使用字典
 //WYNewsListViewController  WYNewsHomeViewController
    
    NSArray *vcDicArray = @[@{@"vcName":@"WYNewsHomeViewController",
                                @"title":@"新闻",
                                @"image":@"news"
                                },@{
                                @"vcName":@"UIViewController",
                                @"title":@"直播",
                                @"image":@"media"
                                },@{
                                @"vcName":@"UIViewController",
                                @"title":@"阅读",
                                @"image":@"found"
                                },@{
                                @"vcName":@"UIViewController",
                                @"title":@"我",
                                @"image":@"me"
                                }];
    
    
    NSMutableArray *mArray = [NSMutableArray array];
    [vcDicArray enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [mArray addObject:[self generateViewControllerWithDic:obj]];
        
    }];
    
    self.viewControllers = mArray.copy;
    
}

-(UIViewController *)generateViewControllerWithDic:(NSDictionary *)dic{
    return [self generateViewControllerWithTitle:dic[@"title"] vcName:dic[@"vcName"] imageName:dic[@"image"]];
}

-(UIViewController *)generateViewControllerWithTitle:(NSString *)title vcName:(NSString *)vcName imageName:(NSString *)imageName{
    
    Class cls = NSClassFromString(vcName);
    NSAssert(cls != nil, @"不能创建出对应的类");
    
    UIViewController *vc = [cls new];
    vc.title = title;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_highlight",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_normal",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return navi;
    
}



@end
