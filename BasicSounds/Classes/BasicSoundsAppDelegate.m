//
//  BasicSoundsAppDelegate.m
//  BasicSounds
//
//  Created by Ray Wenderlich on 1/29/10.
//  Copyright Ray Wenderlich 2010. All rights reserved.
//

#import "BasicSoundsAppDelegate.h"
#import "BasicSoundsViewController.h"

@implementation BasicSoundsAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	// Set up the audio session
	// See handy chart on pg. 55 of the Audio Session Programming Guide for what the categories mean
	// Not absolutely required in this example, but good to get into the habit of doing
	// See pg. 11 of Audio Session Programming Guide for "Why a Default Session Usually Isn't What You Want"
	NSError *setCategoryError = nil;
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
	
	// Create audio player with background music
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"background-music-aac" ofType:@"caf"];
	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
	NSError *error;
	_backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
	[_backgroundMusicPlayer setDelegate:self];  // We need this so we can restart after interruptions
	[_backgroundMusicPlayer setNumberOfLoops:-1];	// Negative number means loop forever
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player {
	_backgroundMusicInterrupted = YES;
	_backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player {
	if (_backgroundMusicInterrupted) {
		[self tryPlayMusic];
		_backgroundMusicInterrupted = NO;
	}
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[self tryPlayMusic];
}

- (void)tryPlayMusic {
	
	// Check to see if iPod music is already playing
	UInt32 propertySize = sizeof(_otherMusicIsPlaying);
	AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &_otherMusicIsPlaying);
	
	// Play the music if no other music is playing and we aren't playing already
	if (_otherMusicIsPlaying != 1 && !_backgroundMusicPlaying) {
		[_backgroundMusicPlayer prepareToPlay];
		[_backgroundMusicPlayer play];
		_backgroundMusicPlaying = YES;
	}	
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
