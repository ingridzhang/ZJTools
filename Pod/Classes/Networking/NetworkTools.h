
#import "AFHTTPSessionManager.h"

@interface NetworkTools : AFHTTPSessionManager

@property (nonatomic,strong) NSString *redirectUri;

// 单例
+ (instancetype)sharedInstanceWithUrl:(NSString *)baseURLString;
// 封装AFN方法
- (void)requestMethod:(NSString *)method url:(NSString *)urlString params:(NSDictionary *)params completion:(void (^)(NSDictionary *result,NSError *error))completion;
// 封装AFN上传图片
- (void)uploadImage:(UIImage *)image url:(NSString *)urlString params:(NSDictionary *)params completion:(void (^)(NSDictionary *result,NSError *error))completion;

@end
