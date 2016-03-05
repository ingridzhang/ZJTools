
#import <Foundation/Foundation.h>

@interface NSObject (AssociativeObject)

- (id)associativeObjectForKey: (NSString *)key;
- (void)removeAssociatedObjectForKey:(NSString *)key;
- (void)setAssociativeObject: (id)object forKey: (NSString *)key;

@end
