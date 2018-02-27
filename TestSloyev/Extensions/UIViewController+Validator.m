//
//  UIViewController+Validator.m
//  TestSloyev
//
//  Created by Bodya on 24.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "UIViewController+Validator.h"
#import "Validator.h"

@implementation UIViewController (Validator)

- (BOOL)validateWithAlertEmail:(NSString *)email password:(NSString *)password {
    
    if (![Validator validateEmailString:email passwordString:password]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                                 message:@"Ввели не коректный Email или пароль (от 8 до 20 символов, латинские буквы, минимум одна цифра, минимум одна заглавная буква)"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}

@end
