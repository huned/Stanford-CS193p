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
  if (!brain) brain = [[CalculatorBrain alloc] init];
  return brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
  NSString *digit = sender.titleLabel.text;
  if (userIsTypingANumber) {
    // ignore subsequent decimal points
    // TODO push into model
    if ([digit isEqual:@"."] && [brain hasDecimal]) return;

    // append digit to display contents
    display.text = [display.text stringByAppendingString:digit];
  } else {
    display.text = digit;
    userIsTypingANumber = YES;
  }
}

- (IBAction)operationPressed:(UIButton *)sender {
  if (userIsTypingANumber) {
    [[self brain] setOperand:[display.text doubleValue]];
    userIsTypingANumber = NO;
  }

  NSString *operation = sender.titleLabel.text;
  double result = [[self brain] performOperation:operation];
  display.text = [NSString stringWithFormat:@"%g", result];

  if ([brain isError]) {
    error.text = brain.errorMessage;
  } else {
    error.text = @"";
  }
}

@end