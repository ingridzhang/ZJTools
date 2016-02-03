//
//  EZDispatchCenter.m
//  EZFramework_example
//
//  Created by sun on 15/10/12.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "EZDispatchCenter.h"
#import "MJExtension.h"

@implementation EZDispatchCenter

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (BOOL)jumpToViewController {

    id viewController = [[self.jumpController alloc] init];
    NSLog(@"jumpViewController -- %@",viewController);
    NSLog(@"self.parameters -- %@",self.parameters);
    NSLog(@"self.userInfo -- %@",self.userInfo);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = (UIViewController *)window.rootViewController;
    [vc presentViewController:viewController animated:YES completion:nil];
    return YES;
}

//- (NSString *)urlHost:(NSString *)urlHost {
//    NSString *url = self.url;
//    NSUInteger location = [self.url rangeOfString:@"?"].location;
//    if (location != NSNotFound) {
//        url = [self.url substringToIndex:location];
//    }
//    return url;
//}

@end
