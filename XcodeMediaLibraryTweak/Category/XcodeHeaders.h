//
//  XcodeHeaders.h
//  XcodeMediaLibraryTweak
//
//  Created by wangyang on 5/10/15.
//  Copyright (c) 2015 IGIU. All rights reserved.
//

#ifndef XcodeMediaLibraryTweak_XcodeHeaders_h
#define XcodeMediaLibraryTweak_XcodeHeaders_h


@interface DVTLibraryAssetView : NSView
@property(retain, nonatomic) NSImage *image; // @synthesize image=_image;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
@property(copy, nonatomic) NSString *summary; // @synthesize summary=_summary;

@end

@interface IDEMediaResourceVariantSet : NSObject
@property(readonly, nonatomic) NSSet *resources; // IDEMediaResource的集合
@property(copy, nonatomic) NSString *name;
@end

@interface DVTLibraryAsset : NSObject
@property(retain) NSImage *image;   // 缩略图
@property(retain) IDEMediaResourceVariantSet *representedObject;
@end

@interface DVTPrimitiveFileDataType : NSObject
- (id)displayName;
- (id)identifier;

@end

@interface DVTFilePath : NSObject{
    NSString *_pathString;
    NSURL *_fileURL;
    
}
@property(readonly) NSDictionary *fileSystemAttributes;
@property(readonly) NSDictionary *fileAttributes;
@property(readonly) NSString *fileTypeAttribute;
@property(readonly) NSString *fileName;
@property(readonly) NSURL *fileURL;
@property(readonly) NSArray *pathComponents;
@property(readonly) NSString *pathString;

@end

@interface IDEMediaResource : NSObject
@property(readonly, nonatomic) DVTFilePath *sourceFilePath;
@property(readonly, nonatomic) DVTPrimitiveFileDataType *contentType; // @synthesize contentType=_contentType;

@end


@interface DVTAssetAndGroupSet : NSObject
{
    BOOL _isObservingAsset;
    DVTLibraryAssetView *_view;
    DVTLibraryAsset *_asset;
    NSSet *_groups;
}

+ (id)observedAssetKeyPaths;
@property(readonly) DVTLibraryAsset *asset; // @synthesize asset=_asset;
@property(readonly) DVTLibraryAssetView *view; // @synthesize view=_view;

- (id)initWithAsset:(id)arg1 andGroups:(id)arg2;

@end
#endif
