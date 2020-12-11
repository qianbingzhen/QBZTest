//
//  ViewController.m
//  testChain
//
//  Created by User on 2020/12/10.
//

#import "ViewController.h"
#import "ViewController1.h"
typedef int (^sumBlock) (int);

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)fun:(int (^)(int))block
{}

-(void)fun1:(sumBlock)block{}

-(int(^)(int))fun{
    return ^(int count){
        return count;
    };
}

-(sumBlock)fun2{
    return ^(int count){
        return count;
    };
}
@end
