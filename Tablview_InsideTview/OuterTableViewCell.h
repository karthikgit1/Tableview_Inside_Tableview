//
//  OuterTableViewCell.h
//  Tablview_InsideTview
//
//  Created by Vy Systems - iOS1 on 1/20/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol StepperDelegate<NSObject>
@optional
- (void)stepperTapped:(UIStepper *)sender;
@end
@interface OuterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIStepper *stp1;

@property (nonatomic, weak) id <StepperDelegate> delegate;

- (IBAction)stepperChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;

@end
