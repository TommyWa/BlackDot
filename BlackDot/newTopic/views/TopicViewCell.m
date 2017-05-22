//
//  TopicViewCell.m
//  MyZaker
//
//  Created by Penny&Me on 16/7/11.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "TopicViewCell.h"
#import "UIButton+WebCache.h"
#import "TopicDetailController.h"
@interface TopicViewCell ()
@property(nonatomic,strong)NSMutableArray * cellDataArray;
@property(nonatomic,strong)NSIndexPath * cellIndexPath;
@end

@implementation TopicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cellDataArray = [NSMutableArray array];
        self.cellIndexPath = [[NSIndexPath alloc] init];
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 350)];
//        rgb(200, 230, 201)rgb(232, 245, 233)
        self.bgImageView.backgroundColor = [UIColor colorWithRed:232/255.0 green:245/255.0 blue:233/255.0 alpha:1.0];
        self.bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.bgImageView];
        
        self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.imageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        self.imageButton.frame = CGRectMake(10, 10, WIDTH-20, 200);
        self.imageButton.titleLabel.textColor = mytitleColor;
        [self.bgImageView addSubview:self.imageButton];
        
        self.titleButton_1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleButton_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleButton_1.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleButton_1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleButton_1.backgroundColor = [UIColor whiteColor];
        self.titleButton_1.frame  = CGRectMake(10, CGRectGetMaxY(self.imageButton.frame), WIDTH-20, 50);
        [self.bgImageView addSubview:self.titleButton_1];
        
        self.titleButton_2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.titleButton_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleButton_2.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleButton_2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleButton_2.backgroundColor = [UIColor whiteColor];

        self.titleButton_2.frame  = CGRectMake(10, CGRectGetMaxY(self.titleButton_1.frame)+1, WIDTH-20, 50);
        [self.bgImageView addSubview:self.titleButton_2];

        self.entranceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.entranceButton setTitleColor:methemColor forState:UIControlStateNormal];
        self.entranceButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.entranceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.entranceButton.backgroundColor = [UIColor whiteColor];

        self.entranceButton.frame  = CGRectMake(10, CGRectGetMaxY(self.titleButton_2.frame)+1, WIDTH-20, 30);
        [self.bgImageView addSubview:self.entranceButton];


    }
    return self;
}

- (void)configWithDataArray:(NSMutableArray *)dataArray AndIndexPaht:(NSIndexPath *)indexPath{
    _cellDataArray = dataArray;
    _cellIndexPath = indexPath;
    TopicListModel *model = dataArray[indexPath.section][indexPath.row];
    NSString * entrance = [[model.entrance firstObject] valueForKey:@"title"];
    [self.entranceButton setTitle:entrance forState:UIControlStateNormal];
    self.entranceButton.tag = 1000;

    NSString * gallery = [[model.gallery firstObject] valueForKey:@"promotion_img"];
    NSString * gallerTitle = [[model.gallery firstObject] valueForKey:@"title"];
    [self.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:gallery] forState:UIControlStateNormal];
    [self.imageButton setTitle:gallerTitle forState:UIControlStateNormal];
    self.imageButton.tag =1001;

    
    NSString * buttonTitle1 = [[model.article firstObject] valueForKey:@"title"];
    [self.titleButton_1 setTitle:buttonTitle1 forState:UIControlStateNormal];
    self.titleButton_1.tag =1002;

    NSString * buttonTitle2 = [[model.article lastObject] valueForKey:@"title"];
    [self.titleButton_2 setTitle:buttonTitle2 forState:UIControlStateNormal];
    self.titleButton_2.tag = 1003;
    for (UIButton * button in self.bgImageView.subviews) {
        [button addTarget:self action:@selector(gotoDetai:) forControlEvents:UIControlEventTouchUpInside];
    }

}



- (void)gotoDetai:(UIButton *)button{
    TopicListModel * model = _cellDataArray[_cellIndexPath.section][_cellIndexPath.row];
    NSString * entrance = [model.entrance[0] valueForKey:@"topic"][@"api_url"];
    NSString * head = [model.gallery[0] valueForKey:@"article"][@"weburl"];
    NSString * title1 = [model.article[0] valueForKey:@"article"][@"weburl"];
    NSString * title2 = [model.article[1] valueForKey:@"article"][@"weburl"];
    NewsWebViewController * nvc = [[NewsWebViewController alloc] init];
   TopicDetailController  * hvc = [[TopicDetailController alloc] init];
    if (button.tag == 1000) {
        hvc.url = entrance;
        _urlBlock(entrance,hvc);
    }else if (button.tag == 1001){
        nvc.webUrl = head;
        _urlBlock(head,nvc);
    }else if (button.tag == 1002){
        nvc.webUrl = title1;
        _urlBlock(title1,nvc);
    }else if(button.tag == 1003){
        nvc.webUrl = title2;
        _urlBlock(title2,nvc);
    }
    
}










-(void)setModel:(TopicListModel *)model AndIndexPaht:(NSIndexPath *)indexPath{
    _model = model;
    NSString * entrance = [[model.entrance firstObject] valueForKey:@"title"];
    [self.entranceButton setTitle:entrance forState:UIControlStateNormal];
    self.entranceButton.tag = 1000;
    
    NSString * gallery = [[model.gallery firstObject] valueForKey:@"promotion_img"];
    NSString * gallerTitle = [[model.gallery firstObject] valueForKey:@"title"];
    [self.imageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:gallery] forState:UIControlStateNormal];
    self.imageButton.tag =1001;
    [self.imageButton setTitle:gallerTitle forState:UIControlStateNormal];
    
    NSString * buttonTitle1 = [[model.article firstObject] valueForKey:@"title"];
    [self.titleButton_1 setTitle:buttonTitle1 forState:UIControlStateNormal];
    self.titleButton_2.tag = 1002;
    
    
    NSString * buttonTitle2 = [[model.article lastObject] valueForKey:@"title"];
    [self.titleButton_2 setTitle:buttonTitle2 forState:UIControlStateNormal];
    self.titleButton_2.tag = 1003;
    for (UIButton * button in self.bgImageView.subviews) {
        [button addTarget:self action:@selector(gotoDetai:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
}

//                    //入口
//                    for (NSDictionary * xDict in smallModel.entrance) {
//                        entranceArray * emodel = [[entranceArray alloc] init];
//                        [emodel setValuesForKeysWithDictionary:xDict];
//                    }
//                    //第一个button
//                    for (NSDictionary * yDict in smallModel.gallery) {
//                        galleryArray * gmodel = [[galleryArray alloc] init];
//                        [gmodel setValuesForKeysWithDictionary:yDict];
//                    }
//                    //第二 三个button;
//                    for (NSDictionary * zDict in smallModel.article) {
//                        articelArray * amodel = [[articelArray alloc] init];
//                        [amodel setValuesForKeysWithDictionary:zDict];
//                    }




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
