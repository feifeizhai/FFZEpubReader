//
//  JingGeTransitionTypeConfig.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#ifndef JingGeTransitionTypeConfig_h
#define JingGeTransitionTypeConfig_h

// ************** Enum **************
typedef NS_ENUM(NSInteger,JingGeTransitionAnimationType){
    //----------- 系统 ------------
    JingGeTransitionAnimationTypeSysFade = 1,                   //淡入淡出
    
    JingGeTransitionAnimationTypeSysPushFromRight,
    JingGeTransitionAnimationTypeSysPushFromLeft,
    JingGeTransitionAnimationTypeSysPushFromTop,
    JingGeTransitionAnimationTypeSysPushFromBottom,//Push
    
    JingGeTransitionAnimationTypeSysRevealFromRight,
    JingGeTransitionAnimationTypeSysRevealFromLeft,
    JingGeTransitionAnimationTypeSysRevealFromTop,
    JingGeTransitionAnimationTypeSysRevealFromBottom,//揭开
    
    JingGeTransitionAnimationTypeSysMoveInFromRight,
    JingGeTransitionAnimationTypeSysMoveInFromLeft,
    JingGeTransitionAnimationTypeSysMoveInFromTop,
    JingGeTransitionAnimationTypeSysMoveInFromBottom,//覆盖
    
    JingGeTransitionAnimationTypeSysCubeFromRight,
    JingGeTransitionAnimationTypeSysCubeFromLeft,
    JingGeTransitionAnimationTypeSysCubeFromTop,
    JingGeTransitionAnimationTypeSysCubeFromBottom,//立方体
    
    JingGeTransitionAnimationTypeSysSuckEffect,                 //吮吸
    
    JingGeTransitionAnimationTypeSysOglFlipFromRight,
    JingGeTransitionAnimationTypeSysOglFlipFromLeft,
    JingGeTransitionAnimationTypeSysOglFlipFromTop,
    JingGeTransitionAnimationTypeSysOglFlipFromBottom, //翻转
    
    JingGeTransitionAnimationTypeSysRippleEffect,               //波纹
    
    JingGeTransitionAnimationTypeSysPageCurlFromRight,
    JingGeTransitionAnimationTypeSysPageCurlFromLeft,
    JingGeTransitionAnimationTypeSysPageCurlFromTop,
    JingGeTransitionAnimationTypeSysPageCurlFromBottom,//翻页
    
    JingGeTransitionAnimationTypeSysPageUnCurlFromRight,
    JingGeTransitionAnimationTypeSysPageUnCurlFromLeft,
    JingGeTransitionAnimationTypeSysPageUnCurlFromTop,
    JingGeTransitionAnimationTypeSysPageUnCurlFromBottom,//反翻页
    
    JingGeTransitionAnimationTypeSysCameraIrisHollowOpen,       //开镜头
    
    JingGeTransitionAnimationTypeSysCameraIrisHollowClose,      //关镜头
    
    //----------- 自定义 ------------
    JingGeTransitionAnimationTypeDefault,
    
    JingGeTransitionAnimationTypePageTransition,
    
    JingGeTransitionAnimationTypeViewMoveToNextVC,
    JingGeTransitionAnimationTypeViewMoveNormalToNextVC,
    
    JingGeTransitionAnimationTypeCover,
    
    JingGeTransitionAnimationTypeSpreadFromRight,
    JingGeTransitionAnimationTypeSpreadFromLeft,
    JingGeTransitionAnimationTypeSpreadFromTop,
    JingGeTransitionAnimationTypeSpreadFromBottom,
    JingGeTransitionAnimationTypePointSpreadPresent,
    
    JingGeTransitionAnimationTypeBoom,
    
    JingGeTransitionAnimationTypeBrickOpenVertical,
    JingGeTransitionAnimationTypeBrickOpenHorizontal,
    JingGeTransitionAnimationTypeBrickCloseVertical,
    JingGeTransitionAnimationTypeBrickCloseHorizontal,
    
    JingGeTransitionAnimationTypeInsideThenPush,
    
    JingGeTransitionAnimationTypeFragmentShowFromRight,
    JingGeTransitionAnimationTypeFragmentShowFromLeft,
    JingGeTransitionAnimationTypeFragmentShowFromTop,
    JingGeTransitionAnimationTypeFragmentShowFromBottom,
    
    JingGeTransitionAnimationTypeFragmentHideFromRight,
    JingGeTransitionAnimationTypeFragmentHideFromLeft,
    JingGeTransitionAnimationTypeFragmentHideFromTop,
    JingGeTransitionAnimationTypeFragmentHideFromBottom,
    
};

typedef NS_ENUM(NSInteger,JingGeTransitionType){
    
    JingGeTransitionTypePop,
    JingGeTransitionTypePush,
    JingGeTransitionTypePresent,
    JingGeTransitionTypeDismiss,
};


typedef NS_ENUM(NSInteger,JingGeGestureType){
    
    JingGeGestureTypeNone,
    JingGeGestureTypePanLeft,
    JingGeGestureTypePanRight,
    JingGeGestureTypePanUp,
    JingGeGestureTypePanDown,
    
};
//系统动画类型
typedef NS_ENUM(NSInteger,JingGeTransitionSysAnimationType){
    
    JingGeTransitionSysAnimationTypeFade = 1,                   //淡入淡出
    JingGeTransitionSysAnimationTypePush,                       //推挤
    JingGeTransitionSysAnimationTypeReveal,                     //揭开
    JingGeTransitionSysAnimationTypeMoveIn,                     //覆盖
    JingGeTransitionSysAnimationTypeCube,                       //立方体
    JingGeTransitionSysAnimationTypeSuckEffect,                 //吮吸
    JingGeTransitionSysAnimationTypeOglFlip,                    //翻转
    JingGeTransitionSysAnimationTypeRippleEffect,               //波纹
    JingGeTransitionSysAnimationTypePageCurl,                   //翻页
    JingGeTransitionSysAnimationTypePageUnCurl,                 //反翻页
    JingGeTransitionSysAnimationTypeCameraIrisHollowOpen,       //开镜头
    JingGeTransitionSysAnimationTypeCameraIrisHollowClose,      //关镜头
    JingGeTransitionSysAnimationTypeCurlDown,                   //下翻页
    JingGeTransitionSysAnimationTypeCurlUp,                     //上翻页
    JingGeTransitionSysAnimationTypeFlipFromLeft,               //左翻转
    JingGeTransitionSysAnimationTypeFlipFromRight,              //右翻转
    
};

#endif /* JingGeTransitionTypeConfig_h */
