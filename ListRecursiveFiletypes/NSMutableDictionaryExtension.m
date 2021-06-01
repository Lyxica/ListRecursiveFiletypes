//
//  CustomDict.m
//  ListRecursiveFiletypes
//
//  Created by Alexia Wilson on 2021-06-01.
//

#import "NSMutableDictionaryExtension.h"

@implementation CustomMutDict

- (id)init
{
    self = [super init];
    _dict = [NSMutableDictionary new];
    return self;
}

- (void)addCustomDict:(CustomMutDict *)customDict
{
    var dict = [customDict getDict];
    for (NSString *str in dict.allKeys) {
        if ([_dict objectForKey:str] == nil)
        {
            _dict[str] = dict[str];
        }
        else
        {
            NSNumber *value1 = _dict[str];
            NSNumber *value2 = dict[str];
            NSNumber *newValue = [NSNumber numberWithInt:[value1 intValue] + [value2 intValue]];
            _dict[str] = newValue;
        }
    }
}

- (void) addNumber:(NSNumber *)number forKey:(NSString *)key
{
    var current_value = [_dict objectForKey:key];
    if (current_value == nil)
    {
        _dict[key] = number;
    }
    else
    {
        var new_number = [NSNumber numberWithInt:current_value.intValue + number.intValue];
        _dict[key] = new_number;
    }
}

-(NSMutableDictionary<NSString *,NSNumber *> *)getDict
{
    return _dict;
}

@end
