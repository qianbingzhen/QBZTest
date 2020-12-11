//
//  ViewController11.m
//  testChain
//
//  Created by User on 2020/12/10.
//

#import "ViewController1.h"

@interface ViewController1 ()
@property (nonatomic,assign) NSInteger age;

@property (nonatomic,assign) NSInteger sumResult;
- (ViewController1 *)test1;
- (ViewController1 *)test6;
- (ViewController1 *(^)(id model))test3;
- (ViewController1 *(^)(id some))test2;
- (ViewController1 *)test4:(NSInteger (^)(NSInteger age))block;
- (ViewController1 *(^)(NSInteger sumResult))add;

- (ViewController1 *)qtest:(NSInteger (^)(NSInteger age))ageBlock;
- (ViewController1 *(^)(NSInteger age))btest;

@end
@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    int a=20;
    typedef int (^sumBlock) (int);

    int(^block)(int)  = ^(int a){return a;};
    block(20);
    NSLog(@"%@",[(^(){return a;}) class]);

    self.test2(@"123");
    // Do any additional setup after loading the view.
    ViewController1 *vc = [self.test1.test6.test3(@"123") test4:^NSInteger(NSInteger age) {
        age = age+10;
        return age;
    }].add(20).add(40);
    NSLog(@"%ld",(long)self.age);
    
    [self qtest:^NSInteger(NSInteger age) {
        self.age +=90;
        return self.age;
    }];
    self.btest(20);
    
}
- (ViewController1 *)qtest:(NSInteger (^)(NSInteger age))ageBlock{
    self.age = ageBlock(_age);
    return self;
}
- (ViewController1 *(^)(NSInteger age))btest
{
    return ^(NSInteger age){
        self->_age += 20;
        return self;
    };
}
- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (ViewController1 *)test1
{
    return self;
}
- (ViewController1 *(^)(id some))test2
{
    return ^(id some){
        return self;
    };
}
- (ViewController1 *)test6
{
    NSLog(@"%s",__func__);
    return self;
}
- (ViewController1 *(^)(id model))test3
{
    return ^(id model){
        NSLog(@"%@",model);

        return  self;
    };
}
- (ViewController1 *)test4:(NSInteger (^)(NSInteger age))block
{
    _age = block(_age);
    return self;
}
- (ViewController1 *(^)(NSInteger sumResult))add
{
    return ^(NSInteger sumResult){
        self->_sumResult += sumResult;
        NSLog(@"%ld",(long)self->_sumResult);
        return self;
    };
}

-(void)fun:(int (^)(int))block
{
    
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController1].
    // Pass the selected object to the new view controller.
}
*/

@end
