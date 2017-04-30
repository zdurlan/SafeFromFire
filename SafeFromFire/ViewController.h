//
//  ViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

- (IBAction)didTapSkip:(id)sender;
- (IBAction)didTapRegister:(id)sender;
@end

