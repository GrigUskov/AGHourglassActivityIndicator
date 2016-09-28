//
//  AGHourglassActivityIndicator.m
//
//  Created by Grig Uskov
//  Copyright © 2016 ALSEDI Group. All rights reserved.
//

#import "AGHourglassActivityIndicator.h"


@implementation AGHourglassActivityIndicator

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 33, 33)];
}


- (instancetype)initWithFrame:(CGRect)frame {
    _color = [UIColor grayColor];
    self = [super initWithFrame:frame];
    self.animationDuration = 7;
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    _color = [UIColor grayColor];
    self = [super initWithCoder:aDecoder];
    self.animationDuration = 7;
    return self;
}


#define rectSize (self.frame.size.width / 33)
static uint getByte(uint64_t value, uint index) {
    return (value >> (index * 8)) & 255;
}


- (void)drawRowAtY:(uint)y x:(uint)x raw:(uint)raw {
    for (int i = 0; i < 5; i++)
        if (((raw >> i) & 1) == 1)
            [self drawRectAtX:x + i * 2 y:y width:1 height:1];
}


- (void)drawRectAtX:(NSInteger)x y:(NSInteger)y width:(NSInteger)width height:(NSInteger)height {
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(rectSize * x, rectSize * y, rectSize * width, rectSize * height));
}


- (UIImage *)makeImage:(uint64_t)raw {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [_color setFill];
    
#define dx 12
#define dy 9
#define dy2 (dy + 13)
    for (int i = 0; i < 4; i++) {
        [self drawRowAtY:dy + i x:dx + i raw:getByte(raw, i)];
        [self drawRowAtY:dy2 + i x:dx + 3 - i raw:getByte(raw, i + 4)];
    }
    
    if (((raw >> 5) & 1) == 1) [self drawRectAtX:dx + 2 * 2 y:dy + 4 width:1 height:1];
    if (((raw >> 6) & 1) == 1) [self drawRectAtX:dx + 2 * 2 y:dy2 - 3 width:1 height:1];
    if (((raw >> 7) & 1) == 1) [self drawRectAtX:dx + 2 * 2 y:dy2 - 1 width:1 height:1];
    
    [self renderHourglassImage];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


- (void)renderHourglassImage {
    static const uint64_t raw[16] = {134418690, 134545921, 386204161, 151392001, 151454212, 369558020, 168493569,
        185336321, 202179073, 219021825, 353042945, 336331265, 319619585, 302907905, 235864578, 286196226};
    
    for (int i = 0; i < 16; i++) {
        [self drawRectAtX:getByte(raw[i], 3) y:getByte(raw[i], 2) width:getByte(raw[i], 1) height:getByte(raw[i], 0)];
        [self drawRectAtX:getByte(raw[i], 3) y:33 - getByte(raw[i], 2) - getByte(raw[i], 0) width:getByte(raw[i], 1) height:getByte(raw[i], 0)];
    }
}


- (void)createFrames {
    static const uint64_t raw[18] = {50794303, 50794363, 50794355, 288230376202506097, 864691128505928561, 1008806316581783921,
        1009932216488626529, 1010495166442047840, 1010497365465301344, 1082554959503229024, 2235476464109813856, 2235757939086458976,
        2238009738900013152, 2238010838394863712, 2238015236407820384, 2238015240702787648, 2238015249292722240, 2238015249292722304};
    
    Boolean wasAnimating = self.isAnimating;
    self.animationImages = nil;
    if (self.frame.size.width <= 0) return;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:18];
    for (int i = 0; i < 18; i++)
        [images addObject:[self makeImage:raw[i]]];
    
    UIImage *lastImage = images.lastObject;
    [images addObject:lastImage]; // delay before rotate hourglass
    [images addObject:[self roatateImage:lastImage at:M_PI * 0.25]];
    [images addObject:[self roatateImage:lastImage at:M_PI * 0.5]];
    [images addObject:[self roatateImage:lastImage at:M_PI * 0.75]];
    [images addObject:images.firstObject]; // delay before sand will start falling
    
    self.animationImages = images;
    if (wasAnimating)
        [self startAnimating];
}


- (UIImage *)roatateImage:(UIImage *)image at:(CGFloat)angle {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), image.size.width / 2, image.size.height / 2);
    CGContextRotateCTM(UIGraphicsGetCurrentContext(), angle);
    [image drawAtPoint:CGPointMake(-image.size.width / 2, -image.size.height / 2)];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


- (void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = color;
        [self createFrames];
    }
}


- (void)setFrame:(CGRect)frame {
    frame.size.height = frame.size.width = ceil(frame.size.width / 33) * 33;
    [super setFrame:frame];
    if (self.animationImages.lastObject.size.width != frame.size.width)
        [self createFrames];
}

@end
