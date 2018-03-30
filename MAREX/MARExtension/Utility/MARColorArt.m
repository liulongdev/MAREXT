//
//  MARColorArt.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/3/29.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "MARColorArt.h"
#import "UIColor+MAREX.h"
#import "UIImage+MAREX.h"

#define kAnalyzedBackgroundColor    @"kAnalyzedBackgroundColor"
#define kAnalyzedPrimaryColor       @"kAnalyzedPrimaryColor"
#define kAnalyzedSecondaryColor     @"kAnalyzedSecondaryColor"
#define kAnalyzedDetailColor        @"kAnalyzedDetailColor"

@interface MARCountedColor : NSObject

@property (assign) NSUInteger count;
@property (strong) UIColor *color;

- (id)initWithColor:(UIColor*)color count:(NSUInteger)count;

@end

@interface MARColorArt ()
@property(nonatomic, copy) UIImage *image;
@property(nonatomic,readwrite,strong) UIColor *backgroundColor;
@property(nonatomic,readwrite,strong) UIColor *primaryColor;
@property(nonatomic,readwrite,strong) UIColor *secondaryColor;
@property(nonatomic,readwrite,strong) UIColor *detailColor;
@property(nonatomic,readwrite) NSInteger randomColorThreshold;
@end

@implementation MARColorArt

- (id)initWithImage:(UIImage*)image
{
    self = [self initWithImage:image threshold:2];
    if (self) {
        
    }
    return self;
}

- (id)initWithImage:(UIImage*)image threshold:(NSInteger)threshold;
{
    self = [super init];
    
    if (self)
    {
        self.randomColorThreshold = threshold;
        self.image = image;
        [self _processImage];
    }
    
    return self;
}


+ (void)processImage:(UIImage *)image
        scaledToSize:(CGSize)scaleSize
           threshold:(NSInteger)threshold
          onComplete:(void (^)(MARColorArt *colorArt))completeBlock;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *scaledImage = [image mar_imageByResizeToSize:scaleSize];
        MARColorArt *colorArt = [[MARColorArt alloc] initWithImage:scaledImage
                                                       threshold:threshold];
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(colorArt);
        });
    });
    
}

- (void)_processImage
{
    //UIImage *finalImage = [self _scaleImage:self.image size:self.scaledSize];
    
    NSDictionary *colors = [self _analyzeImage:self.image];
    
    self.backgroundColor = [colors objectForKey:kAnalyzedBackgroundColor];
    self.primaryColor = [colors objectForKey:kAnalyzedPrimaryColor];
    self.secondaryColor = [colors objectForKey:kAnalyzedSecondaryColor];
    self.detailColor = [colors objectForKey:kAnalyzedDetailColor];
    
    //self.scaledImage = finalImage;
}

- (UIImage*)_scaleImage:(UIImage*)image size:(CGSize)scaledSize
{
    return [image mar_imageByResizeToSize:scaledSize];
    //    CGSize imageSize = [image size];
    //    UIImage *squareImage = [[UIImage alloc] initWithSize:CGSizeMake(imageSize.width, imageSize.width)];
    //    UIImage *scaledImage = [[UIImage alloc] initWithSize:scaledSize];
    //    CGRect drawRect;
    //
    //    // make the image square
    //    if ( imageSize.height > imageSize.width )
    //    {
    //        drawRect = CGRectMake(0, imageSize.height - imageSize.width, imageSize.width, imageSize.width);
    //    }
    //    else
    //    {
    //        drawRect = CGRectMake(0, 0, imageSize.height, imageSize.height);
    //    }
    //
    //  //  [squareImage lockFocus];
    //    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.width)];
    //  //  [squareImage unlockFocus];
    //
    //    // scale the image to the desired size
    //
    //  //  [scaledImage lockFocus];
    //    [squareImage drawInRect:CGRectMake(0, 0, scaledSize.width, scaledSize.height)];
    //  //  [scaledImage unlockFocus];
    //
    //    // convert back to readable bitmap data
    //
    //
    //    UIImage *finalImage = [[UIImage alloc] initWithCGImage:scaledImage.CGImage];
    //    return finalImage;
}

