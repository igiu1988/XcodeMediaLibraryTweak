//
//  WYTweak.m
//  XcodeMediaLibraryTweak
//
//  Created by wangyang on 5/10/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#import "WYTweak.h"
#import "XcodeHeaders.h"
#import "Aspects.h"
#import <objc/runtime.h>

static WYTweak *sharedPlugin;

@interface WYTweak()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end


@implementation WYTweak
+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        
        
        
        // DVTLibraryAssetView就是显示在Media Libray列表里的View
//        [objc_getClass("DVTLibraryAssetView") aspect_hookSelector:@selector(setTitle:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
//            
//            DVTLibraryAssetView *view = [aspectInfo instance];
//            
//            // 检查imageSize是否正确
//            
//            NSValue *value = objc_getAssociatedObject(view, NSSelectorFromString(@"imageSize"));
//            NSSize imageSize = [value sizeValue];
//            if (NSEqualSizes(NSZeroSize, imageSize)) {
//                return ;
//            }
//            
//            
//            NSString *title = [aspectInfo arguments][0];
//            
//            NSString *imageSizeString = [NSString stringWithFormat:@"大小：%.0fx%.0f", imageSize.width, imageSize.height];
//            NSString *newTitle = [title stringByAppendingFormat:@"\n\n%@", imageSizeString];
//            
//            
//            NSInvocation *invocation = [aspectInfo originalInvocation];
//            [invocation setArgument:&newTitle atIndex:2];
//            
//            
//        } error:NULL];
        
        [objc_getClass("DVTLibraryAssetView") aspect_hookSelector:@selector(drawRect:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            
            DVTLibraryAssetView *view = [aspectInfo instance];

            NSValue *value = objc_getAssociatedObject(view, NSSelectorFromString(@"imageSize"));
            NSSize imageSize = [value sizeValue];
            if (NSEqualSizes(NSZeroSize, imageSize)) {
                return ;
            }
            
            NSString *imageSizeString = [NSString stringWithFormat:@"size %.0fx%.0f", imageSize.width, imageSize.height];
            [imageSizeString drawAtPoint:NSMakePoint(60, 40) withAttributes:@{NSFontAttributeName:[NSFont systemFontOfSize:12], NSForegroundColorAttributeName:[NSColor redColor]}];
            
        } error:NULL];
        
        // DVTAssetAndGroupSet把DVTLibraryAsset和DVTLibraryAssetView联系到了一起
        [objc_getClass("DVTAssetAndGroupSet") aspect_hookSelector:@selector(initWithAsset:andGroups:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            
            DVTAssetAndGroupSet *assetAndGroupSet = [aspectInfo instance];
            
            DVTLibraryAsset *asset = assetAndGroupSet.asset;
            DVTLibraryAssetView *view = assetAndGroupSet.view;
            
            // 从asset中得到image大小
            // 资源存在1位、2倍、3倍图时，resourceSet就会有多个元素了
            id representedObject = asset.representedObject;
            NSLog(@"库类型%@", NSStringFromClass([representedObject class]));
            if (![NSStringFromClass([representedObject class]) isEqualToString:@"IDEMediaResourceVariantSet"]) {
                return ;
            }
            
            
            
            NSSet *resourceSet = asset.representedObject.resources;
            
            // 随便取一个资源出来，在image size时，sdk会自动帮助我们识别图片大小
            IDEMediaResource *resouce = [resourceSet anyObject];
            
            // 只有为图像资源时，才进行大小识别
            DVTPrimitiveFileDataType *fileType = resouce.contentType;
            NSString *typeString = [fileType displayName];
            
            if ([typeString containsString:@"Image"]) {
                DVTFilePath *file = resouce.sourceFilePath;
                NSImage *image = [[NSImage alloc] initWithContentsOfURL:file.fileURL];
                NSValue *sizeValue = [NSValue valueWithSize:[image size]];
                
                objc_setAssociatedObject(view, NSSelectorFromString(@"imageSize"), sizeValue, OBJC_ASSOCIATION_RETAIN);
            }
            
            
            
        } error:NULL];
        
    }
    return self;
}

@end
