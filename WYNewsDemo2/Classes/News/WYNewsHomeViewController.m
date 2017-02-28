//
//  WYNewsHomeViewController.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYNewsHomeViewController.h"
#import "WYChannelView.h"
#import "WYChannelModel.h"
#import "WYNewsListViewController.h"

@interface WYNewsHomeViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

//新闻分类的控件
@property(nonatomic,weak) WYChannelView *channelView;

@property(nonatomic,strong) NSArray<WYChannelModel *> *channelList;

//新闻主体的分页控件
@property(nonatomic,strong) UIPageViewController* newsPageVC;

//收到监听的滚动视图
@property(nonatomic,weak) UIScrollView *pageViewInnerScroll;

@property(nonatomic,weak) WYNewsListViewController *currentVC;

@property(nonatomic,weak) WYNewsListViewController *nextVC;

@end

@implementation WYNewsHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)labelClick:(WYChannelView *)view{
    NSInteger tag = view.currentLabelIndex;
    //跳转

    NSInteger scrollDirection = UIPageViewControllerNavigationDirectionForward;
    if(tag == _currentVC.channelIndex){
        return;
    }else if (tag < _currentVC.channelIndex){
        scrollDirection = UIPageViewControllerNavigationDirectionReverse;
    }
    
    //label的颜色
    [self.channelView changeLabelWithIndex:tag Scale:1];
    [self.channelView changeLabelWithIndex:_currentVC.channelIndex Scale:0];
    
    WYChannelModel *model = self.channelList[tag];
    
    WYNewsListViewController *newsListVC = [[WYNewsListViewController alloc] initWithChannelID:model.tid channelIndex:tag];
    [self.newsPageVC setViewControllers:@[newsListVC] direction:scrollDirection animated:YES completion:nil];
    
    _currentVC = newsListVC;
}

-(void)setupUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    WYChannelView *channelView = [WYChannelView channelView];
    self.channelView = channelView;
    [self.view addSubview:channelView];
    
    [self.channelView addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventValueChanged];
    
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(30);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        
    }];
    
    //显示数据
    self.channelList = [WYChannelModel channalList];
    [self.channelView setModelList:_channelList];
    
    
    self.newsPageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //第一个显示的vc
    WYNewsListViewController *newsVC = [[WYNewsListViewController alloc] initWithChannelID:@"T1348648517839" channelIndex:0];
    [self.newsPageVC setViewControllers:@[newsVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    self.newsPageVC.delegate = self;
    self.newsPageVC.dataSource = self;
    
    [self addChildViewController:self.newsPageVC];
    [self.view addSubview: self.newsPageVC.view];
    
    [self.newsPageVC didMoveToParentViewController:self];
    
    [self.newsPageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.channelView.mas_bottom);
    }];
    
    [self.channelView changeLabelWithIndex:0 Scale:1];
}

#pragma mark pageView Data
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(WYNewsListViewController *)viewController{
    NSInteger index = viewController.channelIndex;
    
    if(index == 0){
        return nil;
    }
    
    index--;
    
    WYChannelModel *model = self.channelList[index];
    
    WYNewsListViewController *priVC = [[WYNewsListViewController alloc] initWithChannelID:model.tid channelIndex:index];
    
    return priVC;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(WYNewsListViewController *)viewController{
    NSInteger index = viewController.channelIndex;
    
    if(index == self.channelList.count -1){
        return nil;
    }
    
    index++;
    
    WYChannelModel *model = self.channelList[index];
    
    WYNewsListViewController *nextVC = [[WYNewsListViewController alloc] initWithChannelID:model.tid channelIndex:index];
    
    return nextVC;
}

#pragma mark delegate 
//需要在开始和结束之间得到滚动变化的值 -KVO
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{

    
    //将要滚动的时候 pageViewController 包含当期的vc 只有一个，pendingViewControllers 包含下一个要显示的view  一个
    self.currentVC = pageViewController.viewControllers[0];
    self.nextVC = (WYNewsListViewController *)pendingViewControllers[0];

    UIView *view = pageViewController.view.subviews[0];
    if([view isKindOfClass:[UIScrollView class]]){
        _pageViewInnerScroll = (UIScrollView *)view;
        [view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

    [_pageViewInnerScroll removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([object isKindOfClass:[UIScrollView class]]){
        UIScrollView *sc = object;
        CGFloat x =  sc.contentOffset.x;
        //计算变化率
        CGFloat nextScale = ABS(x / self.newsPageVC.view.frame.size.width -1);
        CGFloat scale = 1-nextScale;
        
        //改变对应的2歌label，需要知道label在scroll中的位置 index，index的值与新闻列表的index相同
        NSInteger currentlabelIndex = self.currentVC.channelIndex;
        NSInteger nextLabelIndex = self.nextVC.channelIndex;
        
        [self.channelView changeLabelWithIndex:currentlabelIndex Scale:scale];
        [self.channelView changeLabelWithIndex:nextLabelIndex Scale:nextScale];
        
    }
}

@end
