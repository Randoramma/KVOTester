//
//  Children.m
//  KVOtester
//
//  Created by Randy McLain on 1/30/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import "Children.h"
#import "Constants.h"

@implementation Children

-(instancetype) init {
    self = [super init];
    
    if (self) {
    self.name = @"";
    self.age = 0;
    self.siblings = [[NSMutableArray alloc] init]; 
    }
    
    return self; 
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:NAME]) {
        return NO;
    } else {
        return [super automaticallyNotifiesObserversForKey:key]; // let iOS handle all the other keys that wern't explicitly handled here.
    }
}

-(void) setName:(NSString *)name {
    [self willChangeValueForKey:NAME];
    _name = name;
    [self didChangeValueForKey:NAME];
}


-(NSUInteger) countOfSiblings {
    return self.siblings.count;
}

-(id) objectInSiblingsAtIndex:(NSUInteger)index {
    return [self.siblings objectAtIndex:index];
}

-(void) removeObjectFromSiblingsAtIndex:(NSUInteger)index {
    [self.siblings removeObjectAtIndex: index]; 
}

-(void) insertObject:(NSString *)object inSiblingsAtIndex:(NSUInteger)index {
    [self.siblings insertObject:object atIndex:index];
}
@end
