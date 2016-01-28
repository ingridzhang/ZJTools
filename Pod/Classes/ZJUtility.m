//
//  ZJUtility.m
//  Pods
//
//  Created by apple on 16/1/28.
//
//

#import "ZJUtility.h"
#import <objc/runtime.h>

static NSString * const AudioCacheFolderName = @"fanTingAudio";
static NSString * const AudioTempCacheFolderName = @"fanTingTemp";

@implementation ZJUtility

+ (void)clearAllApplicationCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        [[self class] clearAllItemAtFilePath:cachePath];
    });
}

+ (void) clearAllItemAtFilePath:(NSString *) path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* subDirectories = [fileManager contentsOfDirectoryAtPath:path error:nil];
    NSError* error = nil;
    for (NSString* item in subDirectories)
    {
        NSString* filePath = [path stringByAppendingPathComponent:item];
        if (![fileManager removeItemAtPath:filePath error:&error]) {
            NSLog(@"删除cache目录%@失败:%@",item, error);
        }
    }
}

+ (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

+ (NSString *)cacheKeyFromUrl:(NSURL *)url {
    NSString *key = [NSString stringWithFormat:@"%lx", (unsigned long)url.absoluteString.hash];
    return key;
}

+ (NSString *)cacheFolder:(NSString *)fileName {
    static NSString *cacheFolder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cacheDir = (NSString *)[[[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject] path];
        cacheFolder = [cacheDir stringByAppendingPathComponent:fileName];
        // ensure all cache directories are there (needed only once)
        NSError *error = nil;
        if(![[NSFileManager new] createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
#ifdef DDLogError
            DDLogError(@"Failed to create cache directory at %@", cacheFolder);
#else
            NSLog(@"Failed to create cache directory at %@", cacheFolder);
#endif
        }
    });
    return cacheFolder;
}

+ (NSArray *)getLocalFilePathWithAudioUrl:(NSString *)url type:(ZZAudioFileType)type{
    
    //    NSString *cacheKey = [[self class] cacheKeyFromUrl:url];
    if (url.length > 0) {
        NSString *fileName=[[url componentsSeparatedByString:@"/"] lastObject];
        NSString * localFileName;
        if (type == ZZAudioFileTpoType) {
            localFileName = [NSString stringWithFormat:@"ft_TPO_%@",fileName];
        }else if (type == ZZAudioFileOldType){
            localFileName = [NSString stringWithFormat:@"ft_old_%@",fileName];
        } else if (type == ZZAudioFileEPOType) {
            localFileName = [NSString stringWithFormat:@"ft_epo_%@",fileName];
        }
        NSString * localFilePath = [[[self class] cacheFolder:AudioCacheFolderName] stringByAppendingPathComponent:localFileName];
        
        NSArray * array = @[localFileName,localFilePath];
        return array;
    }
    return nil;
}

+ (NSString *)getLocalFilePathWithAudioUrl:(NSString *)url type:(ZZAudioFileType)type isTemp:(BOOL)isTemp{
    
    if (url.length > 0) {
        NSString *fileName=[[url componentsSeparatedByString:@"/"] lastObject];
        NSString * localFileName;
        if (type == ZZAudioFileTpoType) {
            localFileName = [NSString stringWithFormat:@"ft_TPO_%@",fileName];
        }else if (type == ZZAudioFileOldType) {
            localFileName = [NSString stringWithFormat:@"ft_old_%@",fileName];
        } else if (type == ZZAudioFileEPOType) {
            localFileName = [NSString stringWithFormat:@"ft_epo_%@",fileName];
        }
        NSString * localFilePath;
        if (isTemp) {
            
            localFilePath = [[[self class] cacheFolder:AudioTempCacheFolderName] stringByAppendingPathComponent:localFileName];
            return localFilePath;
        }
        
        localFilePath = [[[self class] cacheFolder:AudioCacheFolderName] stringByAppendingPathComponent:localFileName];
        
        return localFilePath;
    }
    return nil;
}

+ (BOOL )deleteFileWithPath:(NSString *)filePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL success = NO;
    if ([fileManager fileExistsAtPath:filePath]) {
        success = [fileManager removeItemAtPath:filePath error:nil];
    }
    return success;
}

//将时间戳转为00:00
+ (NSString *)changeTimeStingWithTimeInterval:(NSTimeInterval)time {
    
    NSInteger seconds = (NSInteger)time % 60;
    NSInteger minutes = ((NSInteger)time / 60) % 60;
    
    NSString * timeString = [NSString stringWithFormat:@"%02lu:%02lu", (long)minutes, (long)seconds];
    return timeString;
}

//判断当前网络是否可用
//+(BOOL) isConnectionAvailable{
//    
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostname:[NSString stringWithFormat:@"www.baidu.com"]];//kHttpAPIBaseUrl
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            //NSLog(@"notReachable");
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            //NSLog(@"WIFI");
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            //NSLog(@"3G");
//            break;
//    }
//    return isExistenceNetwork;
//}
//
//
////判断当前WiFi网络是否可用
//+(BOOL) isConnectionWiFiAvailable{
//    
//    Reachability *reach = [Reachability reachabilityWithHostname:[NSString stringWithFormat:@"www.baidu.com"]];//kHttpAPIBaseUrl
//    
//    if ([reach currentReachabilityStatus]==ReachableViaWiFi) {
//        
//        return YES;
//    }
//    return NO;
//}

+ (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType showView:(UIView *)showView{
    
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(showView.frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, showView.frame.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(showView.frame.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(showView.frame.size.width, showView.frame.size.height);
            break;
        case 3:
            start = CGPointMake(showView.frame.size.width, 0.0);
            end = CGPointMake(0.0, showView.frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (NSArray<NSString *> *)getAllPropertiesForClass:(NSString *)className {
    u_int count;
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(className), &count);
    NSMutableArray<NSString *> *propertiesArray = [NSMutableArray array];
    for (int i=0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        [propertiesArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(properties);
    return propertiesArray;
}

@end
