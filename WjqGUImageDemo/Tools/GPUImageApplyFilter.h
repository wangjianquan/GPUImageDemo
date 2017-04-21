//
//  GPUImageApplyFilter.h
//  WjqGUImageDemo
//
//  Created by landixing on 2017/4/5.
//  Copyright © 2017年 landixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPUImageApplyFilter : NSObject
+ (instancetype)shareApplyFliter;

//素描
- (void)initWithSketchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//朦胧加暗
- (void)initWithHazeFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//阀值素描，形成有噪点的素描
- (void)initWithThresholdSketchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

// 卡通效果（黑色粗线描边）
- (void)initWithToonFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//    相比上面的效果更细腻，上面是粗旷的画风
- (void)initWithSmoothToonFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用
- (void)initWithkuwaharaFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//相片底片
- (void)initWithInvertFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;
    

//同心圆像素化
- (void)initWithPolarPixellateFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//交叉线阴影，形成黑白网状画面
- (void)initWithCrosshatchFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//色彩丢失，模糊（类似监控摄像黑白效果）
- (void)initWithColorPackingFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//晕影，形成黑色圆形边缘，突出中间图像的效果
- (void)initWithVignetteFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//漩涡，中间形成卷曲的画面
- (void)initWithSwirlFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//凸起失真，鱼眼效果
- (void)initWithBulgeDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//收缩失真，凹面镜
- (void)initWithPinchDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//伸展失真，哈哈镜
- (void)initWithStretchDistortionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//水晶球效果
- (void)initWithGlassSphereFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//球形折射，图形倒立
- (void)initWithSphereRefractionFilter :(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


//色调分离，形成噪点效果
- (void)initWithPosterizeFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
- (void)initWithCGAColorspaceFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//柏林噪点，花边噪点
- (void)initWithPerlinNoiseFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//3x3卷积，高亮大色块变黑，加亮边
- (void)initWith3x3ConvolutionFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;



//亮度阈
- (void)initWithLuminanceThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//自适应阈值
- (void)initWithAdaptiveThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

// 曝光
- (void)initWithExposureFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;


- (void)initWithContrastFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//怀旧
- (void)initWithSepiaFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//色阶
- (void)initWithLevelsFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//灰度
- (void)initWithGrayscaleFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//RGB
- (void)initWithRGBFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//色调曲线
- (void)initWithToneCurveFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

////提亮阴影
- (void)initWithHighlightShadowFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//像素色值亮度平均，图像黑白（有类似漫画效果）
- (void)initWithAverageLuminanceThresholdFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;
//锐化
- (void)initWithSharpenFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//十字
- (void)initWithCrosshairGenerator:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//线条
- (void)initWithLineGenerator:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//高斯模糊
- (void)initWithGaussianBlurFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

//高斯模糊
- (void)initWithBoxBlurFilter:(GPUImageVideoCamera *)camera imageView:(GPUImageView * )videoPreView;

@end
