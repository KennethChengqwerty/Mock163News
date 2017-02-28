//
//  WYNewsModel.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYNewsModel : NSObject

@property(nonatomic,copy) NSString *docid;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) BOOL hasHead;
@property(nonatomic,copy) NSString *imgsrc;
@property(nonatomic,copy) NSString *digest;
@property(nonatomic,copy) NSNumber *replyCount;
@property(nonatomic,copy) NSString *source;

@property(nonatomic,assign) BOOL imgType;
@property(nonatomic,copy) NSArray *imgextra;
@end
