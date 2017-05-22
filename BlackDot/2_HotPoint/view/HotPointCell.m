//
//  HotPointCell.m
//  WYTNews
//
//  Created by Penny&Me on 16/6/23.
//  Copyright © 2016年 WangYuetong. All rights reserved.
//

#import "HotPointCell.h"
#import "HotPointModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
@interface HotPointCell()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * authorLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UIImageView * imageV;
@end


@implementation HotPointCell

//重写init方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] init];
        self.authorLabel = [[UILabel alloc] init];
        self.timeLabel = [[UILabel alloc] init];
        self.imageV = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.imageV];

    }
    return self;
}

//通过判断动态设置cell控件的位置 和 cell显示内容
- (void)setMyCellFrameWithItemType:(NSString *)itemType Image:(NSArray *)imageArray{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    if ([itemType isEqualToString:@"1_b"] ) {
        //显示一张大图
        self.imageV.frame = CGRectMake(0, 0, WIDTH, 200);
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject]]]];

        self.titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.imageV.frame)+10, WIDTH, 40);
        self.authorLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), 80, 10);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.authorLabel.frame), CGRectGetMaxY(self.titleLabel.frame), 80, 10) ;
        //显示3张小图
    }else if ([itemType isEqualToString:@"3_b"]){
        self.imageV.frame = CGRectMake(0, 0, WIDTH, 100);
        for (int i = 0; i < 3; i++) {
            UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3*i, 0, (WIDTH-10)/3, 100)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageArray[i]]]];
            [self.imageV addSubview:imageV];
        }
        self.titleLabel.frame = CGRectMake(10, CGRectGetMaxY(self.imageV.frame), WIDTH, 40);
        self.authorLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), 80, 10);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.authorLabel.frame), CGRectGetMaxY(self.titleLabel.frame), 80, 10) ;
        //显示右边1张小图
    }else if ([itemType isEqualToString:@"1"]){
        self.titleLabel.frame = CGRectMake(10, 10, WIDTH-150, 40);
        self.authorLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), 80, 10);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.authorLabel.frame), CGRectGetMaxY(self.titleLabel.frame), 80, 10) ;
        self.imageV.frame = CGRectMake(WIDTH-100, 0, 100, 80);
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject]]]];

    }else {
        self.titleLabel.frame = CGRectMake(10, 10, WIDTH, 40);
        self.authorLabel.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame), 80, 10);
        self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.authorLabel.frame), CGRectGetMaxY(self.titleLabel.frame), 80, 10) ;
    }
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.numberOfLines = 0;
    self.authorLabel.font = [UIFont systemFontOfSize:12];
    self.authorLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];

}


//使用约束确定cell上控件的位置

- (void)setMycellLayOutWithItemType:(NSString *)itemType Image:(NSArray *)imageArray{
    __weak typeof(self)weakSelf = self;
    
    if ([itemType isEqualToString:@"1_b"] ) {

        //图像高200 文字高60 （50+10）
        //约束图像:
            [weakSelf.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(0);
            make.top.equalTo(weakSelf).offset(0);
            make.right.equalTo(weakSelf).offset(0);
            make.bottom.equalTo(weakSelf).offset(-60);
        }];

        [weakSelf.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject]]]];

        //约束标题
        [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.imageV.mas_bottom).offset(10);
        }];
        //约束作者名
        [weakSelf.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];
        //约束更新时间
        [weakSelf.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.authorLabel.mas_right).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(3);
        }];
        
        
    }
    //显示3张小图
    else if ([itemType isEqualToString:@"3_b"]){
    
            [weakSelf.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(0);
            make.top.equalTo(weakSelf).offset(0);
            make.right.equalTo(weakSelf).offset(0);
            make.bottom.equalTo(weakSelf.mas_top).offset(120);
        }];
        for (int i = 0; i < 3; i++) {
            UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3*i, 0, (WIDTH-10)/3, 120)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageArray[i]]]];
            [weakSelf.imageV addSubview:imageV];
        }

        [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.imageV.mas_bottom).offset(10);

        }];
        
        [weakSelf.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];
        
        [weakSelf.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.authorLabel.mas_right).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];
        
        
        //显示右边1张小图
    }
    else if ([itemType isEqualToString:@"1"]){
        
        [weakSelf.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(0);
            make.bottom.equalTo(weakSelf).offset(0);
            make.right.equalTo(weakSelf).offset(0);
            make.left.equalTo(weakSelf.mas_right).offset(-100);
        }];
        [weakSelf.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray lastObject]]]];

        [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf).offset(10);
            make.right.equalTo(weakSelf.mas_left).offset(270);
        }];
        
        [weakSelf.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
            make.right.equalTo(weakSelf.mas_left).offset(75);
        }];
        
        [weakSelf.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.authorLabel.mas_right).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];
        
    }
    else {
        [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.right.equalTo(weakSelf).offset(-10);
            make.top.equalTo(weakSelf).offset(10);

        }];
        
        [weakSelf.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
            
        }];
        
        [weakSelf.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.authorLabel.mas_right).offset(10);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
        }];

    }
    
    weakSelf.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    weakSelf.titleLabel.numberOfLines = 0;
    weakSelf.authorLabel.font = [UIFont systemFontOfSize:12];
    weakSelf.authorLabel.textColor = [UIColor grayColor];
    weakSelf.timeLabel.font = [UIFont systemFontOfSize:12];
    weakSelf.timeLabel.textColor = [UIColor grayColor];

    
    
    
}




- (void)setHModel:(HotPointModel *)hModel{
    _hModel = hModel;
    self.titleLabel.text = hModel.title;
    self.timeLabel.text = hModel.list_dtime;
    self.authorLabel.text = hModel.auther_name;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
