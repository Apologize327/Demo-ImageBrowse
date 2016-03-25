//
//  ViewController.m
//  Demo-图片浏览
//
//  Created by Suning on 16/3/24.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewCell.h"
#import "LineLayout.h"
#import "CircleLayout.h"

#define mScreenWidth    [UIScreen mainScreen].bounds.size.width

static NSString *const cellIdentifer = @"imageCell";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectionView;
}

@property(nonatomic,strong) NSMutableArray *dataImgArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataImgArr = [NSMutableArray array];
    [self setUpDataArr];
    [self setUpCollectionview];
}

-(void)setUpDataArr{
    if (0 == _dataImgArr.count) {
        for (NSInteger i=0; i<20; i++) {
            NSString *name = [NSString stringWithFormat:@"%ld",i+1];
            [_dataImgArr addObject:name];
        }
    }
}

-(void)setUpCollectionview{
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, mScreenWidth, 300) collectionViewLayout:[CircleLayout new]];
    [_collectionView registerClass:[ImageViewCell class] forCellWithReuseIdentifier:cellIdentifer];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([_collectionView.collectionViewLayout isKindOfClass:[LineLayout class]]) {
        CircleLayout *circle = [[CircleLayout alloc]init];
        [_collectionView setCollectionViewLayout:circle animated:YES];
    } else {
        LineLayout *line = [[LineLayout alloc]init];
        line.itemSize = CGSizeMake(160, 160);
        [_collectionView setCollectionViewLayout:line animated:YES];
    }
}

#pragma mark —— UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataImgArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageViewCell *imgCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    imgCell.imgName = [self.dataImgArr objectAtIndex:indexPath.item];
    
    return imgCell;
}

/** 点击删除item */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataImgArr removeObjectAtIndex:indexPath.item];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
