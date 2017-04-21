//
//  GPUImageBeautifyFilter.h
//  BeautifyFaceDemo
//
//  Created by guikz on 16/4/28.
//  Copyright © 2016年 guikz. All rights reserved.
// 自定义样式

#import <GPUImage/GPUImage.h>

@class GPUImageCombinationFilter;

//GPUImageFilterGroup是多个filter的集合，terminalFilter为最终的filter，initialFilters为filter数组。GPUImageFilterGroup本身不绘制图像，对GPUImageFilterGroup添加删除Target操作的操作都会转为terminalFilter的操作。

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;//边缘检测算法
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@end
























