//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Kristopher Hamoud on 8/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay
{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_levelNode;
}

//is called when ccb file has completed loading
- (void)didLoadFromCCB
{
    //tell this scene to accept user touches
    self.userInteractionEnabled = YES;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
}

//called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self launchPenguin];
}

- (void)launchPenguin
{
    // loads the penguin.ccb we have set up in sprite builder
    CCNode *penguin = [CCBReader load:@"Penguin"];
    
    //position the penguin at the bowl of the catapult
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    //add the penguin to the physics node of this scene because it has physics enabled
    [_physicsNode addChild:penguin];
    
    //manually add & apply a force to launch the penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    //ensure the object is followed
    self.position = ccp(0, 0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [self runAction:follow];
}

@end