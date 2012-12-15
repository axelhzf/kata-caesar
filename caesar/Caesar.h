#import <Foundation/Foundation.h>

@interface Caesar : NSObject

- (id)initWithShift:(int)shift;

- (NSString *)encrypt:(NSString *)text;

- (NSString *)decrypt:(NSString *)text;
@end