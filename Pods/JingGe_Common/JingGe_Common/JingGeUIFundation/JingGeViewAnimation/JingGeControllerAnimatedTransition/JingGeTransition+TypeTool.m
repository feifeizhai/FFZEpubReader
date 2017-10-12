//
//  JingGeTransition+TypeTool.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition+TypeTool.h"

@implementation JingGeTransition (TypeTool)

-(void)backAnimationTypeFromAnimationType:(JingGeTransitionAnimationType)type{
    
    switch (type) {
        case JingGeTransitionAnimationTypeSysFade:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysFade;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPushFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPushFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPushFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPushFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysMoveInFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysMoveInFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysMoveInFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysMoveInFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysRevealFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysRevealFromRight;
            
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysRevealFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysRevealFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCubeFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCubeFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCubeFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCubeFromTop;
            
        }
            break;
        case JingGeTransitionAnimationTypeSysSuckEffect:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysSuckEffect;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysOglFlipFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysOglFlipFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysOglFlipFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysOglFlipFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysRippleEffect:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysRippleEffect;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageUnCurlFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageUnCurlFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageUnCurlFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageUnCurlFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromRight:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageCurlFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromLeft:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageCurlFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromTop:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageCurlFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromBottom:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysPageCurlFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysCameraIrisHollowOpen:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCameraIrisHollowClose;
        }
            break;
        case JingGeTransitionAnimationTypeSysCameraIrisHollowClose:{
            self.backAnimationType = JingGeTransitionAnimationTypeSysCameraIrisHollowOpen;
            
        }
            break;
        default:
            break;
    }
}

-(CATransition *)getSysTransitionWithType:(JingGeTransitionAnimationType )type{
    
    CATransition *tranAnimation=[CATransition animation];
    tranAnimation.duration= self.animationTime;
    tranAnimation.delegate = self;
    switch (type) {
        case JingGeTransitionAnimationTypeSysFade:{
            tranAnimation.type=kCATransitionFade;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromRight:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromLeft:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromTop:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysPushFromBottom:{
            tranAnimation.type = kCATransitionPush;
            tranAnimation.subtype=kCATransitionFromBottom;
            
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromRight:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromLeft:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromTop:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysRevealFromBottom:{
            tranAnimation.type = kCATransitionReveal;
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromRight:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromLeft:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromTop:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysMoveInFromBottom:{
            tranAnimation.type = kCATransitionMoveIn;
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromRight:{
            tranAnimation.type = @"cube";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromLeft:{
            tranAnimation.type = @"cube";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromTop:{
            tranAnimation.type=@"cube";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysCubeFromBottom:{
            tranAnimation.type=@"cube";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysSuckEffect:{
            tranAnimation.type=@"suckEffect";
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromRight:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromLeft:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromTop:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysOglFlipFromBottom:{
            tranAnimation.type=@"oglFlip";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysRippleEffect:{
            tranAnimation.type=@"rippleEffect";
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromRight:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromLeft:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromTop:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageCurlFromBottom:{
            tranAnimation.type=@"pageCurl";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromRight:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromLeft:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromTop:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case JingGeTransitionAnimationTypeSysPageUnCurlFromBottom:{
            tranAnimation.type=@"pageUnCurl";
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        case JingGeTransitionAnimationTypeSysCameraIrisHollowOpen:{
            tranAnimation.type=@"cameraIrisHollowOpen";
        }
            break;
        case JingGeTransitionAnimationTypeSysCameraIrisHollowClose:{
            tranAnimation.type=@"cameraIrisHollowClose";
        }
            break;
        default:
            break;
    }
    return tranAnimation;
}
@end
