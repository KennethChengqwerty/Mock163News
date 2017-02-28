//
//  WYChannelLabel.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYChannelLabel : UILabel

+(instancetype)labelWithName:(NSString *)name;

@property(nonatomic,assign) CGFloat scale;

@end
