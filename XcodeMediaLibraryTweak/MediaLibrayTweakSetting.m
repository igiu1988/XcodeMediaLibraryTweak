//
//  MediaLibrayTweakSetting.m
//  XcodeMediaLibraryTweak
//
//  Created by wangyang on 6/3/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import "MediaLibrayTweakSetting.h"

#define DEFAULT_COLOR       0xff0000

#define RGBCOLOR_HEX(hexColor) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f         \
green: (((hexColor >> 8) & 0xFF))/255.0f             \
blue: ((hexColor & 0xFF))/255.0f                    \
alpha: 1]

@interface MediaLibrayTweakSetting ()
{
    
    __weak IBOutlet NSTextField *_colorLabel;
    __weak IBOutlet NSColorWell *_colorWell;
    
}
@end

@implementation MediaLibrayTweakSetting

- (void)windowDidLoad {
    [super windowDidLoad];

    [[NSUserDefaults standardUserDefaults] setObject:@(0xff0000) forKey:@"MediaLibrayTweakColor"];
}


@end
