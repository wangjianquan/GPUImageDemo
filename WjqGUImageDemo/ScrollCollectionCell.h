//
//  ScrollCollectionCell.h
//  ZhongSheGou
//
//  Created by landixing on 2016/12/15.
//  Copyright © 2016年 landixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imagView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (copy, nonatomic) void(^btnBlock) ();


@end
