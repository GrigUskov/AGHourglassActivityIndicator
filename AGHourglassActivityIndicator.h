//
//  AGHourglassActivityIndicator.h
//
//  Created by Grig Uskov
//  Copyright © 2016 ALSEDI Group. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AGHourglassActivityIndicatorStyleDefault,
    AGHourglassActivityIndicatorStyleLite
} AGHourglassActivityIndicatorStyle;


@interface AGHourglassActivityIndicator : UIImageView

- (instancetype)initWithStyle:(AGHourglassActivityIndicatorStyle)style;

@property (nonatomic) AGHourglassActivityIndicatorStyle style;
@property (nonatomic) UIColor *color; // [UIColor grayColor] by default

// use startAnimating], [ stopAnimating], .animationDuration
// frame size is always set to value dividable by 33 (33, 66, 99 etc...);

@end
