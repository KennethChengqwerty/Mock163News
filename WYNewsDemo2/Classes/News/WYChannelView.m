//
//  WYChannelView.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannelModel.h"
#import "WYChannelLabel.h"

@interface WYChannelView()
@property (weak, nonatomic) IBOutlet UIScrollView *channelScroll;


@end

@implementation WYChannelView

+(instancetype)channelView{
    //从nib加载
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] lastObject];
}

-(void)setModelList:(NSArray<WYChannelModel *> *)modelList{
    _modelList = modelList;
    
    
    CGFloat margin = 5;
   __block CGFloat x = margin;
    CGFloat y = 0;
   __block CGFloat width;
    CGFloat height = 30;
    
    [_modelList enumerateObjectsUsingBlock:^(WYChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WYChannelLabel *label = [WYChannelLabel labelWithName:obj.tname];
        [self.channelScroll addSubview:label];
        
        width = label.bounds.size.width;
        [label setFrame:CGRectMake(x, y, width, height)];
        x+=width +margin;
        label.tag = idx;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
        [label addGestureRecognizer:tap];
    }];
    
    [self.channelScroll setContentSize:CGSizeMake(x, height)];
}

-(void)labelTap:(UITapGestureRecognizer *)tap{
    WYChannelLabel *label = (WYChannelLabel *)tap.view;
    NSInteger tag= label.tag;
    _currentLabelIndex = tag;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)changeLabelWithIndex:(NSInteger)index Scale:(CGFloat)scale{
    UIView *view = self.channelScroll.subviews[index];
    if([view isKindOfClass:[WYChannelLabel class]]){
        WYChannelLabel *label = (WYChannelLabel *)view;
        [label setScale:scale];
    }
}
@end
