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


@interface MARTestViewController ()
@property (strong, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation MARTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.testBtn1 mar_addActionBlock:^(id sender) {
        NSArray *array = @[@"MARTestClass1", @"MARTestClass2"];
        for (NSString *testClassName in array) {
            Class class = objc_allocateClassPair([NSObject class], [testClassName UTF8String], 0);
            
            const char *type = @encode(void *);
            NSUInteger size , alignment;
            NSGetSizeAndAlignment(type, &size, &alignment);
            if (class) {
                objc_property_attribute_t *cattrs = (objc_property_attribute_t*)calloc(2, sizeof(objc_property_attribute_t));
                cattrs[0].name = "T";
                cattrs[0].value = type;
                
                cattrs[0].name = "V";
                cattrs[0].value = "_testIvar";
                
//                BOOL addPropertyRet = class_addProperty(class, "_testIvar", cattrs, 2);
//                if (addPropertyRet) {
//                    NSLog(@"add ret suc");
//                    id instance = [[class alloc] init];
//                    Ivar ivar = class_getInstanceVariable(class, "_testIvar");
//                    object_setIvar(instance, ivar, @"Hello , Martin");
//                    NSString *testValue = object_getIvar(instance, ivar);
////                    [instance setValue:@"hello , martin" forKey:@"testIvar"];
//                    MARInfoLog(@"class : %@, value : %@", instance, testValue);
//                }
//
                BOOL addIvarRet = class_addIvar(class, [@"testIvar" UTF8String], size, log2(alignment), type);
                if (addIvarRet) {
                    NSLog(@"add ret suc");
                    id instance = [[class alloc] init];
                    Ivar ivar = class_getInstanceVariable(class, "testIvar");
                    object_setIvar(instance, ivar, @"Hello , Martin");
                    NSString *testValue = object_getIvar(instance, ivar);
                    MARInfoLog(@"class : %@, value : %@", instance, testValue);

                }
                
                SEL testFunSel = sel_registerName("testFun");
                
                id testFunBlock = ^(__unsafe_unretained id objSelf) {
//                    [objSelf ];
                    MARInfoLog(@"test fun fun ");
                    
                };
                
                IMP testFunIMP = imp_implementationWithBlock(testFunBlock);
                
                BOOL addMethodRet = class_addMethod(class, testFunSel, testFunIMP, "v@:");
                if (addMethodRet) {
                    
                }
            }
            
            MARInfoLog(@"create class %@ is %@", testClassName, class != nil ? @"success" : @"failure");
        }
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
