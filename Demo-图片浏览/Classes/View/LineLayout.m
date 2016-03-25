//
//  LineLayout.m
//  Demo-图片浏览
//
//  Created by Suning on 16/3/25.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "LineLayout.h"
#import "UIView+Frame.h"

@implementation LineLayout

-(void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat insert = (self.collectionView.width - self.itemSize.width)/2;
    self.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
}

/** rect改变时，是否刷新界面 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/** 返回rect范围内cell的布局 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //图片最大时的中心点
    CGFloat centerX = self.collectionView.width/2 + self.collectionView.contentOffset.x;
    
    NSArray *attrArr = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attr in attrArr) {
        CGFloat space = ABS(attr.center.x - centerX);
        //space越大，说明离中心点越远，图片应该越小。所以应该是1减去其值.1换成其它值也可以,只要使scale成反比例即可
        CGFloat scale = 1 - space/self.collectionView.width;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrArr;
}

/** 返回collectionview停止移动时的偏移量
 * proposedContentOffset是目标cell停止移动s时预估的偏移量
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *attrArr = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.width/2;
    
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrArr) {
        CGFloat space = centerX - attr.center.x;
        if (minSpace > ABS(space)) {
            minSpace = space;
        }
    }
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}

@end