- (NSDictionary*)_analyzeImage:(UIImage*)anImage
{
    NSArray *imageColors = nil;
    UIColor *backgroundColor = [self _findEdgeColor:anImage imageColors:&imageColors];
    UIColor *primaryColor = nil;
    UIColor *secondaryColor = nil;
    UIColor *detailColor = nil;
    
    // If the random color threshold is too high and the image size too small,
    // we could miss detecting the background color and crash.
    if ( backgroundColor == nil )
    {
        backgroundColor = [UIColor whiteColor];
    }
    
    BOOL darkBackground = [backgroundColor mar_isDarkColor];
    
    [self _findTextColors:imageColors primaryColor:&primaryColor secondaryColor:&secondaryColor detailColor:&detailColor backgroundColor:backgroundColor];
    
    if ( primaryColor == nil )
    {
        NSLog(@"missed primary");
        if ( darkBackground )
            primaryColor = [UIColor whiteColor];
        else
            primaryColor = [UIColor blackColor];
    }
    
    if ( secondaryColor == nil )
    {
        NSLog(@"missed secondary");
        if ( darkBackground )
            secondaryColor = [UIColor whiteColor];
        else
            secondaryColor = [UIColor blackColor];
    }
    
    if ( detailColor == nil )
    {
        NSLog(@"missed detail");
        if ( darkBackground )
            detailColor = [UIColor whiteColor];
        else
            detailColor = [UIColor blackColor];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dict setObject:backgroundColor forKey:kAnalyzedBackgroundColor];
    [dict setObject:primaryColor forKey:kAnalyzedPrimaryColor];
    [dict setObject:secondaryColor forKey:kAnalyzedSecondaryColor];
    [dict setObject:detailColor forKey:kAnalyzedDetailColor];
    
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

typedef struct RGBAPixel
{
    Byte red;
    Byte green;
    Byte blue;
    Byte alpha;
    
} RGBAPixel;

- (UIColor*)_findEdgeColor:(UIImage*)image imageColors:(NSArray**)colors
{
    CGImageRef imageRep = image.CGImage;
    
    NSUInteger pixelRange = 8;
    NSUInteger scale = 256 / pixelRange;
    NSUInteger rawImageColors[pixelRange][pixelRange][pixelRange];
    NSUInteger rawEdgeColors[pixelRange][pixelRange][pixelRange];
    
    // Should probably just switch to calloc, but this doesn't show up in instruments
    // So I guess it's fine
    for(NSUInteger b = 0; b < pixelRange; b++) {
        for(NSUInteger g = 0; g < pixelRange; g++) {
            for(NSUInteger r = 0; r < pixelRange; r++) {
                rawImageColors[r][g][b] = 0;
                rawEdgeColors[r][g][b] = 0;
            }
        }
    }
    
    
    NSInteger width = CGImageGetWidth(imageRep);// [imageRep pixelsWide];
    NSInteger height = CGImageGetHeight(imageRep); //[imageRep pixelsHigh];
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, cs, kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, image.CGImage);
    CGColorSpaceRelease(cs);
    const RGBAPixel* pixels = (const RGBAPixel*)CGBitmapContextGetData(bmContext);
    for (NSUInteger y = 0; y < height; y++)
    {
        for (NSUInteger x = 0; x < width; x++)
        {
            const NSUInteger index = x + y * width;
            RGBAPixel pixel = pixels[index];
            Byte r = pixel.red / scale;
            Byte g = pixel.green / scale;
            Byte b = pixel.blue / scale;
            rawImageColors[r][g][b] = rawImageColors[r][g][b] + 1;
            if(0 == x) {
                rawEdgeColors[r][g][b] = rawEdgeColors[r][g][b] + 1;
            }
        }
    }
    CGContextRelease(bmContext);
    
    NSMutableArray* imageColors = [NSMutableArray array];
    NSMutableArray* edgeColors = [NSMutableArray array];
    
    for(NSUInteger b = 0; b < pixelRange; b++) {
        for(NSUInteger g = 0; g < pixelRange; g++) {
            for(NSUInteger r = 0; r < pixelRange; r++) {
                NSUInteger count = rawImageColors[r][g][b];
                if(count > _randomColorThreshold) {
                    UIColor* color = [UIColor colorWithRed:r / (CGFloat)pixelRange green:g / (CGFloat)pixelRange blue:b / (CGFloat)pixelRange alpha:1];
                    MARCountedColor * countedColor = [[MARCountedColor alloc] initWithColor:color count:count];
                    [imageColors addObject:countedColor];
                }
                
                count = rawEdgeColors[r][g][b];
                if(count > _randomColorThreshold) {
                    UIColor* color = [UIColor colorWithRed:r / (CGFloat)pixelRange green:g / (CGFloat)pixelRange blue:b / (CGFloat)pixelRange alpha:1];
                    MARCountedColor * countedColor = [[MARCountedColor alloc] initWithColor:color count:count];
                    [edgeColors addObject:countedColor];
                }
            }
        }
    }
    
    *colors = imageColors;
    
    NSMutableArray* sortedColors = edgeColors;
    [sortedColors sortUsingSelector:@selector(compare:)];
    
    MARCountedColor *proposedEdgeColor = nil;
    
    if ( [sortedColors count] > 0 )
    {
        proposedEdgeColor = [sortedColors objectAtIndex:0];
        
        if ( [proposedEdgeColor.color mar_isBlackOrWhite] ) // want to choose color over black/white so we keep looking
        {
            for ( NSInteger i = 1; i < [sortedColors count]; i++ )
            {
                MARCountedColor *nextProposedColor = [sortedColors objectAtIndex:i];
                
                if (((double)nextProposedColor.count / (double)proposedEdgeColor.count) > .4 ) // make sure the second choice color is 40% as common as the first choice
                {
                    if ( ![nextProposedColor.color mar_isBlackOrWhite] )
                    {
                        proposedEdgeColor = nextProposedColor;
                        break;
                    }
                }
                else
                {
                    // reached color threshold less than 40% of the original proposed edge color so bail
                    break;
                }
            }
        }
    }
    
    return proposedEdgeColor.color;
}


