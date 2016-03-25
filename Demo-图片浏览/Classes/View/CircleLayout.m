//
//  CircleLayout.m
//  Demo-图片浏览
//
//  Created by Suning on 16/3/25.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "CircleLayout.h"
#import "UIView+Frame.h"

@interface CircleLayout()

@property(nonatomic,strong) NSMutableArray *attArr;

@end

@implementation CircleLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    [self.attArr removeAllObjects];
    
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<itemNum; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取自定义的layout
        UICollectionViewLayoutAttributes *layout = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attArr addObject:layout];
    }
}

-(NSMutableArray *)attArr{
    if (!_attArr) {
        _attArr = [NSMutableArray array];
    }
    return _attArr;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attArr;
}

/** 返回indexPath位置对应的item的布局 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];
    NSInteger radius = 100;
    
    //圆心
    CGFloat circleX = self.collectionView.width/2;
    CGFloat circleY = self.collectionView.height/2;
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.size = CGSizeMake(60, 60);
    if (1 == itemNum) {
        attr.center = CGPointMake(circleX, circleY);
    } else {
        CGFloat angle = indexPath.item*(2*M_PI)/itemNum;
        CGFloat attrCenterX = circleX - radius*cos(angle);
        CGFloat attrCenterY = circleY - radius*sin(angle);
        attr.center = CGPointMake(attrCenterX, attrCenterY);
    }
    return attr;
}

@end
