//
//  BasicSoundsViewController.h
//  BasicSounds
//
//  Created by Ray Wenderlich on 1/29/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BasicSoundsViewController : UIViewController {
	SystemSoundID _pewPewSound;
	
}

- (IBAction)spaceshipTapped:(id)sender;
- (void)fireBullet;

@end

