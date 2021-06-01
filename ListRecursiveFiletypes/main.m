//
//  main.m
//  ListRecursiveFiletypes
//
//  Created by Alexia Wilson on 2021-06-01.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionaryExtension.h"
#define let __auto_type const
#define var __auto_type

NSFileManager *fm;

CustomMutDict* _get_file_types(NSURL *path, int depth, int max_depth)
{
    var dict = [CustomMutDict new];

    if (depth > max_depth)
    {
        return dict;
    }
    var folder_enumerator = [fm enumeratorAtURL:path includingPropertiesForKeys:NULL options:NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:NULL];
   
    for (NSURL *url in folder_enumerator)
    {
        if ([url hasDirectoryPath])
        {
            var result = _get_file_types(url, depth + 1, max_depth);
            [dict addCustomDict:result];
        }
        else
        {
            var extension = url.pathExtension;
            if ([@"" isEqualTo:extension])
            {
                continue;
            }
            [dict addNumber:@1 forKey:extension];
        }
    }
    
    return dict;
}

NSMutableDictionary<NSString *, NSNumber *>* get_file_types(NSURL *path, int depth)
{
    var dict = _get_file_types(path, 1, depth);
    return [dict getDict];
}

int main(int argc, const char * argv[])
{
    fm = [NSFileManager defaultManager];
    var current_folder = NSFileManager.defaultManager.currentDirectoryPath;
    var results = get_file_types([[NSURL alloc] initFileURLWithPath:@"/Users"], 5);
    var sorted_keys = [results keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    var output = [NSMutableString new];
    
    for (NSString *str in sorted_keys) {
        [output appendFormat:@"%d\t => .%s\n", results[str].intValue, str.UTF8String];
    }
    
    printf("%s\n", output.UTF8String);
    return 0;
}


