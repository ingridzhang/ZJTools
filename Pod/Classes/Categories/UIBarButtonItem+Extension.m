
#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"

@implementation UIBarButtonItem (Extension)

- (instancetype)initWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton *btn = [[UIButton alloc] initWithImage:imageName backImage:nil title:nil];
    [btn sizeToFit];
    if (action) {
        [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];        
    }
    return [self initWithCustomView:btn];
}
@end
