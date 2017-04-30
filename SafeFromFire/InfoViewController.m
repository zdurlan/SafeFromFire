//
//  InfoViewController.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 30/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "InfoViewController.h"
#import "User.h"


@interface InfoViewController () <UIWebViewDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Salvarea și evacuarea, în condiții de siguranță, în caz de incendiu" ofType:@"mp4"]];
    
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    self.player = player;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    [playerLayer setFrame:self.theView.bounds];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.theView.layer addSublayer:playerLayer];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.player pause];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapReport:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"loggedUser"];
    User *loggedUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if(loggedUser){
        [self performSegueWithIdentifier:@"goToPanic" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You must be logged in to use this feature" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}
@end
