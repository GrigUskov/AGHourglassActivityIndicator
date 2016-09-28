//
//  AGHourglassActivityIndicator.h
//
//  Created by Grig Uskov
//  Copyright © 2016 ALSEDI Group. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AGHourglassActivityIndicator : UIImageView

@property (nonatomic) UIColor *color; // [UIColor grayColor] by default

// use startAnimating], [ stopAnimating], .animationDuration
// frame size is always set to value dividable by 33 (33, 66, 99 etc...);

@end
