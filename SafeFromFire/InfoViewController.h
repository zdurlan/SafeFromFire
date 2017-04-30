//
//  InfoViewController.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *theView;
@property (strong, nonatomic) AVPlayer *player;
- (IBAction)didTapReport:(id)sender;
@end
