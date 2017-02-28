//
//  WYNetworkTool.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYNetworkTool.h"
#import <AFNetworking.h>
#import "WYNewsModel.h"

@implementation WYNetworkTool

static id _instance;
static AFHTTPSessionManager *_manager;

+(instancetype)sharedTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });
    
    return _instance;
}

-(instancetype)init{
    self = [super init];
    
    if(self){
        //http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html
        NSString *base = @"http://c.3g.163.com/nc/article/";
        NSURL *url = [NSURL URLWithString:base];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:config];
        
    }
    
    return self;
}


-(void)getDataWithUrl:(NSString *)urlString param:(NSDictionary *)param complete:(void(^)(id,NSError *))completeBlock{

    NSAssert(completeBlock != nil, @"block  不能为空");
    [_manager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completeBlock(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(nil,error);
    }];
}

-(void)getNewsListWithChannelID:(NSString *)channelID offSet:(NSInteger)offset compplete:(void(^)(NSArray* modelList,NSError *error))completeBlock{
    //http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html
    NSString *urlstring = [NSString stringWithFormat:@"list/%@/%zd-20.html",channelID,offset];
    [self getDataWithUrl:urlstring param:nil complete:^(id instance, NSError *error) {
        
        if(error){
            completeBlock(nil,error);
            return ;
        }
        
        NSArray *array = instance[channelID];
        
        NSArray *modelArr = [NSArray yy_modelArrayWithClass:[WYNewsModel class] json:array];
        completeBlock(modelArr,nil);
    }];
}
@end
