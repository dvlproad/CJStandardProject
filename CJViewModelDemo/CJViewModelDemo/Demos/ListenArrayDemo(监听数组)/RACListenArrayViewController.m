//
//  RACListenArrayViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACListenArrayViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACListenArrayViewController () {
    
}
@property (nonatomic, strong) NSMutableArray<NSString *> *flawArray;
@property (nonatomic, strong) NSMutableArray<NSString *> *okArray;

@property (nonatomic, strong) NSMutableArray<NSString *> *racTestArray;

@end



@implementation RACListenArrayViewController

- (void)dealloc {
    [self removeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Listen Array(监听数组)", nil);
    
    self.flawArray = [[NSMutableArray alloc] init];
    self.okArray = [[NSMutableArray alloc] init];
    
    [self addObserver];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //系统KVO监听数组
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"系统KVO监听数组";
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"增(正确)";
            bindModule.actionBlock = ^{
                NSString *string = [NSString stringWithFormat:@"%d", rand()%100];
                
                NSMutableArray *kvo_okArray = [self mutableArrayValueForKey:@"okArray"];
                [kvo_okArray addObject:string];
            };
            [sectionDataModel.values addObject:bindModule];
        }
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"增(错误)";
            bindModule.actionBlock = ^{
                NSString *string = [NSString stringWithFormat:@"%d", rand()%100];
                [self.flawArray addObject:string];
            };
            [sectionDataModel.values addObject:bindModule];
        }
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"删(正确)";
            bindModule.actionBlock = ^{
                if (self.okArray.count) {
                    NSMutableArray *kvo_okArray = [self mutableArrayValueForKey:@"okArray"];
                    [kvo_okArray removeLastObject];
                }
            };
            [sectionDataModel.values addObject:bindModule];
        }
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"删(错误)";
            bindModule.actionBlock = ^{
                if (self.flawArray.count) {
                    [self.flawArray removeLastObject];
                }
            };
            [sectionDataModel.values addObject:bindModule];
        }
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"改最后一个(正确)";
            bindModule.actionBlock = ^{
                if (self.okArray.count) {
                    NSString *string = [NSString stringWithFormat:@"%d", rand()%100];
                    NSMutableArray *kvo_okArray = [self mutableArrayValueForKey:@"okArray"];
                    NSInteger lastIndex = self.okArray.count - 1;
                    [kvo_okArray replaceObjectAtIndex:lastIndex withObject:string];
                } else {
                    //[CJToast shortShowMessage:@"没有数据可以更改了"];
                }
            };
            [sectionDataModel.values addObject:bindModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //RAC监听数组
    {
        self.racTestArray = [[NSMutableArray alloc] init];

        RACSignal *arraySignal = [[RACObserve(self, racTestArray) merge:self.racTestArray.rac_sequence.signal] map:^id _Nullable(id  _Nullable value) {
            [CJToast shortShowMessage:@"racTestArray数据更新"];
            NSLog(@"self.racTestArray = %@", self.racTestArray);
            
            return @(self.racTestArray.count > 0);
        }];
        
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"RAC监听数组";
        
        {
            CJModuleModel *bindModule = [[CJModuleModel alloc] init];
            bindModule.title = @"增(正确)";
            bindModule.actionBlock = ^{
                NSString *string = [NSString stringWithFormat:@"%d", rand()%100];
                
                //[self.racTestArray addObject:string];//同理这种方式并不会触发signal
                NSMutableArray *kvo_racTestArray = [self mutableArrayValueForKey:@"racTestArray"];
                [kvo_racTestArray addObject:string];
            };
            [sectionDataModel.values addObject:bindModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    self.sectionDataModels = sectionDataModels;
}

- (void)addObserver {
    [self addObserver:self
           forKeyPath:@"flawArray"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:NULL];
    
    [self addObserver:self
           forKeyPath:@"okArray"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:NULL];
}

- (void)removeObserver {
    if (_flawArray != nil) {
        [_flawArray removeObserver:self forKeyPath:@"flawArray"];
    }
    if (_okArray != nil) {
        [_okArray removeObserver:self forKeyPath:@"okArray"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"okArray"]) {
        [CJToast shortShowMessage:@"okArray数据更新"];
        NSLog(@"self.okArray = %@", self.okArray);
        
    } else if ([keyPath isEqualToString:@"flawArray"]) {
        [CJToast shortShowMessage:@"flawArray数据更新"];
        NSLog(@"self.flawArray = %@", self.flawArray);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
