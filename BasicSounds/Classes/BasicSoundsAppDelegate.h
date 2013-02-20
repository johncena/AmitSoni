//
//  BasicSoundsAppDelegate.h
//  BasicSounds
//
//  Created by Ray Wenderlich on 1/29/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class BasicSoundsViewController;

@interface BasicSoundsAppDelegate : NSObject <UIApplicationDelegate, AVAudioPlayerDelegate> {
    UIWindow *window;
    BasicSoundsViewController *viewController;
	AVAudioPlayer *_backgroundMusicPlayer;
	BOOL _backgroundMusicPlaying;
	BOOL _backgroundMusicInterrupted;
	UInt32 _otherMusicIsPlaying;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BasicSoundsViewController *viewController;

- (void)tryPlayMusic;

@end

