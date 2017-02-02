//
//  Children.h
//  KVOtester
//
//  Created by Randy McLain on 1/30/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Children : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSUInteger age;
@property (strong, nonatomic) Children * child;
@property (strong, nonatomic) NSMutableArray * siblings;

-(NSUInteger) countOfSiblings;
-(id) objectInSiblingsAtIndex:(NSUInteger)index;
-(void) insertObject:(NSString *)object inSiblingsAtIndex:(NSUInteger)index;
-(void) removeObjectFromSiblingsAtIndex:(NSUInteger)index; 
@end
