//
//  ZJRouter.m
//  Pods
//
//  Created by apple on 16/2/2.
//
//

#import "ZJRouter.h"
#import "MGJRouter.h"
#import "NSString+Extension.h"
#import "EZDispatchCenter.h"

@implementation ZJRouter

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [MGJRouter registerURLPattern:@"app:///:module/:action" toHandler:^(NSDictionary *routerParameters) {
            EZDispatchCenter *dispatchCenter = [EZDispatchCenter sharedInstance];
            if ([routerParameters[@"action"] isKindOfClass:[NSString class]]) {
                NSString *viewConrollerName = [[routerParameters[@"module"] toCamelCase] stringByAppendingString:[routerParameters[@"action"] toCamelCase]];               
                dispatchCenter.jumpController = NSClassFromString([[@"EZJ" stringByAppendingString:viewConrollerName] stringByAppendingString:@"ViewController"]);
                dispatchCenter.module = routerParameters[@"module"];
                dispatchCenter.parameters = routerParameters;
                dispatchCenter.userInfo = routerParameters[MGJRouterParameterUserInfo];
                dispatchCenter.url = routerParameters[MGJRouterParameterURL];
                [dispatchCenter jumpToViewController];
            }
        }];
    });
    return instance;
}

- (void)jump:(NSString *)url {
    [self jump:url userInfo:nil];
}

- (void)jump:(NSString *)url userInfo:(NSDictionary *)userInfo {
    [MGJRouter openURL:url withUserInfo:userInfo completion:nil];
}

@end
