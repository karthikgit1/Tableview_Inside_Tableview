//
//  ViewController.m
//  Tablview_InsideTview
//
//  Created by Vy Systems - iOS1 on 1/20/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "ViewController.h"
#import "JLTStepper.h"
@interface ViewController ()
{
    int firstrow;
    int secondrow;
    
    NSMutableArray *insertIndexPaths;
    
    int rowctr;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    firstrow = 2;
    
    secondrow = 3;
    
    rowctr = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if (theTableView.tag == 10)
    {
        
        return 2;
    }
    else
    {
        if (rowctr ==0)
        {
            rowctr = rowctr + 1;
            return firstrow;
        }
        else if ( rowctr == 1)
        {
            rowctr = rowctr + 1;
            
            return secondrow;
        }
        
        return secondrow;

    }
}

static NSString *innercellIdentifier = @"InnerTableViewCell";
static NSString *outercellIdentifier = @"outerTableViewCell";

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (theTableView.tag == 10)
    {
        OuterTableViewCell *cell = (OuterTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:outercellIdentifier];
        if (cell == nil)
        {
            cell = [[OuterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:outercellIdentifier];
        }
        
        JLTStepper *stepper = [[JLTStepper alloc] initWithFrame:(CGRect){{10, 5}, 20, 0}];
        [stepper addTarget:self action:@selector(stepperTapped:) forControlEvents:UIControlEventValueChanged];
        stepper.tag = indexPath.row;
        stepper.stepValue = 1;
        stepper.continuous = YES;
        stepper.minimumValue = 0;
//        stepper.tag = 5;
        if (indexPath.row == 0)
        {
            stepper.value = firstrow;
        }
        else if(indexPath.row == 1)
        {
            stepper.value = secondrow;
        }
        else
        {
            stepper.value = 5;
        }
        
        stepper.maximumValue = 10;
        [cell.contentView addSubview:stepper];
        
        //#import <QuartzCore/QuartzCore.h>
        cell.lbl1.layer.borderColor = [UIColor redColor].CGColor;

        cell.lbl1.layer.borderWidth = 1;
       
        return cell;

    }
    else
    {
        
        InnerTableViewCell *cell = (InnerTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:innercellIdentifier];
        if (cell == nil)
        {
            cell = [[InnerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:innercellIdentifier];
        }
        
        cell.txtf1.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        cell.txtf2.text = @"ssfdf";
        return cell;

    }
    
    
    
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}

-(void)stepperTapped:(JLTStepper*)stepper
{
    NSLog(@"stepper value is %f",stepper.value);
    
    BOOL isadd = false;
    if (stepper.plusMinusState == JLTStepperPlus)
    {
        isadd = true;
        NSLog(@" Plus button pressed");
    }
    else if (stepper.plusMinusState == JLTStepperMinus)
    {
        isadd = false;
        NSLog(@" Minus button pressed");
    }
    else
    {
        NSLog(@"Shouldn't happen unless value is set programmatically.");
    }
    
   // NSLog(@"indexpath.row is %d",[NSIndexPath indexPathForRow:stepper.tag inSection:0].row);
    
    
    UITableViewCell *cell = [self.outertableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:stepper.tag inSection:0]];
    
    UITableView *tv1 = (UITableView*)[cell viewWithTag:100];

    
    insertIndexPaths = [[NSMutableArray alloc]init];
    
    
    
    if ([NSIndexPath indexPathForRow:stepper.tag inSection:0].row == 0)
    {
        if (isadd == true)
        {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:firstrow inSection:0]];
            rowctr = 0;
            // firstrow = firstrow +1 ;
            
            firstrow = stepper.value ;
        }
        else
        {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:firstrow-1 inSection:0]];
            rowctr = 0;
            // firstrow = firstrow +1 ;
            
            firstrow = stepper.value ;
        }
        
    }
    else
    {
        if (isadd)
        {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:secondrow inSection:0]];
            rowctr = 1;
            //secondrow = secondrow + 1;
            
            secondrow = stepper.value;
        }
        else
        {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:secondrow-1 inSection:0]];
            rowctr = 1;
            //secondrow = secondrow + 1;
            
            secondrow = stepper.value;
        }
    }
    
    [tv1 beginUpdates];
    if (isadd == true)
    {
        [tv1 insertRowsAtIndexPaths:insertIndexPaths
                   withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        [tv1 deleteRowsAtIndexPaths: insertIndexPaths
                   withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [tv1 endUpdates];
    
//    if ([NSIndexPath indexPathForRow:stepper.tag inSection:0].row == 0)
//    {
//        
//        [tv1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:firstrow-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    }
//    else
//    {
//        
//        [tv1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:secondrow-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    }
    
    [tv1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:stepper.value - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}


#pragma mark-uibutton
- (IBAction)getValuesFromTview:(id)sender
{
    for(int i=0;i<2;i++)
    {
        UITableViewCell *_outercell = [self.outertableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        UITableView *_innertvw = (UITableView*)[_outercell viewWithTag:100];
        
        for (int j=0; j<2; j++)
        {
            UITableViewCell *innercell = [_innertvw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
            
            UITextField *_t1 = (UITextField*)[innercell viewWithTag:2];
            UITextField *_t2 = (UITextField*)[innercell viewWithTag:3];
            
            NSLog(@"txt1 is %@",_t1.text);
            NSLog(@"txt2 is %@",_t2.text);
        }
        
        //UITextField *_t1 = (UITextField*)[cell viewWithTag:2];
        
        //NSLog(@"string is %@",txtField.text);
    }

}

@end
