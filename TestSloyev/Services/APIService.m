//
//  APIService.m
//  TestSloyev
//
//  Created by Bodya on 21.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "APIService.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"

static NSString* apiURLString = @"http://51.255.193.76/test/register";

@interface APIService ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation APIService

+ (instancetype)shared {
    static APIService *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        [shared configurateSessionManager];
    });
    
    return shared;
}

- (void)configurateSessionManager {
    self.manager = [AFHTTPSessionManager manager];
    [self.manager.securityPolicy setValidatesDomainName:NO];
    [self.manager.securityPolicy setAllowInvalidCertificates:YES];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}



- (void)registrateUser:(User *)user complition:(void(^)(NSURLResponse *response, NSError *error))complition {
    NSDictionary *params = @{
                             @"email":user.email,
                             @"password":user.password,
                             @"firstname":user.firstname,
                             @"lastname":user.secondname,
                             @"gender":user.stringGender,
                             @"birthday":user.stringBirthday,
                             };
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(user.image)];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:apiURLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:data name:@"avatar"];
        [formData appendPartWithFileData:data name:@"files" fileName:@"avatar" mimeType:@"image/jpeg"];
        } error:nil];
    
    NSURLSessionUploadTask *task = [self.manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            NSLog(@"responseObject = %@", dict);
            NSLog(@"message = %@",[dict objectForKey:@"message"]);
            NSLog(@"Error = %@",error);
            NSLog(@"Response = %@",response);
        }
        complition ? complition(response, error) : nil;
    }];
    [task resume];
}

- (void)testRegistrate:(UIImage *)image {
    NSDictionary *params =@{
                            @"email":@"email@email.email",
                            @"password":@"Password1"
                            };
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image,1)];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"1run" ofType:@"jpg"];
    UIImage *ma = [UIImage imageWithContentsOfFile:bundlePath];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:apiURLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       // [formData appendPartWithFormData:data name:@"avatar"];
      //      [formData appendPartWithFileData:data name:@"file" fileName:@"name" mimeType:@"image/jpeg"];
        if(! [formData appendPartWithFileURL:[NSURL fileURLWithPath:bundlePath] name:@"avatar" fileName:[bundlePath lastPathComponent] mimeType:@"image/jpeg" error:nil]) {
            NSLog(@"32");
        };
    } error:nil];

    NSURLSessionUploadTask *task = [self.manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSDictionary *dict;
        if (responseObject) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            NSLog(@"responseObject = %@", dict);
            NSLog(@"message = %@",[dict objectForKey:@"message"]);
        }
        NSLog(@"RepresentObject = %@", responseObject);
        NSLog(@"Response = %@",response);
        NSLog(@"Error = %@",error);

    }];
    [task resume];
}


@end
