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
  NSString *digit = sender.titleLabel.text;
  if (userIsTypingANumber) {
    BOOL hasDecimal = [display.text rangeOfString:@"."].location != NSNotFound;
    
    // ignore subsequent decimal points
    // TODO push into model
    if ([digit isEqual:@"."] && hasDecimal)
      return;
    
    // divide by zero
    // TODO push into model
    if ([digit isEqual:@"0"] && [[brain waitingOperation] isEqual:@"/"]) {
      error.text = @"Divide by 0";
      display.text = @"0";
      [brain reset];
      return;
    }

    display.text = [display.text stringByAppendingString:digit];
  } else {
    display.text = digit;
    userIsTypingANumber = YES;
  }
}

- (IBAction)operationPressed:(UIButton *)sender {
  // negative square root
  // TODO push into model
  if ([sender.titleLabel.text isEqual:@"sqrt"] && [display.text doubleValue] < 0) {
    error.text = @"Negative square root";
    display.text = @"0";
    [brain reset];
    return;
  }
  
  if (userIsTypingANumber) {
    [[self brain] setOperand:[display.text doubleValue]];
    userIsTypingANumber = NO;
  }
  NSString *operation = sender.titleLabel.text;
  double result = [[self brain] performOperation:operation];
  display.text =[NSString stringWithFormat:@"%g", result];
}

@end