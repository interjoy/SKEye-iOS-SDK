//
//  NSArray+Log.m
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/4/2.
//  Copyright © 2017年 DC. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    return str;
}

@end
