
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EZDispatchCenter : NSObject

@property (nonatomic, strong) Class jumpController;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSString *module;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) NSString *url;

+ (instancetype)sharedInstance;
- (BOOL)jumpToViewController;

@end
