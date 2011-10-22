//
//  ViewController.h
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface ViewController : UIViewController {
  CalculatorBrain *brain;
  IBOutlet UILabel *display;
  IBOutlet UILabel *error;
  BOOL userIsTypingANumber;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
@end
