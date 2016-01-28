//
//  ZJUtility.h
//  Pods
//
//  Created by apple on 16/1/28.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZZAudioFileType){
    
    ZZAudioFileTpoType,  //tpo
    ZZAudioFileOldType,   //old
    ZZAudioFileEPOType
};

typedef NS_ENUM(NSUInteger, GradientType)  {
    GradientTopToBottomType,       //从上到下
    GradientLeftToRightType,       //从左到右
    GradientUpleftTolowRightType,  //左上到右下
    GradientUprightTolowLeftType   //右上到左下
};

@interface ZJUtility : NSObject

+ (NSString *)userDirectoryForUser:(NSString *)userIdentifier;

+ (void)clearAllApplicationCache;

+ (NSDictionary *)optionsWithDefaultFont:(UIFont *)font defaultTextColor:(UIColor *)defaultTextColor;
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString options:(NSDictionary *)options;


//计算文件大小
+ (unsigned long long)fileSizeForPath:(NSString *)path;
+ (NSString *)cacheKeyFromUrl:(NSURL *)url;
//获得 cache 路径
+ (NSString *)cacheFolder:(NSString *)fileName;
+ (NSArray *)getLocalFilePathWithAudioUrl:(NSString *)url type:(ZZAudioFileType)type;
+ (NSString *)getLocalFilePathWithAudioUrl:(NSString *)url type:(ZZAudioFileType)type isTemp:(BOOL)isTemp;
+ (BOOL )deleteFileWithPath:(NSString *)filePath;

//将时间戳转为00:00
+ (NSString *)changeTimeStingWithTimeInterval:(NSTimeInterval)time;

////判断当前网络是否可用
//+(BOOL) isConnectionAvailable;
////判断当前WiFi网络是否可用
//+(BOOL) isConnectionWiFiAvailable;

+ (UIImage*) buttonImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType showView:(UIView *)showView;

// 得到一个对象的所有属性名称，以数组形式返回
+ (NSArray<NSString *> *)getAllPropertiesForClass:(NSString *)className;
@end
