//
//  UIImageView+WYWebImage.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (WYWebImage)

-(void)cz_loadWebImage:(NSString *)url;

@end
