//
//  ImageViewCell.m
//  Demo-图片浏览
//
//  Created by Suning on 16/3/24.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ImageViewCell.h"
#import "Masonry.h"
#import "UIView+Frame.h"

@implementation ImageViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.imgView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.imgView.layer.borderWidth = 10;
        [self.contentView addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
    return self;
}

-(void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    self.imgView.image = [UIImage imageNamed:imgName];
}

@end
