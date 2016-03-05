
#import <UIKit/UIKit.h>

@interface UIButton (Extension)

- (instancetype)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
- (instancetype)initWithImage:(NSString *)imageName backImage:(NSString *)backImageName title:(NSString *)title;
- (void)setImage:(NSString *)imageName andBackImage:(NSString *)backImageName title:(NSString *)title;

@end
