//
//  CustomGPUImageViewController.m
//  WjqGUImageDemo
//
//  Created by landixing on 2017/3/22.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomGPUImageViewController.h"

@interface CustomGPUImageViewController ()
@property (nonatomic, weak) GPUImageBilateralFilter *bilateralFilter;//美白
@property (nonatomic, weak) GPUImageBrightnessFilter *brightnessFilter;//亮度
@property (strong , nonatomic) GPUImageSharpenFilter *sharpenFilter;//锐化
@property (strong , nonatomic) GPUImageExposureFilter * exposureFilter;// 曝光
@property (strong , nonatomic) GPUImageContrastFilter * contrastFilter;//对比度
@property (strong , nonatomic) GPUImageSaturationFilter * saturationFilter; //饱和度

@property (strong , nonatomic) GPUImageView * videoPreView;
@property (strong , nonatomic) GPUImageVideoCamera * camera;
@property (strong , nonatomic) IBOutlet UISlider *mpSlider;//磨皮
@property (strong , nonatomic) IBOutlet UISlider *mbSlider; //美白
@property (strong , nonatomic) IBOutlet UISlider *bgSlider;//普光
@property (strong , nonatomic) IBOutlet UISlider *dbdSlider; //对比度
@property (strong , nonatomic) IBOutlet UISlider *bhdSlider; //饱和度
@property (strong , nonatomic) IBOutlet UISlider *rhSlider; //锐化
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titleLabels;




@end

@implementation CustomGPUImageViewController
- (IBAction)switchAction:(UISwitch *)sender {
    //打开状态
    if (sender.on) {
        self.mpSlider.hidden = NO;
        self.mbSlider.hidden = NO;
        self.bgSlider.hidden = NO;
        self.dbdSlider.hidden = NO;
        self.bhdSlider.hidden = NO;
        self.rhSlider.hidden = NO;
        
        for (int i = 0 ; i < self.titleLabels.count; i++ ) {
            UILabel * label = [UILabel new];
            label = self.titleLabels[i];
            label.hidden = NO;
        }
    }else{
        self.mpSlider.hidden = YES;
        self.mbSlider.hidden = YES;
        self.bgSlider.hidden = YES;
        self.dbdSlider.hidden = YES;
        self.bhdSlider.hidden = YES;
        self.rhSlider.hidden = YES;
        for (int i = 0 ; i < self.titleLabels.count; i++ ) {
            UILabel * label = [UILabel new];
            label = self.titleLabels[i];
            label.hidden = YES    ;
        }
    }
}
//磨皮
- (IBAction)bilateralFilter:(UISlider *)sender {
    
    // 值越小，磨皮效果越好
    CGFloat maxValue = 10;
    [_bilateralFilter setDistanceNormalizationFactor:(maxValue - sender.value)];
}



//美白
- (IBAction)brightnessFilter:(UISlider *)sender {
    _brightnessFilter.brightness = sender.value;
    
}

//普光
- (IBAction)puguang:(UISlider *)sender {
    _exposureFilter.exposure = sender.value;
}

//对比度
- (IBAction)contrastFilter:(UISlider *)sender {
    _contrastFilter.contrast = sender.value;
}

//饱和度
- (IBAction)saturationFilter:(UISlider *)sender {
    _saturationFilter.saturation = sender.value;
}

//锐化
- (IBAction)sharpenFilter:(UISlider *)sender {
    _sharpenFilter.sharpness = sender.value;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视频源
    GPUImageVideoCamera * camera = [[GPUImageVideoCamera alloc]initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _camera = camera;
    
    //创建最终预览View
    GPUImageView * videoPreView = [[GPUImageView alloc]initWithFrame:self.view.bounds];
    [self.view insertSubview:videoPreView atIndex:0];
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup * group = [[GPUImageFilterGroup alloc]init];
    
    //磨皮滤镜
    GPUImageBilateralFilter * bilateralFilter = [[GPUImageBilateralFilter alloc]init];
    _bilateralFilter = bilateralFilter;
    
    [group addTarget:bilateralFilter];
    
    
    //美白滤镜
    GPUImageBrightnessFilter * brightnessFilter = [[GPUImageBrightnessFilter alloc]init];
    _brightnessFilter = brightnessFilter;
    [group addTarget:brightnessFilter];
    
    //锐化
    GPUImageSharpenFilter * sharpenFilter = [[GPUImageSharpenFilter alloc]init];
    _sharpenFilter = sharpenFilter;
    [group addTarget:sharpenFilter];
    
    // 曝光
    GPUImageExposureFilter * exposureFilter = [[GPUImageExposureFilter alloc]init];
    _exposureFilter = exposureFilter;
    [group addTarget:exposureFilter];
    
    //对比度
    GPUImageContrastFilter * contrastFilter = [[GPUImageContrastFilter alloc]init];
    _contrastFilter = contrastFilter;
    [group addTarget:contrastFilter];
    
    //饱和度
    GPUImageSaturationFilter * saturationFilter = [[GPUImageSaturationFilter alloc]init];
    _saturationFilter = saturationFilter;
    [group addTarget:saturationFilter];
    
    
    //设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [brightnessFilter addTarget:sharpenFilter];
    [sharpenFilter addTarget:exposureFilter];
    [exposureFilter addTarget:contrastFilter];
    [contrastFilter addTarget:saturationFilter];
    [group setInitialFilters:@[bilateralFilter]];
    group.terminalFilter = saturationFilter;
    
    
    //设置GPUImgae处理了链,从数据源 -> 滤镜 -> 最终界面效果
    [camera addTarget:group];
    [group addTarget:videoPreView];
    
    
    //开始采集视频
    [camera startCameraCapture];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
