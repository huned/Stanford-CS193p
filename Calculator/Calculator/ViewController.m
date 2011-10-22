//
//  ViewController.m
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (CalculatorBrain *)brain {
  if (!brain) {
    brain = [[CalculatorBrain alloc] init];
  }
  return brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
  NSString *digit = [[sender titleLabel] text];
  if (userIsTypingANumber) {
    BOOL hasDecimal = [[display text] rangeOfString:@"."].location != NSNotFound;
    
    // ignore subsequent decimal points
    if ([digit isEqual:@"."] && hasDecimal)
      return;
    
    // divide by zero
    if ([digit isEqual:@"0"] && [[brain waitingOperation] isEqual:@"/"]) {
      [error setText:@"Divide by 0"];
      [display setText:@"0"];
      [brain reset];
      return;
    }
    
    [display setText:[[display text] stringByAppendingString:digit]];
  } else {
    [display setText:digit];
    userIsTypingANumber = YES;
  }
}

- (IBAction)operationPressed:(UIButton *)sender {
  // negative square root
  if ([[[sender titleLabel] text] isEqual:@"sqrt"] && [[display text] doubleValue] < 0) {
    [error setText:@"Negative square root"];
    [display setText:@"0"];
    [brain reset];
    return;
  }
  
  if (userIsTypingANumber) {
    [[self brain] setOperand:[[display text] doubleValue]];
    userIsTypingANumber = NO;
  }
  NSString *operation = [[sender titleLabel] text];
  double result = [[self brain] performOperation:operation];
  [display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
