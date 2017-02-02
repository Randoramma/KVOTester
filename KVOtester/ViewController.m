//
//  ViewController.m
//  KVOtester
//
//  Created by Randy McLain on 1/30/17.
//  Copyright © 2017 Randy McLain. All rights reserved.
//

#import "Constants.h"
#import "ViewController.h"
#import "Children.h"



static void *child1Context = &child1Context;
static void *child2Context = &child2Context;

@interface ViewController ()

@property (nonatomic, strong) Children * child1;
@property (nonatomic, strong) Children * child2;
@property (nonatomic, strong) Children * child3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.child1 = [[Children alloc] init];
    
    // standard definitiions
    // self.child1.name = @"George";
    // self.child1.age = 15;
    
    
    // Setting KVO Values
    [self.child1 setValue:@"George" forKey:NAME];
    [self.child1 setValue:[NSNumber numberWithInteger:15] forKey:AGE];
    NSLog(@"%@, %lu", self.child1.name, self.child1.age);
    
    self.child2 = [[Children alloc] init];
    [self.child2 setValue:@"Mary" forKey:NAME];
    [self.child2 setValue:[NSNumber numberWithInteger:35] forKey:AGE];
    self.child2.child = [[Children alloc] init];
    
    [self.child2 setValue:@"Andrew" forKeyPath:@"child.name"];
    [self.child2 setValue:[NSNumber numberWithInteger:5] forKeyPath:@"child.age"];
    NSLog(@"%@, %lu", self.child2.child.name, (unsigned long)self.child2.child.age);
    
    self.child3 = [[Children alloc] init];
    self.child3.child = [[Children alloc] init];
    self.child3.child.child = [[Children alloc] init];
    
    [self.child3 setValue:@"Tom" forKeyPath:@"child.child.name"];
    [self.child3 setValue:[NSNumber numberWithInteger:2] forKeyPath:@"child.child.age"];
    NSLog(@"%@, %lu", self.child3.child.child.name, self.child3.child.child.age);
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.child1 addObserver:self
                  forKeyPath:NAME
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:child1Context];
    
    [self.child1 addObserver:self
                  forKeyPath:AGE
                     options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                     context:child1Context];
    
    // [self.child1 setValue:@"Michael" forKey:NAME];
    
    //  [self.child1 willChangeValueForKey:NAME];  Notifying the observer the value is about to change manually.
    // self.child1.name = @"Michael";
    
    // [self.child1 didChangeValueForKey:NAME];  Manually sending the notification to alert the observer the name was changed. This can be done anytime after the value was changed.
    [self.child1 setValue:[NSNumber numberWithInteger:20] forKey:AGE];
    
    [self.child2 addObserver:self
                  forKeyPath:AGE
                     options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                     context:child2Context];
    [self.child2 setValue:[NSNumber numberWithInteger:45] forKey:AGE];
    
    self.child1.name = @"Michael"; // code is being set in implementation file of Children with custom setter using KVO.  
    
    [self.child1 addObserver:self forKeyPath:SIBLINGS options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    [self.child1 insertObject:@"Alex" inSiblingsAtIndex:0];
    [self.child1 insertObject:@"Bob" inSiblingsAtIndex:1];
    [self.child1 insertObject:@"Mary" inSiblingsAtIndex:2];
    [self.child1 removeObjectFromSiblingsAtIndex:1];
    
    
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.child1 removeObserver:self forKeyPath:NAME];
    [self.child1 removeObserver:self forKeyPath:AGE];
    [self.child2 removeObserver:self forKeyPath:AGE];
    [self.child1 removeObserver:self forKeyPath:SIBLINGS];
    
}

#pragma mark - KVO Observer Method

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == child1Context) {
        if ([keyPath isEqualToString:NAME]) {
            NSLog(@"The name of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
        if ([keyPath isEqualToString:AGE]) {
            NSLog(@"The age of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
    } else if (context == child2Context) {
        if ([keyPath isEqualToString:NAME]) {
            NSLog(@"The name of the SECOND child was changed.");
            NSLog(@"%@", change);
        }
        if ([keyPath isEqualToString:AGE]) {
            NSLog(@"The age of the SECOND child was changed.");
            NSLog(@"%@", change);
        }
    } else {
        if([keyPath isEqualToString:SIBLINGS]) {
            NSLog(@"%@", change);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
