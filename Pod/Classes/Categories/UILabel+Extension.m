
#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (instancetype)initWithColor: (UIColor *)color fontSize: (CGFloat)fontSize {
    if (self = [super init]) {
        [self setTextColor:color];
        [self setFont:[UIFont systemFontOfSize:fontSize]];
    }
    return self;
}
@end
