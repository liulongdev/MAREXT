//
//  MXRBookConfigInformationM.h
//  huashida_home
//
//  Created by Martin.Liu on 2018/8/9.
//  Copyright © 2018年 苏州梦想人软件科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MARModel.h"

@interface MXRModelPathCM : NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * path;
@end

//@interface MXRPreview_pageCM :NSObject
//@property (nonatomic , copy) NSString              * marker_id;
//
//@end
//
@interface MXREnvironmentCM :NSObject
@property (nonatomic , copy) NSString              * track_mode;
@property (nonatomic , copy) NSString              * splash_image;
@property (nonatomic , copy) NSString              * project_name;
@property (nonatomic , copy) NSString              * full_screen;
@property (nonatomic , copy) NSString              * continuous_scan;
@property (nonatomic , copy) NSString              * initinterface;
@property (nonatomic , copy) NSString              * template_id;
//@property (nonatomic , strong) MXRPreview_pageCM              * preview_page;
@property (nonatomic , copy) NSString              * book_mode;
@property (nonatomic , copy) NSString              * guid;
@property (nonatomic , copy) NSString              * is_full;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * resolution;

@end

@interface MXRRegionCM :NSObject
@property (nonatomic , copy) NSString              * y;
@property (nonatomic , copy) NSString              * w;
@property (nonatomic , copy) NSString              * x;
@property (nonatomic , copy) NSString              * h;

@end

@interface MXRMarkerCM : MXRModelPathCM <MARModelDelegate>
@property (nonatomic , strong) MXRRegionCM              * region;

@end

@interface MXRResourceCM :NSObject <MARModelDelegate>
@property (nonatomic , strong) NSArray<MXRMarkerCM *>   * markers;
@property (nonatomic , strong) NSArray<MXRModelPathCM *>* models;
@property (nonatomic , copy) NSString                   *customModels;
@property (nonatomic , strong) NSArray<MXRModelPathCM *>* images;
@property (nonatomic , copy) NSString                   * cloudPanoramas;
@property (nonatomic , copy) NSString                   * audios;
@property (nonatomic , copy) NSString                   * videos;
@property (nonatomic , copy) NSString                   * games;

@end

@interface MXRReadThroughCM :NSObject
@property (nonatomic , copy) NSString              * testpaper_count;
@property (nonatomic , copy) NSString              * pertain_chapter;
@property (nonatomic , copy) NSString              * chapter_id;
@property (nonatomic , copy) NSString              * next_chapter;
@property (nonatomic , copy) NSString              * chapter_type;
@property (nonatomic , copy) NSString              * whether_lock;
@property (nonatomic , copy) NSString              * unlock_score;
@property (nonatomic , copy) NSString              * audio_id;
@property (nonatomic , copy) NSString              * loop;
@property (nonatomic , copy) NSString              * play_end;
@property (nonatomic , copy) NSString              * play_begin;

@end

@interface MXRPageCM :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * page_index;
@property (nonatomic , copy) NSString              * marker_id;

@end

@interface MXRCourseCM :NSObject <MARModelDelegate>
@property (nonatomic , copy) NSString               * id;
@property (nonatomic , strong) MXRReadThroughCM     * read_through;
@property (nonatomic , strong) NSArray<MXRPageCM *> * pages;

@end


@interface MXRCoordinateCM : NSObject
@property (nonatomic , copy) NSString              * x;
@property (nonatomic , copy) NSString              * y;
@property (nonatomic , copy) NSString              * z;
@end


@interface MXRParameterCM : NSObject <MARModelDelegate>

@property (nonatomic , copy) NSString               * image_id;
@property (nonatomic , copy) NSString               * button_type;
@property (nonatomic , copy) NSString               * marker_id;
@property (nonatomic , strong) MXRCoordinateCM      * scale;
@property (nonatomic , strong) MXRCoordinateCM      * position;
@property (nonatomic , strong) MXRCoordinateCM      * rotation;

@end

@interface MXRActionCM : NSObject <MARModelDelegate>

@property (nonatomic , copy) NSString               * id;
@property (nonatomic , copy) NSString               * action_type;
@property (nonatomic , strong) MXRParameterCM       * parameters;

@end


@interface MXRGroupCM :NSObject <MARModelDelegate>
@property (nonatomic , copy) NSString                   * id;
@property (nonatomic , copy) NSString                   * next_group;
@property (nonatomic , copy) NSString                   * switch_type;
@property (nonatomic , copy) NSString                   * delay_time;
@property (nonatomic , strong) NSArray<MXRActionCM *>   * actions;

@end

@interface MXREventCM :NSObject <MARModelDelegate>
@property (nonatomic , copy) NSString                   * id;
@property (nonatomic , copy) NSString                   * res_id;
@property (nonatomic , strong) NSArray<MXRGroupCM *>    * groups;
@property (nonatomic , copy) NSString                   * event_type;

@end

//#define MXRBOOKCONFIGCLASS(className)   \
//@interface className : NSObject  \
//@end
//
//MXRBOOKCONFIGCLASS(MXREnvironmentCM)
//MXRBOOKCONFIGCLASS(MXRResourceCM)
//MXRBOOKCONFIGCLASS(MXRCourseCM)
//MXRBOOKCONFIGCLASS(MXREventCM)

@interface MXRBookConfigCM :NSObject <MARModelDelegate>
@property (nonatomic , strong) MXREnvironmentCM         * environment;
@property (nonatomic , strong) MXRResourceCM            * resource;
@property (nonatomic , strong) NSArray<MXRCourseCM *>   * courses;
@property (nonatomic , strong) NSArray<MXREventCM *>    * events;
@end



@interface MXRBookConfigInformationM : NSObject

@end


