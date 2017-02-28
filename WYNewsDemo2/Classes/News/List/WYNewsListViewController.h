//
//  WYNewsListViewController.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNewsListViewController : UIViewController


@property(nonatomic,assign,readonly) NSInteger channelIndex;

-(instancetype)initWithChannelID:(NSString *)docID channelIndex:(NSInteger)channelIndex;
@end
