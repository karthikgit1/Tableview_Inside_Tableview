//
//  ViewController.h
//  Tablview_InsideTview
//
//  Created by Vy Systems - iOS1 on 1/20/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "InnerTableViewCell.h"
#import "OuterTableViewCell.h"
@interface ViewController : UIViewController<StepperDelegate>

@property (weak, nonatomic) IBOutlet UITableView *outertableview;

@end

