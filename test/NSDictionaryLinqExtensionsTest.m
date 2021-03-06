//
//  NSDictionaryLinqExtensionsTest.m
//  LinqToObjectiveC
//
//  Created by Colin Eberhardt on 26/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "NSDictionaryLinqExtensionsTest.h"
#import "NSDictionary+LinqExtensions.h"

@implementation NSDictionaryLinqExtensionsTest

- (void)testWhere
{
    NSDictionary* input = @{@"A" : @"Apple",
    @"B" : @"Banana",
    @"C" : @"Carrot",
    @"D" : @"Fish"};
    
    
    NSDictionary* result = [input where:^BOOL(id key, id value) {
        return [key isEqual:[value substringToIndex:1]];
    }];
    
    STAssertEquals(result.allKeys.count, 3U, nil);
    STAssertEqualObjects(result[@"A"], @"Apple", nil);
    STAssertEqualObjects(result[@"B"], @"Banana", nil);
    STAssertEqualObjects(result[@"C"], @"Carrot", nil);
}

- (void)testSelect
{
    NSDictionary* input = @{@"A" : @"Apple",
                    @"B" : @"Banana",
                    @"C" : @"Carrot",
                    @"D" : @"Fish"};
    
    
    NSDictionary* result = [input select:^id(id key, id value) {
        return [NSString stringWithFormat:@"%@, %@", key, [value substringToIndex:1]];
    }];
    
    STAssertEquals(result.allKeys.count, 4U, nil);
    STAssertEqualObjects(result[@"A"], @"A, A", nil);
    STAssertEqualObjects(result[@"B"], @"B, B", nil);
    STAssertEqualObjects(result[@"C"], @"C, C", nil);
    STAssertEqualObjects(result[@"D"], @"D, F", nil);
}

- (void)testToArray
{
    NSDictionary* input = @{@"A" : @"Apple",
    @"B" : @"Banana",
    @"C" : @"Carrot"};

    NSArray* result = [input toArray:^id(id key, id value) {
        return [NSString stringWithFormat:@"%@, %@", key, value];
    }];
    
    NSLog(@"%@", result);
    
    STAssertEquals(result.count, 3U, nil);
    STAssertEqualObjects(result[0], @"A, Apple", nil);
    STAssertEqualObjects(result[1], @"B, Banana", nil);
    STAssertEqualObjects(result[2], @"C, Carrot", nil);
}

- (void)testAll
{
    NSDictionary* input = @{@"a" : @"apple",
    @"b" : @"banana",
    @"c" : @"bat"};

    BOOL allValuesHaveTheLetterA = [input all:^BOOL(id key, id value) {
        return [value rangeOfString:@"a"].length != 0;
    }];
    STAssertTrue(allValuesHaveTheLetterA, nil);

    BOOL allValuesContainKey = [input all:^BOOL(id key, id value) {
        return [value rangeOfString:key].length != 0;
    }];
    STAssertFalse(allValuesContainKey, nil);
}

- (void)testAny
{
    NSDictionary* input = @{@"a" : @"apple",
    @"b" : @"banana",
    @"c" : @"bat"};

    BOOL anyValuesHaveTheLetterN = [input any:^BOOL(id key, id value) {
        return [value rangeOfString:@"n"].length != 0;
    }];
    STAssertTrue(anyValuesHaveTheLetterN, nil);
    
    BOOL anyKeysHaveTheLetterN = [input any:^BOOL(id key, id value) {
        return [key rangeOfString:@"n"].length != 0;
    }];
    STAssertFalse(anyKeysHaveTheLetterN, nil);
}


- (void)testCount
{
    NSDictionary* input = @{@"a" : @"apple",
    @"b" : @"banana",
    @"c" : @"bat"};


    NSUInteger valuesThatContainKey = [input count:^BOOL(id key, id value) {
        return [value rangeOfString:key].length != 0;
    }];
    STAssertEquals(valuesThatContainKey, 2U, nil);
}

- (void)testMerge
{
    NSDictionary* input = @{@"a" : @"apple",
    @"b" : @"banana",
    @"c" : @"bat"};
    
    NSDictionary* merge = @{@"d" : @"dog",
    @"b" : @"box",
    @"e" : @"egg"};
    
    
    NSDictionary* result = [input merge:merge];
    
    STAssertEquals(result.allKeys.count, 5U, nil);
    STAssertEqualObjects(result[@"a"], @"apple", nil);
    STAssertEqualObjects(result[@"b"], @"banana", nil);
    STAssertEqualObjects(result[@"c"], @"bat", nil);
    STAssertEqualObjects(result[@"d"], @"dog", nil);
    STAssertEqualObjects(result[@"e"], @"egg", nil);
}

@end