- (void)_findTextColors:(NSArray*)colors primaryColor:(UIColor**)primaryColor secondaryColor:(UIColor**)secondaryColor detailColor:(UIColor**)detailColor backgroundColor:(UIColor*)backgroundColor
{
    UIColor *curColor = nil;
    NSMutableArray *sortedColors = [NSMutableArray arrayWithCapacity:[colors count]];
    BOOL findDarkTextColor = ![backgroundColor mar_isDarkColor];
    
    for(MARCountedColor * countedColor in colors) {
        UIColor* curColor = [countedColor.color mar_colorWithMinimumSaturation:.15];
        
        if ( [curColor mar_isDarkColor] == findDarkTextColor )
        {
            NSUInteger colorCount = countedColor.count;
            
            //if ( colorCount <= 2 ) // prevent using random colors, threshold should be based on input image size
            //    continue;
            
            MARCountedColor *container = [[MARCountedColor alloc] initWithColor:curColor count:colorCount];
            
            [sortedColors addObject:container];
        }
    }
    
    [sortedColors sortUsingSelector:@selector(compare:)];
    
    for ( MARCountedColor *curContainer in sortedColors )
    {
        curColor = curContainer.color;
        
        if ( *primaryColor == nil )
        {
            if ( [curColor mar_isContrastingColor:backgroundColor] )
                *primaryColor = curColor;
        }
        else if ( *secondaryColor == nil )
        {
            if ( ![*primaryColor mar_isDistinct:curColor] || ![curColor mar_isContrastingColor:backgroundColor] )
                continue;
            
            *secondaryColor = curColor;
        }
        else if ( *detailColor == nil )
        {
            if ( ![*secondaryColor mar_isDistinct:curColor] || ![*primaryColor mar_isDistinct:curColor] || ![curColor mar_isContrastingColor:backgroundColor] )
                continue;
            
            *detailColor = curColor;
            break;
        }
    }
}


@end


@implementation MARCountedColor

- (id)initWithColor:(UIColor *)color count:(NSUInteger)count
{
    self = [super init];
    
    if ( self )
    {
        self.color = color;
        self.count = count;
    }
    
    return self;
}

- (NSComparisonResult)compare:(MARCountedColor *)object
{
    if ( [object isKindOfClass:[MARCountedColor class]] )
    {
        if ( self.count < object.count )
        {
            return NSOrderedDescending;
        }
        else if ( self.count == object.count )
        {
            return NSOrderedSame;
        }
    }
    
    return NSOrderedAscending;
}

@end
