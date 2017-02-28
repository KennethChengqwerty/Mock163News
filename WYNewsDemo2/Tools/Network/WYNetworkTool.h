//
//  WYNetworkTool.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYNetworkTool : NSObject

+(instancetype)sharedTool;

//http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html
-(void)getNewsListWithChannelID:(NSString *)channelID offSet:(NSInteger)offset compplete:(void(^)(NSArray* modelList,NSError *error))completeBlock;

@end
