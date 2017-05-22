//
//  ViewController.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "ViewController.h"
#import "MARCategory.h"
#import "AppDelegate.h"
#import "NSData+MAREX_Type.h"
#import "MARTestExamples.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)clickTestBtnAction:(id)sender;
- (IBAction)clickTestBtn2Action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
{
    UIImage* chooseImage;
    MARTestExamples *testExamples;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    testExamples = [MARTestExamples new];
//    [self.btn1 mar_setSoundID:MARAudioIDNewMail forState:<#(UIControlEvents)#>]
}



- (void)testTextPath
{
    static NSInteger count = 0;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 200, 200);//设置shapeLayer的尺寸和位置
    shapeLayer.position = self.view.center;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = 1.0f;
    switch (count % 3) {
        case 0:
            shapeLayer.strokeColor = [UIColor redColor].CGColor;
            break;
        case 1:
            shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
            break;
        case 2:
            shapeLayer.strokeColor = [UIColor blackColor].CGColor;
            break;
    }
    
    //创建出圆形贝塞尔曲线  这个方法是根据一个矩形画内切曲线。通常用它来画圆或者椭圆
    
    
    //让贝塞尔曲线与CAShapeLayer产生联系  从贝塞尔曲线获取到形状
    NSString *testStr = @"让贝塞尔曲线";
    UIBezierPath *path = [UIBezierPath mar_bezierPathWithText:testStr font:[UIFont systemFontOfSize:40]];
    
    
    shapeLayer.path = path.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:shapeLayer];
    
    
    
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 100.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [shapeLayer addAnimation:pathAnimation forKey:nil];
    
    
    /*
     现在我们要用到CAShapeLayer的两个参数，strokeEnd和strokeStart
     Stroke:用笔画的意思
     在这里就是起始笔和结束笔的位置
     Stroke为1的话就是一整圈，0.5就是半圈，0.25就是1/4圈。以此类推
     
     */
    
    
    //  如果我们把起点设为0，终点设为1.0    设置stroke起始点
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
    // Do any additional setup after loading the view, typically from a nib.
    
    count ++;
}

- (IBAction)clickTestBtnAction:(id)sender {
    
//    UIImage * gradientImage = [UIImage mar_linearGradientImageWithSize:self.imageView.frame.size colors:@[[UIColor redColor], [UIColor greenColor]] startPoint:CGPointMake(0.0, 0.0) endPoint:CGPointMake(0.5, 1.0)];
    [self.imageView mar_setGradientWithColors:@[[UIColor redColor], [UIColor greenColor], [UIColor greenColor]] direction:MARUIViewLinearGradientDirectionVertical];
    return;
    UIImage *gradientImage = [UIImage mar_radialGradientimageWithSize:self.imageView.frame.size locations:@[@(0.0),@(0.2), @(1.0)] colors:@[[UIColor redColor],[UIColor blueColor], [UIColor greenColor]] startCenter:CGPointMake(0.2, 0.8) startRadius:0 endCenter:CGPointMake(0.2, 0.8) endRadius:500];
    
    self.imageView.image = gradientImage;
//    [self.imageView mar_setGradientWithColors:@[[UIColor redColor], [UIColor greenColor]] direction:MARUIViewLinearGradientDirectionVertical];
    return;
    
    UIImage* image = [(AppDelegate*)[UIApplication sharedApplication].delegate window].mar_touchImage;
    NSData *imageData = UIImagePNGRepresentation(image);
    if (imageData) {
        NSString *typeStr = [imageData mar_dataType];
        NSLog(@"typestr : %@", typeStr);
    }
    return;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    //    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

- (IBAction)clickTestBtn2Action:(id)sender {
    [testExamples testSoundIDS];
    return;
    static NSInteger count = 0;
    
    UIImage* tmpImage = [chooseImage copy];
//
//    switch (count % 8) {
//        case 0:
//            tmpImage = [tmpImage imageByRoundCornerRadius:15 corners:UIRectCornerTopLeft | UIRectCornerBottomRight borderWidth:2 borderColor:[UIColor purpleColor] borderLineJoin:kCGLineJoinMiter];
//            break;
//        case 1 :
//            tmpImage = [tmpImage imageByRoundCornerRadius:5 borderWidth:10 borderColor:[UIColor yellowColor]];
//            break;
//        case 2 :
//            tmpImage = [tmpImage imageByRoundCornerRadius:10 borderWidth:1 borderColor:[UIColor orangeColor]];
//            break;
//        case 3 :
//            tmpImage = [tmpImage imageByRotateLeft90];
//            break;
//        case 4:
//            tmpImage = [tmpImage imageByFlipHorizontal];
//            break;
//        case 5:
//            tmpImage = [tmpImage imageByRotate:0.5 fitSize:NO];
//            break;
//        case 6:
//            tmpImage = [tmpImage imageByRotate:0.5 fitSize:YES];
//            break;
//        case 7:
//            tmpImage = [tmpImage imageByResizeToSize:CGSizeMake(200, 200) contentMode:UIViewContentModeCenter];
//            break;
//        default:
//            break;
//    }
    
    self.imageView.image = tmpImage;
    [self.imageView mar_applyMotionEffects];
    [self.view mar_applyMotionEffects];
    return;
    switch (count % 6) {
        case 0:
            [self.imageView mar_shakeView];
            break;
        case 1 :
            [self.imageView mar_pulseViewWithDuration:5.0f];
            break;
        case 2 :
            [self.imageView mar_heartbeatViewWithDuration:5.0f];
            break;
        case 3 :
            [self.imageView mar_applyMotionEffects];
            break;
        case 4:
            [self.imageView mar_flipWithDuration:5.f direction:MARUIViewAnimationFlipDirectionFromTop];
            break;
        case 5:
            [self.imageView mar_translateAroundTheView:self.tipLabel duration:5.f direction:MARUIViewAnimationTranslationDirectionFromLeftToRight repeat:YES startFromEdge:YES];
            break;
        default:
            break;
    }
    
    count ++;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
    
    chooseImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.imageView.image = chooseImage;
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}


@end
