//
//  WYChannelModel.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYChannelModel : NSObject

@property(nonatomic,copy) NSString *tid;
@property(nonatomic,copy) NSString *tname;

+(NSArray<WYChannelModel *> *)channalList;
@end
