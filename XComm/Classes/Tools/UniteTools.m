//
//  UniteTools.m
//  LoveStudy
//
//  Created by xpg on 14/11/6.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import "UniteTools.h"

#define DATA_FD     @"data"
#define CACHE_FD    @"cache"
#define VIDEO_FD    @"video"

typedef enum{
    v_show_unequal_full = 0,        //不等比满屏
    v_show_equal_full,              //等比满屏
    v_show_equal_unfull             //等比不满屏
}en_V_SHOW_MODLE;


NSString* getCurrDate_UT()
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    return currentTime;
}

NSString* getCacheRoot_UT()
{
    return [getDataRoot_UT() stringByAppendingPathComponent:CACHE_FD];
}

NSString* getVideoCacheRoot_UT()
{
    return [getCacheRoot_UT() stringByAppendingPathComponent:VIDEO_FD];
}


NSString* getDataRoot_UT()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:DATA_FD];
}

NSString* generatedVideoLocalPathWithUrl_UT(NSString* strUrl)
{
    NSURL* url = [NSURL URLWithString:strUrl];
    NSString* path = [url path];
    
    return [[getCacheRoot_UT() stringByAppendingPathComponent:VIDEO_FD] stringByAppendingPathComponent:path];
}

void makePath_UT(NSString* path)
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error != nil) {
            NSLog(@"create path error. %@", error.domain);
        }
    }
}

CGRect zoomCreateRect_UT(CGRect referenceRect, CGSize srcSize, int nmodle)
{
    if (nmodle == v_show_unequal_full) {
        return referenceRect;
    }
    
    CGRect rtRet = CGRectMake(0, 0, 0, 0);
    CGRect rtTemp = CGRectMake(0, 0, 0, 0);
    rtTemp.size.width = referenceRect.size.width;
    rtTemp.size.height = srcSize.height*(rtTemp.size.width/srcSize.width);
    
    if (nmodle == v_show_equal_full) {
        if (rtTemp.size.height >= referenceRect.size.height) {
            rtRet.size = rtTemp.size;
        }else{
            rtRet.size.height = referenceRect.size.height;
            rtRet.size.width = srcSize.width*(rtRet.size.height/srcSize.height);
        }
    }else if(nmodle == v_show_equal_unfull)
    {
        if (rtTemp.size.height <= referenceRect.size.height) {
            rtRet.size = rtTemp.size;
        }else{
            rtRet.size.height = referenceRect.size.height;
            rtRet.size.width = srcSize.width*(rtRet.size.height/srcSize.height);
        }
    }
    
    rtRet.origin.x = (referenceRect.size.width - rtRet.size.width)/2;
    rtRet.origin.y = (referenceRect.size.height - rtRet.size.height)/2;
    
    
    return rtRet;
}



UIImage *zoomImageWithDstSize_UT(CGSize dstsize, UIImage *image)
{
    if (nil == image)
    {
        return nil;
    }
    
    CGRect rect_screen = CGRectMake(0, 0, dstsize.width, dstsize.height);
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    rect_screen.size.width *= scale_screen;
    rect_screen.size.height *= scale_screen;
    
    if (image.size.width<rect_screen.size.width && image.size.height<rect_screen.size.height)
    {
        return image;
    }
    
    
    CGRect dst_rect = zoomCreateRect_UT(rect_screen, image.size, v_show_equal_full);
    
    UIGraphicsBeginImageContext(dst_rect.size);
    CGRect rect = CGRectMake(0, 0, dst_rect.size.width, dst_rect.size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}

id objectWithClass(Class oclass)
{
    Class tClass = NULL;
    id ret = nil;
    @try {
        tClass = oclass;
        ret = [[tClass alloc] init];
    }
    @catch (NSException *exception) {
        //Handle an exception thrown in the @try block
        NSLog(@"NSException:%@", exception);
        return nil;
    }
    @finally {
        //Code that gets executed whether or not an exception is thrown
    }
    
    return ret;
}

void getFileSysInfo(NSString** strused,
                    NSString** strtotal,
                    float* usedrate)
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSFileManager* fileManager = [[NSFileManager alloc ]init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    float free_G = ([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0/1024.0;
    float total_G = [totalSpace longLongValue]/1024.0/1024.0/1024.0;
    if (free_G >= 1.0f) {
        *strused = [NSString stringWithFormat:@"%0.1fGB", free_G];
    }else{
        *strused = [NSString stringWithFormat:@"%0.1fMB", ([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0];
    }
    
    if (total_G >= 1.0f) {
        *strtotal = [NSString stringWithFormat:@"%0.1fGB", total_G];
    }else{
        *strtotal = [NSString stringWithFormat:@"%0.1fMB", [totalSpace longLongValue]/1024.0/1024.0];
    }
    
    *usedrate = ((float)([totalSpace longLongValue] - [freeSpace longLongValue]))/[totalSpace longLongValue];
}

