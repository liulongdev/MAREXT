//
//  MARTestViewController.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2017/5/28.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "MARTestViewController.h"
#import <objc/runtime.h>
#import "MARCategory.h"
#import "MARClassInfo.h"
#import "MARTestExamples.h"

@interface MARTestViewController ()
@property (strong, nonatomic) IBOutlet UIButton *testBtn1;
@property (strong, nonatomic, getter=gethello)  NSString *testStrStr;
@end

@implementation MARTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *testStr = @"N";
    
    NSLog(@"1.%@ 2.%@", [testStr substringToIndex:1], [testStr substringFromIndex:1]);
    
    NSLog(@"ivars : %@ \npropertes : %@\nmehods:%@\nresponsechain:%@", [self.testBtn1 mar_instanceVariableList], [self.testBtn1 mar_propertiyInfoList], [self.testBtn1 mar_methodInfoList], [self.testBtn1 mar_responderChainDescription]);
    
    objc_property_t btn1Pro = class_getProperty(self.class, "testBtn1");
    const char * attrCstring = property_getAttributes(btn1Pro);
    
    NSArray *attrPairs = [[NSString stringWithUTF8String:attrCstring] componentsSeparatedByString:@","];
    NSMutableDictionary *_attrs = [[NSMutableDictionary alloc] initWithCapacity:[attrPairs count]];
    for(NSString *attrPair in attrPairs)
        [_attrs setObject:[attrPair substringFromIndex:1] forKey:[attrPair substringToIndex:1]];
    NSLog(@"cString : %s \nDic : %@", attrCstring, _attrs);

    [self.testBtn1 mar_addActionBlock:^(id sender) {
        [[MARTestExamples new] testRuntimeObj];
    } forState:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
