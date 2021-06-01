//
//  CustomThing.h
//  ListRecursiveFiletypes
//
//  Created by Alexia Wilson on 2021-06-01.
//
#include <Foundation/Foundation.h>
#define let __auto_type const
#define var __auto_type

NS_ASSUME_NONNULL_BEGIN

@class CustomMutDict;
@interface CustomMutDict : NSObject {
    NSMutableDictionary<NSString *, NSNumber *> *_dict;
}

- (id)init;
- (void)addCustomDict:(CustomMutDict *)dict;
- (void)addNumber:(NSNumber *)number forKey:(NSString *) key;
- (NSMutableDictionary<NSString *, NSNumber *> *)getDict;

@end


NS_ASSUME_NONNULL_END
