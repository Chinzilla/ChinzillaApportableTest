//
//  HelloWorldLayer.m
//  ApportableTestCases
//
//  Created by Jordan Ferber on 7/18/14.
//  Copyright Jordan Ferber 2014. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        
        CCMenuItem *itemMovie = [CCMenuItemFont itemWithString:@"Movie" block:^(id sender) {
            [self playVideo:NO];
        }];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"al_acheive_rev4.mp3"];
        CCMenuItem *itemSound = [CCMenuItemFont itemWithString:@"Sound" block:^(id sender) {
            [self playSoundEffect:@"al_acheive_rev4.mp3"];
        }];
		
		CCMenu *menu = [CCMenu menuWithItems:itemMovie, itemSound, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark -
#pragma mark Video

-(void) playVideo:(BOOL)noSkip {
    //[[CDAudioManager sharedManager] setMode:kAMM_FxPlusMusic];
    [CCVideoPlayer setDelegate:self];
    [CCVideoPlayer setNoSkip:noSkip];
    
    CCDelayTime *delay = [CCDelayTime actionWithDuration:0.01f];
    CCCallBlock *block = [CCCallBlock actionWithBlock:^{
#ifdef ANDROID
        [CCVideoPlayer playMovieWithFile:@"IntroMovie.mp4"];
#else
        [CCVideoPlayer playMovieWithFile:@"IntroMovie.mov"];
#endif
    }];
    [self runAction:[CCSequence actions:delay, block, nil]];
}

-(void) moviePlaybackFinished {
    [[CCDirector sharedDirector] startAnimation];
}

-(void) movieStartedPlaying {

}

-(void) movieStartsPlaying {
    [[CCDirector sharedDirector] stopAnimation];
}

#pragma mark -
#pragma mark Sound Effects

-(void) playSoundEffect:(NSString *)effect {
    [self playSoundEffect:effect volume:1.0f];
}

-(void) playSoundEffect:(NSString *)effect volume:(float)volume {
    [self playSoundEffect:effect volume:volume ignoreOption:NO];
}

-(void) playSoundEffect:(NSString *)effect volume:(float)volume ignoreOption:(BOOL)ignoreOption {
    [SimpleAudioEngine sharedEngine].effectsVolume = volume;
    [[SimpleAudioEngine sharedEngine] playEffect:effect pitch:1.0f pan:1.0f gain:volume];
}

@end
