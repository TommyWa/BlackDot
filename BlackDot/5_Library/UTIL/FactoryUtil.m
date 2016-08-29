//
//  FactoryUtil.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/21.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "FactoryUtil.h"
#import "AFHTTPSessionManager.h"
@implementation FactoryUtil
+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backImage:(UIImage * )image tatget:(id)target action:(SEL)action{
    
    UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;

}

+ (UIButton *)createAddButton{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH - 30, 20, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"ic_radio_button_unchecked_48px"] forState:UIControlStateNormal];
    return button;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame andImage:(UIImage *)image{
    UIImageView * iamgeV = [[UIImageView alloc] initWithFrame:frame];
    iamgeV.image = image;
    return iamgeV;
    
}

//+ (void)downloadDataWithURLString:(NSString *)urlString{
//    __weak typeof(self)weakSelf = self;
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary * bigDict = responseObject;
//            NSDictionary * dataDict = bigDict[@"data"];
//            NSArray * articlesArray = dataDict[@"articles"];
//            for (NSDictionary * dict in articlesArray) {
//                HotPointModel * hpModel = [[HotPointModel alloc] init];
//                [hpModel setValuesForKeysWithDictionary:dict];
//                [self.dataArray addObject:hpModel];
//            }
//            [weakSelf.tableView reloadData];
//            [ProgressHUD hideAfterSuccessOnView:weakSelf.view];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //数据请求失败
//        [ProgressHUD hideAfterFailOnView:weakSelf.view];
//        NSLog(@"%@",error);
//    }];
//
//}
@end
