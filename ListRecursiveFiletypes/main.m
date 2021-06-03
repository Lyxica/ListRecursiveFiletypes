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
typedef NSMutableDictionary<NSURL *, NSDate *> UrlAndDate;


UrlAndDate* _get_file_types(NSURL *path, int depth, int max_depth)
{
    UrlAndDate *dict = [NSMutableDictionary new];
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
            [dict addEntriesFromDictionary:result];
        }
        else
        {
            var attributes = [fm attributesOfItemAtPath:url.path error:nil];
            dict[url] = [attributes fileModificationDate];
        }
    }
    
    return dict;
}

UrlAndDate* get_file_types(NSURL *path, int depth)
{
    var dict = _get_file_types(path, 1, depth);
    return dict;
}

int main(int argc, const char * argv[])
{
    fm = [NSFileManager defaultManager];
    var current_folder = argc == 1 ? NSFileManager.defaultManager.currentDirectoryPath : [NSString stringWithUTF8String:argv[1]];
    var results = get_file_types([[NSURL alloc] initFileURLWithPath:current_folder], 5);
    var sorted_keys = [results keysSortedByValueUsingComparator:^(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    var output = [NSMutableString new];
    var calendar = [NSCalendar currentCalendar];
    var component_units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    var formatter = [NSDateComponentsFormatter new];
    formatter.collapsesLargestUnit = YES;
    formatter.allowsFractionalUnits = YES;

    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleBrief;
    
    for (NSURL *key in sorted_keys) {
        var path = [key.path stringByReplacingOccurrencesOfString:current_folder withString:@"."];
        var date = results[key];
        var adjusted_date = [calendar components:component_units fromDate:date toDate:[NSDate now] options:0];
        
        [output appendFormat:@"%s ago\t%s\n", [formatter stringFromDateComponents:adjusted_date].UTF8String, path.UTF8String];
    }

    
    printf("%s\n", output.UTF8String);
    return 0;
}


