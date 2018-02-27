//
//  User.h
//  TestSloyev
//
//  Created by Bodya on 23.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSInteger minimalUserHeight = 70;
static NSInteger minimalUserWeight = 20;

typedef enum {
    noGender,
    male,
    female
}Gender;

@interface User : NSObject

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *firstname;
@property (nonatomic) NSString *secondname;
@property (nonatomic) Gender gender;
@property (nonatomic) NSDate *birthday;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger weight;
@property (nonatomic) UIImage *image;

@property (nonatomic, readonly) NSString *stringGender;
@property (nonatomic,readonly) NSString *stringBirthday;

+ (instancetype)createUserWithEmail:(NSString *)email password:(NSString *)password image:(UIImage *)image;
- (void)cashedImage;
- (void)getImage;
@end
