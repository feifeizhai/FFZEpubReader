//
//  JingGeTransition+TypeTool.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 2017/4/25.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeTransition.h"

@interface JingGeTransition (TypeTool)<CAAnimationDelegate>
-(void)backAnimationTypeFromAnimationType:(JingGeTransitionAnimationType)type;
-(CATransition *)getSysTransitionWithType:(JingGeTransitionAnimationType )type;
@end
