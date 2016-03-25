//
//  ImageViewCell.h
//  Demo-图片浏览
//
//  Created by Suning on 16/3/24.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,copy) NSString *imgName;

@end
