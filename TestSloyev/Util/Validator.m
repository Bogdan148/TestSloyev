//
//  Validator.m
//  TestSloyev
//
//  Created by Bodya on 23.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+ (BOOL)validatePasswordString:(NSString *)string {
    if (string.length>=8 && string.length<=20) {
        NSString *pattern = @"^(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]*$";
        
        return [Validator validateString:string withPattern:pattern];
    } else {
        
        return NO;
    }
}

+ (BOOL)validateEmailString:(NSString *)string {
    NSString *pattern = @"^[.\\S]+[@][.\\S]+[\\.][A-Za-z]{2,}$";
    
    return [Validator validateString:string withPattern:pattern];
}

+ (BOOL)validateEmailString:(NSString *)string passwordString:(NSString *)password {
    
    return [Validator validateEmailString:string] & [Validator validatePasswordString:password];
}

+ (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAnchorsMatchLines error:nil];
    NSRange range = [regularExpression rangeOfFirstMatchInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
    
    return range.length ? YES : NO;
}

@end
