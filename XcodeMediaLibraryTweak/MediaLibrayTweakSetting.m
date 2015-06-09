//
//  MediaLibrayTweakSetting.m
//  XcodeMediaLibraryTweak
//
//  Created by wangyang on 6/3/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import "MediaLibrayTweakSetting.h"

@interface MediaLibrayTweakSetting ()
{
    __weak IBOutlet NSColorWell *_colorWell;
}
@end

@implementation MediaLibrayTweakSetting

- (void)windowDidLoad {
    [super windowDidLoad];
    _colorWell.color = self.color;
}

- (IBAction)colorChange:(NSColorWell *)sender {
    self.color = sender.color;
    
    // 保存
    NSData *colorData = [NSArchiver archivedDataWithRootObject:sender.color];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"MediaLibrayTweakColor"];
}

- (NSColor *)color{
    if (!_color) {
        NSData *colorData = [[NSUserDefaults standardUserDefaults] dataForKey:@"MediaLibrayTweakColor"];
        
        if (!colorData) {
            _color = [NSColor blackColor];
        }else{
            _color = [NSUnarchiver unarchiveObjectWithData:colorData];
        }
    }
    
    return _color;
}

@end
