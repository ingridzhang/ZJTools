//
//  ZJRouter.h
//  Pods
//
//  Created by apple on 16/2/2.
//
//

#import <Foundation/Foundation.h>

@interface ZJRouter : NSObject

@property (nonatomic,copy) NSString *controllerPrefix;
@property (nonatomic,copy) NSString *controllerPostfix;
@property (nonatomic,strong) Class jumpController;
@property (nonatomic,strong) NSDictionary *routerParameters;

+ (instancetype)sharedInstance;

- (void)jump:(NSString *)url;
- (void)jump:(NSString *)url userInfo:(NSDictionary *)userInfo;

@end
