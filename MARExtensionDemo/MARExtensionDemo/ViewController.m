//
//  ViewController.m
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/16.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import "ViewController.h"
#import "MARCategory.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)clickTestBtnAction:(id)sender;
- (IBAction)clickTestBtn2Action:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController
{
    UIImage* chooseImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickTestBtnAction:(id)sender {
    
    
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
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    
    
    //让贝塞尔曲线与CAShapeLayer产生联系  从贝塞尔曲线获取到形状
    NSString *testStr = @"Hello , Martin";
    UIBezierPath *path = [UIBezierPath bezierPathWithText:testStr font:[UIFont systemFontOfSize:40]];
    
    
    shapeLayer.path = path.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:shapeLayer];
    
    
    
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
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
    
    
//    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    bas.duration = 10;
////    bas.delegate = self.imageView;
//    bas.fromValue = [NSNumber numberWithInteger:0];
//    bas.toValue = [NSNumber numberWithInteger:1];
//    [arcLayer addAnimation:bas forKey:@"key"];
    
    return;
    UIGraphicsBeginImageContext(self.imageView.frame.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setStroke];
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.imageView.image = image;
    
    return;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    //    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    
    return;
    
    NSString *tfValue = self.textField.text;
    NSString *base64Str = [tfValue mar_base64EncodedString];
    
    self.textField.text = base64Str;
    self.tipLabel.text = base64Str;
    
}

- (IBAction)clickTestBtn2Action:(id)sender {
    
    static NSInteger count = 0;
    
    UIImage* tmpImage = [chooseImage copy];
    
    switch (count % 8) {
        case 0:
            tmpImage = [tmpImage imageByRoundCornerRadius:15 corners:UIRectCornerTopLeft | UIRectCornerBottomRight borderWidth:2 borderColor:[UIColor purpleColor] borderLineJoin:kCGLineJoinMiter];
            break;
        case 1 :
            tmpImage = [tmpImage imageByRoundCornerRadius:5 borderWidth:10 borderColor:[UIColor yellowColor]];
            break;
        case 2 :
            tmpImage = [tmpImage imageByRoundCornerRadius:10 borderWidth:1 borderColor:[UIColor orangeColor]];
            break;
        case 3 :
            tmpImage = [tmpImage imageByRotateLeft90];
            break;
        case 4:
            tmpImage = [tmpImage imageByFlipHorizontal];
            break;
        case 5:
            tmpImage = [tmpImage imageByRotate:0.5 fitSize:NO];
            break;
        case 6:
            tmpImage = [tmpImage imageByRotate:0.5 fitSize:YES];
            break;
        case 7:
            tmpImage = [tmpImage imageByResizeToSize:CGSizeMake(200, 200) contentMode:UIViewContentModeCenter];
            break;
        default:
            break;
    }
    self.imageView.image = tmpImage;
    
    
    count ++;
    return;
    
    NSString *tfValue = self.textField.text;
    NSString *str = [NSString mar_stringWithBase64EncodedString:tfValue];
    
    self.textField.text = str;
    self.tipLabel.text = str;
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
