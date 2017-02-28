//
//  UIImageView+WYWebImage.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "UIImageView+WYWebImage.h"

@implementation UIImageView (WYWebImage)

-(void)cz_loadWebImage:(NSString *)url{
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
