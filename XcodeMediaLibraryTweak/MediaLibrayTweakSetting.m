//
//  MediaLibrayTweakSetting.m
//  XcodeMediaLibraryTweak
//
//  Created by wangyang on 6/3/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import "MediaLibrayTweakSetting.h"

@interface MediaLibrayTweakSetting ()

@end

@implementation MediaLibrayTweakSetting

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
}
- (IBAction)showColorPanel:(id)sender {
    NSColorPanel *panel = [NSColorPanel sharedColorPanel];
}


- (void)changeColor:(id)sender{
    
}

@end
