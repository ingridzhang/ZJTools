//
//  ZJHeader.h
//  Pods
//
//  Created by apple on 16/1/28.
//
//

#ifndef ZJHeader_h
#define ZJHeader_h

//字符串不为空
#define IS_NOT_EMPTY(string) (string !=nil && ![string isKindOfClass:[NSNull class]] && ![string isEqualToString:@""] && ![string isEqualToString:@"(null)"])

#define kDeviceWidth  ([[UIScreen mainScreen] bounds].size.width)
#define kDeviceHeight ([[UIScreen mainScreen] bounds].size.height)
#define kColorForTabBar(r, g, b)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]



#endif /* ZJHeader_h */
