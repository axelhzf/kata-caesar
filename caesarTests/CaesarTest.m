#import "CaesarTest.h"
#import "Caesar.h"

@interface CaesarTest()

@property (strong, nonatomic) Caesar *caesar;

@end

@implementation CaesarTest

- (void)setUp {
    self.caesar = [[Caesar alloc] initWithShift:3];
}

- (void)assertEncryptText:(NSString *)original expected:(NSString *)expected {
    NSString *result = [self.caesar encrypt:original];
    STAssertEqualObjects(result, expected, nil);
}

- (void)assertDecryptText:(NSString *)original expected:(NSString *)expected {
    NSString *result = [self.caesar decrypt:original];
    STAssertEqualObjects(result, expected, nil);
}

- (void)testEncryptSimpleText {
    [self assertEncryptText:@"abc" expected:@"def"];
}

- (void)testDecryptSimpleText {
    [self assertDecryptText:@"def" expected:@"abc"];
}

- (void)testEncryptSimpleUpperCase {
    [self assertEncryptText:@"ABC" expected:@"DEF"];
}

- (void)testDecryptSimpleUpperCase {
    [self assertDecryptText:@"DEF" expected:@"ABC"];
}

- (void)testEncryptEndToBegin {
    [self assertEncryptText:@"xyz" expected:@"abc"];
}

- (void)testDecryptEndToBegin {
    [self assertDecryptText:@"abc" expected:@"xyz"];
}

- (void)testEncryptEndToBeginUpperCase {
    [self assertEncryptText:@"XYZ" expected:@"ABC"];
}

- (void)testDecryptEndToBeginUpperCase {
    [self assertDecryptText:@"ABC" expected:@"XYZ"];
}

- (void)testEncryptTextWithNotEncryptableChars {
    [self assertEncryptText:@"áéabcíóú" expected:@"áédefíóú"];
}

- (void)testDecryptTextWithNotEncryptableChars {
    [self assertDecryptText:@"áédefíóú" expected:@"áéabcíóú"];
}

@end