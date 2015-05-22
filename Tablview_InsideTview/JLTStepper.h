//
//  JLTStepper.h
//  Tablview_InsideTview
//
//  Created by Vy Systems - iOS1 on 1/21/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum JLTStepperPlusMinusState_ {
    JLTStepperMinus = -1,
    JLTStepperPlus  = 1,
    JLTStepperUnset = 0
} JLTStepperPlusMinusState;

@interface JLTStepper : UIStepper
@property (nonatomic) JLTStepperPlusMinusState plusMinusState;
@end
