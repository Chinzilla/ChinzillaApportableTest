//
//  HelloWorldLayer.h
//  ApportableTestCases
//
//  Created by Jordan Ferber on 7/18/14.
//  Copyright Jordan Ferber 2014. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "CCVideoPlayer.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <CCVideoPlayerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
