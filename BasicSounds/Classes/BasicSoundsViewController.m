//
//  BasicSoundsViewController.m
//  BasicSounds
//
//  Created by Ray Wenderlich on 1/29/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import "BasicSoundsViewController.h"
#include <sys/time.h>

@implementation BasicSoundsViewController

- (void)viewDidLoad {
	
	// This is the simplest way to play a sound.
	// But note with System Sound services you can only use:
	// File Formats (a.k.a. audio containers or extensions): CAF, AIF, WAV
	// Data Formats (a.k.a. audio encoding): linear PCM (such as LEI16) or IMA4
	// Sounds must be 30 sec or less
	// And only one sound plays at a time!
	NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:@"pew-pew-lei" ofType:@"caf"];
	NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
	AudioServicesCreateSystemSoundID((CFURLRef)pewPewURL, &_pewPewSound);
}

- (IBAction)spaceshipTapped:(id)sender {
	AudioServicesPlaySystemSound(_pewPewSound);
	[self fireBullet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
	AudioServicesDisposeSystemSoundID(_pewPewSound);
    [super dealloc];
}

#pragma mark These are just methods for fun :P

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIImageView *bullets = (UIImageView *)context;
	[bullets removeFromSuperview];
}

- (void)fireBullet {
	UIImageView *bullets = [[[UIImageView alloc] initWithFrame:CGRectMake(84, 256, 147, 29)] autorelease];
	bullets.image = [UIImage imageNamed:@"bullets.png"];
	[self.view addSubview:bullets];
	[self.view sendSubviewToBack:bullets];
	[UIView beginAnimations:@"shoot" context:bullets];
	CGRect frame = bullets.frame;
	frame.origin.y = -29;
	bullets.frame = frame;
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[UIView commitAnimations];
}

@end
