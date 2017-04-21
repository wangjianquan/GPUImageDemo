//
//  customVC.m
//  WjqGUImageDemo
//
//  Created by landixing on 2017/3/23.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "customVC.h"
#import "ScrollCollectionCell.h"



@interface customVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDataSourcePrefetching,UICollectionViewDelegateFlowLayout>

@property (strong , nonatomic) GPUImageView * videoPreView;
@property (strong , nonatomic) GPUImageVideoCamera * camera;
@property (strong , nonatomic) NSMutableArray * titleArray;
@property (strong , nonatomic) UICollectionView * collecView;
@property (strong , nonatomic) UICollectionViewFlowLayout * flowLayout;


/*截图*/
@property (strong , nonatomic) UIButton  * ScreenShotsBtn;//截屏按钮
@property (strong , nonatomic) UIView * clipView;//手势绘制的图片裁剪区域
@property (assign, nonatomic) CGPoint startPoint;//pan 手势起始位置


/*各个滤镜样式下可变值*/
@property (strong , nonatomic) UISlider * firstSlider;
@property (strong , nonatomic) UISlider * secondSlider;

@end

@implementation customVC

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpCamera];
    [self setUpCollectionView];

}

- (void)setUpCamera{
    
    /**
     1.创建视频源
     
     @SessionPreset  : 屏幕分辨率 AVCaptureSessionPresetHigh
     @cameraPosition : 摄像头方向
     
     */
    GPUImageVideoCamera * camera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    
    //设置摄像头 输出视频的方向
    camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _camera = camera;
    
    //2.创建用于展示视频的GPUImgaView
    GPUImageView * videoPreView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    _videoPreView = videoPreView;
    [self.view insertSubview:videoPreView atIndex:0];
    
    //处理链
    [_camera addTarget:_videoPreView];
    
    [camera startCameraCapture];
}

- (void)setUpCollectionView{

    /* FlowLayou */
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = 80;
    CGFloat heiht = width;
    flowLayout.itemSize = CGSizeMake(width, heiht);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 1;
    _flowLayout = flowLayout;
    
    
    /* Create collectionView */
    UICollectionView * collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collecView.delegate = self;
    collecView.dataSource = self;
    collecView.showsVerticalScrollIndicator = NO;
    collecView.showsHorizontalScrollIndicator = NO;
    [collecView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    _collecView = collecView;
    [self.view addSubview:collecView];
    
    WS(weakSelf);
    [collecView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-8);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, width));
    }];
    
    [collecView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"ScrollCollectionCell"];

    
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FilterStyle" ofType:@"plist"];
    self.titleArray = [NSMutableArray arrayWithContentsOfFile:path];
    [collecView reloadData];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScrollCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    cell.priceLabel.text = self.titleArray[indexPath.row];
       return cell;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    // 移除之前所有处理链
    [_camera removeAllTargets];
    
    switch (indexPath.row) {
        case 0:
        {
            //素描
            [[GPUImageApplyFilter shareApplyFliter]initWithSketchFilter:_camera imageView:_videoPreView];
            
        }
            break;
            
        case 1:
        {
            //朦胧加暗
            
            
            [[GPUImageApplyFilter shareApplyFliter]initWithHazeFilter:_camera imageView:_videoPreView];
        }
            break;
        case 2:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithThresholdSketchFilter:_camera imageView:_videoPreView];
        }
            break;
        case 3:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithToonFilter:_camera imageView:_videoPreView];
        }
            break;
        case 4:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithSmoothToonFilter:_camera imageView:_videoPreView];
        }
            break;
        case 5:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithkuwaharaFilter:_camera imageView:_videoPreView];
        }
            break;
        case 6:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithInvertFilter:_camera imageView:_videoPreView];
        }
            break;
        case 7:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithPolarPixellateFilter:_camera imageView:_videoPreView];
        }
            break;
        case 8:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithCrosshatchFilter:_camera imageView:_videoPreView];
        }
            break;
        case 9:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithColorPackingFilter:_camera imageView:_videoPreView];
        }
            break;
        case 10:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithVignetteFilter:_camera imageView:_videoPreView];
        }
            break;
        case 11:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithSwirlFilter:_camera imageView:_videoPreView];
        }
            break;
        case 12:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithBulgeDistortionFilter:_camera imageView:_videoPreView];
        }
            break;
        case 13:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithPinchDistortionFilter:_camera imageView:_videoPreView];
        }
            break;
        case 14:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithStretchDistortionFilter:_camera imageView:_videoPreView];
        }
            break;
        case 15:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithGlassSphereFilter:_camera imageView:_videoPreView];
        }
            break;
        case 16:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithSphereRefractionFilter:_camera imageView:_videoPreView];
        }
            break;
        case 17:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithPosterizeFilter:_camera imageView:_videoPreView];
        }
            break;
        case 18:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithCGAColorspaceFilter:_camera imageView:_videoPreView];
        }
            break;
        case 19:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithPerlinNoiseFilter:_camera imageView:_videoPreView];
        }
            break;
        case 20:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWith3x3ConvolutionFilter:_camera imageView:_videoPreView];
        }
            break;
       case 21:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithLuminanceThresholdFilter:_camera imageView:_videoPreView];
        }
            break;
        case 22:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithAdaptiveThresholdFilter:_camera imageView:_videoPreView];
        }
            break;
        case 23:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithExposureFilter:_camera imageView:_videoPreView];
        }
            break;
        case 24:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithContrastFilter:_camera imageView:_videoPreView];
        }
            break;
        case 25:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithSepiaFilter:_camera imageView:_videoPreView];
        }
            break;
        case 26:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithLevelsFilter:_camera imageView:_videoPreView];
        }
            break;
        case 27:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithGrayscaleFilter:_camera imageView:_videoPreView];
        }
            break;
        case 28:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithRGBFilter:_camera imageView:_videoPreView];
        }
            break;
        case 29:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithToneCurveFilter:_camera imageView:_videoPreView];
        }
            break;
        case 30:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithHighlightShadowFilter:_camera imageView:_videoPreView];
        }
            break;
        case 31:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithAverageLuminanceThresholdFilter:_camera imageView:_videoPreView];
        }
            break;
        case 32:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithSharpenFilter:_camera imageView:_videoPreView];
        }
            break;
        case 33:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithCrosshairGenerator:_camera imageView:_videoPreView];
        }
            break;
        case 34:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithLineGenerator:_camera imageView:_videoPreView];
        }
            break;
        case 35:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithGaussianBlurFilter:_camera imageView:_videoPreView];
        }
            break;
        case 36:
        {
            [[GPUImageApplyFilter shareApplyFliter]initWithBoxBlurFilter:_camera imageView:_videoPreView];
        }
            break;
            
            
        default:
            [_camera addTarget:_videoPreView];
            break;
    }

}

@end














