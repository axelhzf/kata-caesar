#import "Caesar.h"

@interface Caesar ()

@property int shift;

@end

@implementation Caesar

- (id)initWithShift:(int)shift {
    if (self = [super init]) {
        self.shift = shift;
    }
    return self;
}

- (void)shiftCharPtr:(char *)charPtr inRangeBegin:(char)begin end:(char)end shiftMultiplier:(NSInteger)multiplier {
    if(*charPtr >= begin && *charPtr <= end) {
        char rangeSize = end - begin + 1;
        *charPtr = ((*charPtr - begin + multiplier * self.shift) % (rangeSize) ) + begin;
        if(*charPtr < begin) {
            *charPtr = *charPtr + rangeSize;
        }
    }
}

- (NSString *)mapString:(NSString *)string charByChar:(void(^)(char *))iterator {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    char *dataPtr = (char *) [data bytes];

    for (int x = 0; x < [data length]; x++){
        iterator(dataPtr);
        *dataPtr++;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)encrypt:(NSString *)text {
    NSString *result = [self mapString:text charByChar:^(char *charPtr) {
        [self shiftCharPtr:charPtr inRangeBegin:'a' end:'z' shiftMultiplier:1] ;
        [self shiftCharPtr:charPtr inRangeBegin:'A' end:'Z' shiftMultiplier:1];
    }];
    return result;
}

- (NSString *)decrypt:(NSString *)text {
    NSString *result = [self mapString:text charByChar:^(char *charPtr) {
        [self shiftCharPtr:charPtr inRangeBegin:'a' end:'z' shiftMultiplier:-1];
        [self shiftCharPtr:charPtr inRangeBegin:'A' end:'Z' shiftMultiplier:-1];
    }];
    return result;
}

@end