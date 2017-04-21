//
//   GPUImageApplyFilter.m
//  WjqGUImageDemo
//
//   Created by landixing on 2017/4/5.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import "GPUImageApplyFilter.h"

@implementation GPUImageApplyFilter


+ (instancetype)shareApplyFliter{
    static GPUImageApplyFilter * applyFilter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        applyFilter = [[GPUImageApplyFilter alloc]init];
    });
    return applyFilter;
}
#pragma mark -- 素描
- (void)initWithSketchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    
    GPUImageSketchFilter * SketchFilter = [[GPUImageSketchFilter alloc]init];
    [camera addTarget:SketchFilter];
    [SketchFilter addTarget:videoPreView];
    
}

#pragma mark -- 朦胧加暗
- (void)initWithHazeFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    #pragma mark -- 3. 朦胧加暗
    GPUImageHazeFilter * hazeFilter = [[GPUImageHazeFilter alloc]init];
    hazeFilter.slope = -3;
    hazeFilter.distance = 0;
    
    #pragma mark -- 4. 设置处理链 数据源-> 滤镜 -> 最终界面效果
    [camera addTarget:hazeFilter];
    [hazeFilter addTarget:videoPreView];
    
}

#pragma mark -- 阀值素描，形成有噪点的素描
- (void)initWithThresholdSketchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageThresholdSketchFilter * ThresholdSketchFilter =[[ GPUImageThresholdSketchFilter alloc]init];
    [camera addTarget:ThresholdSketchFilter];
    [ThresholdSketchFilter addTarget:videoPreView];
}



#pragma mark --  卡通效果（黑色粗线描边）
- (void)initWithToonFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageToonFilter * toonFilter = [[GPUImageToonFilter alloc]init];
    toonFilter.threshold = 0.5;//应用边缘的阈值,默认为0.2
    toonFilter.quantizationLevels = 12;// 默认为10
    [camera addTarget:toonFilter];
    [toonFilter addTarget:videoPreView];
}

#pragma mark --     相比上面的效果更细腻，上面是粗旷的画风
- (void)initWithSmoothToonFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{

    GPUImageSmoothToonFilter *toonFilter = [[GPUImageSmoothToonFilter alloc]init];
    [camera addTarget:toonFilter];
    [toonFilter addTarget:videoPreView];
}

#pragma mark -- 桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用
- (void)initWithkuwaharaFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
        GPUImageKuwaharaFilter * KuwaharaFilter = [[GPUImageKuwaharaFilter alloc]init];
        [camera addTarget:KuwaharaFilter];
        [KuwaharaFilter addTarget:videoPreView];
}
#pragma mark -- 相片底片
- (void)initWithInvertFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageColorInvertFilter * invertFilter = [[GPUImageColorInvertFilter alloc]init];
    [camera addTarget:invertFilter];
    [invertFilter addTarget:videoPreView];
}

