//
//  WYChannelLabel.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYChannelLabel.h"


#define kBIG 18
#define kSMALL 15

@implementation WYChannelLabel

+(instancetype)labelWithName:(NSString *)name{
    WYChannelLabel *label = [[WYChannelLabel alloc] init];
    label.userInteractionEnabled = YES;
    label.text = name;
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:kBIG]];
    [label sizeToFit];
    [label setFont:[UIFont systemFontOfSize:kSMALL]];
    
    return label;
    
}


-(void)setScale:(CGFloat)scale{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    CGFloat offset = (kBIG *1.0 / kSMALL -1) * scale;
    self.transform = CGAffineTransformMakeScale(offset +1, offset +1);
}
@end
