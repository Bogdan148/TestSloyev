//
//  RegistrateViewController.m
//  TestSloyev
//
//  Created by Bodya on 21.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "RegistrateViewController.h"
#import "APIService.h"
#import "GradientButton.h"
#import "UIViewController+Validator.h"
#import "User.h"

@interface RegistrateViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondnameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *birthdayPickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *weightPickerView;

@property (weak, nonatomic) IBOutlet UIView *viewForExitButton;
@property (weak, nonatomic) IBOutlet GradientButton *registrationButton;

@property (nonatomic) NSString *path;
@property (nonatomic) APIService *apiService;

@end

@implementation RegistrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImageView)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:gesture];
    
    [self prepareForState:self.state];
    self.apiService = [APIService shared];
}

- (void)tapOnImageView {
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    pickerView.allowsEditing = YES;
    pickerView.delegate = self;
    [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerView animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
}

- (IBAction)exitButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registrateButtonAction:(id)sender {
    if ([self validateWithAlertEmail:self.emailTextField.text password:self.passwordTextField.text]) {
        User *user = [User createUserWithEmail:self.emailTextField.text
                                      password:self.passwordTextField.text
                                         image:self.imageView.image];
        user.firstname = self.nameTextField.text;
        user.secondname = self.secondnameTextField.text;
        user.gender = [self genderFromPickerView];
        user.birthday = [self dateFromPickerView];
        user.height = [self.heightPickerView selectedRowInComponent:0] + minimalUserHeight;
        user.weight = [self.weightPickerView selectedRowInComponent:0] + minimalUserWeight;
        
        [self.apiService registrateUser:user complition:nil];
       // [self.apiService testRegistrate:self.imageView.image];
    }
    
}

- (void)prepareForState:(ViewState)state {
    switch (state) {
        case profileState:
            self.registrationButton.hidden = YES;
            self.navigationItem.title = @"Регистрация";
            self.navigationItem.title = @"Профиль";
            self.navigationItem.hidesBackButton = YES;
            [self setupWithUser];
            break;
        case registrationState:
            self.viewForExitButton.hidden = YES;
            self.navigationItem.title = @"Регистрация";
            break;
        default:
            break;
    }
}

- (void)setupWithUser {
    self.emailTextField.text = self.user.email;
    self.passwordTextField.text = self.user.password;
    self.imageView.image = self.user.image;
    self.nameTextField.text = self.user.firstname;
    self.secondnameTextField.text = self.user.secondname;
    [self.genderPickerView selectRow:[self selectedRowFromGender:self.user.gender] inComponent:0 animated:NO];
    [self selectRowInBirthdayPicker:self.user.birthday];
    if (self.user.height) {
        [self.heightPickerView selectRow:self.user.height - minimalUserHeight
                             inComponent:0
                                animated:NO];
    }
    if (self.user.weight) {
        [self.weightPickerView selectRow:self.user.weight - minimalUserWeight
                             inComponent:0
                                animated:NO];
    }
}

- (void)selectRowInBirthdayPicker:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [self.birthdayPickerView selectRow:[self currentYear]-[components year] inComponent:0 animated:NO];
    [self.birthdayPickerView selectRow:[components month] inComponent:1 animated:NO];
    [self.birthdayPickerView selectRow:[components day] inComponent:2 animated:NO];

}

- (NSInteger)selectedRowFromGender:(Gender)gender {
    switch (self.user.gender) {
        case male: return 0;
            break;
        case female: return 1;
            break;
        default: return 0;
    }
    
}

- (Gender)genderFromPickerView {
    switch ([self.genderPickerView selectedRowInComponent:0]) {
        case 0: return male;
            break;
        case 1: return female;
            break;
        default: return noGender;
            break;
    }
}

- (NSDate *)dateFromPickerView {
    NSDateComponents *components = [NSDateComponents new];
    [components setDay:[self.birthdayPickerView selectedRowInComponent:2] + 1];
    [components setMonth:[self.birthdayPickerView selectedRowInComponent:1] + 1];
    [components setYear:[self currentYear] - [self.birthdayPickerView selectedRowInComponent:0]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSInteger)currentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return [components year];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([pickerView isEqual:self.birthdayPickerView]) {
        return 3;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.genderPickerView]) {
        return 2;
    }
    if ([pickerView isEqual:self.heightPickerView]) {
        return 230 - minimalUserHeight;
    }
    if ([pickerView isEqual:self.weightPickerView]) {
        return 100;
    }
    if ([pickerView isEqual:self.birthdayPickerView]) {
        if (component == 0) {
            return 120;
        }
        if (component == 1) {
            return 12;
        }
        if (component == 2) {
            return 31;
        }
    }
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    
    if ([pickerView isEqual:self.genderPickerView]) {
        label.text = @[@"Мужской",@"Женский"][row];
    }
    if ([pickerView isEqual:self.heightPickerView]) {
        label.text = [NSString stringWithFormat:@"%ld см",row + minimalUserHeight];
    }
    if ([pickerView isEqual:self.weightPickerView]) {
        label.text = [NSString stringWithFormat:@"%ld кг",row + minimalUserWeight];
    }
    if ([pickerView isEqual:self.birthdayPickerView]) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%ld",[self currentYear] - row];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%ld",row + 1];
        } else if (component == 2) {
            label.text = [NSString stringWithFormat:@"%ld",row + 1];
        }
    }
    
    return label;
}

@end
