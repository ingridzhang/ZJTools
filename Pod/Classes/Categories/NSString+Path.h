
#import <Foundation/Foundation.h>

@interface NSString (Path)

- (NSString *)appendDocumentDir;
- (NSString *)appendCacheDir;
- (NSString *)appendTempDir;

- (void)hrefLink:(void(^)(NSString *link,NSString *text))completion;

- (NSString *)toCamelCase;
- (NSString *)splitOnCapital;

- (NSString *)kv_decodeHTMLCharacterEntities:(NSString *)originString;
- (NSString *)kv_encodeHTMLCharacterEntities:(NSString *)originString;

@end