#pragma mark -- 同心圆像素化
- (void)initWithPolarPixellateFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImagePolarPixellateFilter * filter = [[GPUImagePolarPixellateFilter alloc]init];
    //default of (0.5, 0.5)
    filter.center = CGPointMake(0.5, 0.5);
   //  from (-2.0, -2.0) to (2.0, 2.0), with a default of (0.05, 0.05)
    filter.pixelSize = CGSizeMake(0.01, 0.01);
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 交叉线阴影，形成黑白网状画面
- (void)initWithCrosshatchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageCrosshatchFilter * filter = [[GPUImageCrosshatchFilter alloc]init];
    //filter.crossHatchSpacing = 0.01;#pragma mark -- The default is 0.03
    // filter.lineWidth = 0.1;#pragma mark -- The default is 0.003
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 色彩丢失，模糊（类似监控摄像黑白效果）
- (void)initWithColorPackingFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageColorPackingFilter * filter = [[GPUImageColorPackingFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 晕影，形成黑色圆形边缘，突出中间图像的效果
- (void)initWithVignetteFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageVignetteFilter * filtter = [[GPUImageVignetteFilter  alloc]init];
    //    filtter.vignetteCenter = CGPointMake(0.5, 0.5); Default of (0.5, 0.5)
   //  The normalized distance from the center where the vignette effect starts. Default of 0.5.
    // filtter.vignetteStart = 0.5;
    //  The normalized distance from the center where the vignette effect ends. Default of 0.75.
   // filtter.vignetteEnd = 0.6;
    [camera addTarget:filtter];
    [filtter addTarget:videoPreView];
}

#pragma mark -- 漩涡，中间形成卷曲的画面
- (void)initWithSwirlFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageSwirlFilter * filter = [[GPUImageSwirlFilter alloc]init];
    
    // The radius of the distortion, ranging from 0.0 to 1.0, with a default of 0.5
    filter.radius = 0.2 ;
    // The amount of distortion to apply, with a minimum of 0.0 and a default of 1.0
    filter. angle = 0.5;
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 凸起失真，鱼眼效果
- (void)initWithBulgeDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageBulgeDistortionFilter * filter = [[GPUImageBulgeDistortionFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
    
}

#pragma mark -- 收缩失真，凹面镜
- (void)initWithPinchDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImagePinchDistortionFilter * filter = [[GPUImagePinchDistortionFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 伸展失真，哈哈镜
- (void)initWithStretchDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageStretchDistortionFilter * filter = [[GPUImageStretchDistortionFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}
#pragma mark -- 水晶球效果
- (void)initWithGlassSphereFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageGlassSphereFilter * filter = [[GPUImageGlassSphereFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
    
}

#pragma mark -- 球形折射，图形倒立
- (void)initWithSphereRefractionFilter :(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    GPUImageSphereRefractionFilter * filter = [[GPUImageSphereRefractionFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 色调分离，形成噪点效果
- (void)initWithPosterizeFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView{
    
    GPUImagePosterizeFilter * filter = [[GPUImagePosterizeFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
- (void)initWithCGAColorspaceFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageCGAColorspaceFilter * filter = [[GPUImageCGAColorspaceFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 柏林噪点，花边噪点
- (void)initWithPerlinNoiseFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImagePerlinNoiseFilter * filter = [[GPUImagePerlinNoiseFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 3x3卷积，高亮大色块变黑，加亮边
- (void)initWith3x3ConvolutionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImage3x3ConvolutionFilter * filter = [[GPUImage3x3ConvolutionFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}





#pragma mark -- 亮度阈
- (void)initWithLuminanceThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageLuminanceThresholdFilter *filter = [[GPUImageLuminanceThresholdFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

 #pragma mark -- 自适应阈值
- (void)initWithAdaptiveThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageAdaptiveThresholdFilter *filter = [[GPUImageAdaptiveThresholdFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark --  曝光
- (void)initWithExposureFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageExposureFilter * filter = [[GPUImageExposureFilter alloc]init];
    filter.exposure = -1;
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

- (void)initWithContrastFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageContrastFilter * filter = [[GPUImageContrastFilter alloc]init];
#pragma mark --         filter.contrast = 4.0;
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 怀旧
- (void)initWithSepiaFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageSepiaFilter * filter  = [[GPUImageSepiaFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
   
}
#pragma mark -- 色阶
- (void)initWithLevelsFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageLevelsFilter * filter = [[GPUImageLevelsFilter alloc]init];
    [filter setRedMin:0.5 gamma:0.5 max:2.0];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 灰度
- (void)initWithGrayscaleFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageGrayscaleFilter * filter  = [[GPUImageGrayscaleFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
   
}

#pragma mark -- RGB
- (void)initWithRGBFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageRGBFilter * filter = [[GPUImageRGBFilter alloc]init];
    filter.red = 1.5;
    filter.blue = 0.1;
    filter.green = 1.0;
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
    
    
}

#pragma mark -- 色调曲线
- (void)initWithToneCurveFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageToneCurveFilter * filter = [[GPUImageToneCurveFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- #pragma mark -- 提亮阴影
- (void)initWithHighlightShadowFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
        GPUImageHighlightShadowFilter * filter = [[GPUImageHighlightShadowFilter alloc]init];
        // -- 0 - 1, increase to lighten shadows. @default 0
        filter.shadows = 1;
       // * 0 - 1, decrease to darken highlights. @default 1
        filter.highlights = 0;
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 像素色值亮度平均，图像黑白（有类似漫画效果）
- (void)initWithAverageLuminanceThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    GPUImageAverageLuminanceThresholdFilter * filter = [[GPUImageAverageLuminanceThresholdFilter alloc]init];
//    filter.thresholdMultiplier = 1.5;// 默认1.0
    
    [camera addTarget:filter];
    [filter addTarget:videoPreView];

}
#pragma mark -- 锐化
- (void)initWithSharpenFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc]init];
    // -4.0 to 4.0, with 0.0 as the normal level
    filter.sharpness = 1.5;

    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}

#pragma mark -- 十字
- (void)initWithCrosshairGenerator:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageCrosshairGenerator * filter = [[GPUImageCrosshairGenerator alloc]init];
//    [filter setCrosshairColorRed:0.5 green:1.0 blue:1.0];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
    
}

#pragma mark -- 线条
- (void)initWithLineGenerator:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageLineGenerator * filter= [[GPUImageLineGenerator alloc]init];
//    filter.lineWidth = 1.0;
    // [filter renderLinesFromArray:1 count:10.0 frameTime:2.0];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
   
}

#pragma mark -- 高斯模糊
- (void)initWithGaussianBlurFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageGaussianBlurFilter * filter = [[GPUImageGaussianBlurFilter alloc]init];
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}
#pragma mark -- 高斯模糊
- (void)initWithBoxBlurFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView
{
    
    GPUImageBoxBlurFilter * filter = [[GPUImageBoxBlurFilter alloc]init];
    
    [camera addTarget:filter];
    [filter addTarget:videoPreView];
}


























@end
