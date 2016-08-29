//
//  HomeTopScrollView.m
//  MyZaker
//
//  Created by Penny&Me on 16/6/28.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HomeTopScrollView.h"
@interface HomeTopScrollView()<UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray * scrollArray;
@end

@implementation HomeTopScrollView


- (instancetype)initWithFrame:(CGRect)frame AndPicArray:(NSArray *)picArray{
    if (self = [super initWithFrame:frame]) {
        
        _scrollArray = [NSMutableArray arrayWithArray:picArray];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(WIDTH * picArray.count, 200);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        for (int i = 0; i < picArray.count; i++) {
            //图片
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, 200)];
            //分类图片
            UIImageView * typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-20, 15, 20, 15)];
            //图片标题
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height-25, WIDTH, 25)];
            label.textColor = mytitleColor;
            label.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.5];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 1000 + i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoDetail:)];
            [imageView addGestureRecognizer:tap];
            //准备数据
            HomeTopModel * model = picArray[i];
            TopicDict * tapModel = [[TopicDict alloc] init];
            [tapModel setValuesForKeysWithDictionary:model.topic];
            TagInfoDict * tagModel = [[TagInfoDict alloc] init];
            [tagModel setValuesForKeysWithDictionary:model.tag_info];
            //处理数据
            [typeImage sd_setImageWithURL:[NSURL URLWithString:tagModel.image_url]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.promotion_img]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;

            label.text = model.title;
            label.textColor = [UIColor whiteColor];

            [imageView addSubview:label];
            [imageView addSubview:typeImage];
            [_scrollView addSubview:imageView];
        }
    }
    return self;
}

- (void)gotoDetail:(UITapGestureRecognizer *)tap{
    UIImageView * imV = (UIImageView *)tap.view;
    HomeTopModel * model = _scrollArray[imV.tag - 1000];
    articelModel * aModel = [[articelModel alloc] init];
    [aModel setValuesForKeysWithDictionary:model.article];
    TagInfoDict * tagModel = [[TagInfoDict alloc] init];
    [tagModel setValuesForKeysWithDictionary:model.tag_info];

    if (model.block_info) {
        _block(model.block_info[@"api_url"],tagModel.text);
    }else if(model.topic){
        _block(model.topic[@"api_url"],tagModel.text);
    }else{
        _block(aModel.weburl,@"articles");
    }
    
}

@end
