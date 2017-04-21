//
//  CustomFirstGPUImageFilterViewController.m
//  WjqGUImageDemo
//
//  Created by landixing on 2017/3/24.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "CustomFirstGPUImageFilterViewController.h"
//#import "CustomFirstGPUImageFilter.h"
#import "GPUImageBeautifyFilter.h"


@interface CustomFirstGPUImageFilterViewController ()

@property (strong , nonatomic) GPUImageVideoCamera * camera;
@property (strong , nonatomic) GPUImageView * videoPreImageView;



@end

@implementation CustomFirstGPUImageFilterViewController
- (IBAction)openSwitch:(UISwitch *)sender {
    
    //切换美颜效果
    if (sender.on) {
        // 移除之前所有处理链
        [_camera removeAllTargets];
        
        // 创建自定义美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        
        // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
        [_camera addTarget:beautifyFilter];
        [beautifyFilter addTarget:_videoPreImageView];
     
    }else{
        [_camera removeAllTargets];
        [_camera addTarget:_videoPreImageView];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh会自适应高分辨率
    // cameraPosition:摄像头方向
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _camera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    _videoPreImageView = captureVideoPreview;
    
    // 设置处理链
    [_camera addTarget:_videoPreImageView];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [videoCamera startCameraCapture];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
