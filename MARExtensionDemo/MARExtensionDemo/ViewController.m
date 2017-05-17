//
//  ViewController.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "ViewController.h"
#import "MARCategory.h"

@interface ViewController ()
- (IBAction)clickTestBtnAction:(id)sender;
- (IBAction)clickTestBtn2Action:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickTestBtnAction:(id)sender {
    NSString *tfValue = self.textField.text;
    NSString *base64Str = [tfValue mar_base64EncodedString];
    
    self.textField.text = base64Str;
    self.tipLabel.text = base64Str;
    
}

- (IBAction)clickTestBtn2Action:(id)sender {
    
    NSString *tfValue = self.textField.text;
    NSString *str = [NSString mar_stringWithBase64EncodedString:tfValue];
    
    self.textField.text = str;
    self.tipLabel.text = str;
    
}
@end
