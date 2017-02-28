//
//  WYChannelView.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannelModel;
@interface WYChannelView : UIControl

+(instancetype)channelView;

@property(nonatomic,strong) NSArray<WYChannelModel *>* modelList;

@property(nonatomic,assign,readonly) NSInteger currentLabelIndex;

- (void)changeLabelWithIndex:(NSInteger)index Scale:(CGFloat)scale;
@end
