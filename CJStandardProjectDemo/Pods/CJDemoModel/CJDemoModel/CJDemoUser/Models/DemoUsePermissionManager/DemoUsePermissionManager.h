//
//  DemoUsePermissionManager.h
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
// 通过HPUser来获取permissionManager实例

#import <Foundation/Foundation.h>
#import "DemoUsePermissionModel.h"

@interface DemoUsePermissionManager : NSObject

typedef NS_ENUM(NSUInteger, HPPermissionID) {
    /**
     *  V1 permission
     */
    HPPermissionID_MyLesson                 = 81,//我的备课
    HPPermissionID_ScanningLogin            = 82,//扫描登陆
    HPPermissionID_Setup_ModifyPassword     = 83,//修改密码
    HPPermissionID_Setup_Notice             = 84,//消息通知
    HPPermissionID_Setup_VersionUpdate      = 85,//版本更新
    HPPermissionID_Mine                     = 86,//我的
    HPPermissionID_Found                    = 87,//发现
    HPPermissionID_Index_CourseManager      = 88,//课程管理
    HPPermissionID_Students_HomeworkManager = 89,//作业管理
    HPPermissionID_Index_NoticeManager      = 90,//通知管理
    HPPermissionID_Students_Performance     = 91,//日常表现
    HPPermissionID_Index_ScrollImage        = 92,//首页轮播图
    HPPermissionID_Notice_School            = 93,//学校通知
    HPPermissionID_Notice_leave             = 94,//请假通知
    HPPermissionID_Notice_appointment       = 95,//预约通知
    HPPermissionID_Notice_changecourse      = 96,//调课通知
    HPPermissionID_Notice_Other             = 97,//其它通知
    HPPermissionID_JXLX                     = 98,//家校联系
    HPPermissionID_Students_ScrollImage     = 99,//学生管理轮播图
    HPPermissionID_Students_Score           = 99,//成绩查询
    HPPermissionID_Students_Growup          = 99,//成长曲线
    HPPermissionID_StudentManage            = 99,//学生管理
    /**
     *  V2 permission
     */
    HPPermissionID_CourseAttendance                  = 100,//课堂点名
    HPPermissionID_CoursePerformance                 = 200,//课堂表现
//    HPPermissionID_PublishHomework                   = 300,//布置作业
    HPPermissionID_NoticeManager                     = 400,//通知管理
    HPPermissionID_NoticeManager_Class               = 401,//班级通知
    HPPermissionID_NoticeManager_School              = 402,//学校通知
    HPPermissionID_NoticeManager_All                 = 403,//通知汇总
    HPPermissionID_HomeworkManager                   = 500,//作业管理
    HPPermissionID_SchoolHomework                    = 501,//作业汇总
    HPPermissionID_PublishHomework                   = 502,//布置作业
    HPPermissionID_HistoryHomework                   = 503,//作业纪录
    HPPermissionID_AttendanceStat                    = 600,//考勤统计
    HPPermissionID_AttendanceStat_ClassStudent       = 601,//学生考勤
    HPPermissionID_AttendanceStat_AllStudent         = 603,//校学生考勤统计
    HPPermissionID_AttendanceStat_Class              = 604,//班级考勤统计
    HPPermissionID_AttendanceStat_StudentInOutSchool = 605,//学生出入校记录
    HPPermissionID_AttendanceStat_Teacher            = 602,//教师考勤
    HPPermissionID_FoundNews                         = 700,//发现
    HPPermissionID_FoundNews_School                  = 701,//校园动态
    HPPermissionID_FoundNews_Edu                     = 702,//教育资讯
    HPPermissionID_ClassInfo                         = 800,//班级信息
    HPPermissionID_CourseSchedule                    = 900,//课程表
    HPPermissionID_CourseSchedule_My                 = 901,//我的课表
    HPPermissionID_CourseSchedule_Class              = 902,//班级课表
    HPPermissionID_CourseSchedule_Teacher            = 903,//教师课表
    HPPermissionID_MessageCenter                     = 1000,//消息中心
    HPPermissionID_MessageCenter_School              = 1001,//学校通知
    HPPermissionID_MessageCenter_System              = 1002,//系统通知
    HPPermissionID_AssessmentLibrary                 = 1100,//评语库
    HPPermissionID_AssessmentLibrary_My              = 1101,//我的评语
    HPPermissionID_AssessmentLibrary_System          = 1102,//系统评语


    HPPermissionID_DeviceRepairs                     = 1200,//设备报修
    HPPermissionID_ApplyReaairs                      = 1201,//申请报修
    HPPermissionID_MyRepairs                         = 1202,//我的报修
    HPPermissionID_DealWithRepairs                   = 1203,//报修处理
    HPPermissionID_RepairsRecord                     = 1204,//报修记录
    HPPermissionID_SchoolCalendar                    = 1300,//校历
    HPPermissionID_ScoreInquiry                      = 1400,//成绩管理
    HPPermissionID_AddressBook                       = 1500,//通讯录
    HPPermissionID_MySchedule                        = 1600,//日程表
    HPPermissionID_ApplicationStatistics             = 1700,//应用统计
    HPPermissionID_AppointmentManager                = 1800,//预约管理
    HPPermissionID_OA                                = 1900,//OA模块
    HPPermissionID_MyLeave                           = 1901,//我的请假
    HPPermissionID_LeaveApprove                      = 1902,//请假审批
    HPPermissionID_DutyInspection                    = 1904,//值日巡检
    HPPermissionID_VisitorsSystem                    = 1905,//访客记录
    HPPermissionID_LeaveApprovePending               = 19021,//待审批请假
    HPPermissionID_TeacherLeaveList                  = 19022,//教师请假列表
    HPPermissionID_CourseArrangeList                 = 19023,//课程安排列表
    HPPermissionID_StudentLeaveManager               = 2000,//学生请假管理
    HPPermissionID_StudentLeaveApprovePending        = 2001,//学生请假待审批
    HPPermissionID_StudentLeaveList                  = 2002,//学生请假列表
    HPPermissionID_StudentFamilyPerformance          = 2100,//学生家庭表现
    HPPermissionID_LearningGuid                      = 2200,//课前导学
    HPPermissionID_IM                                = 400,//= 2300,//IM功能
    HPPermissionID_ClassPro                          = 403,//班牌公告
    HPPermissionID_ClassCluture                      = 4000,//班级文化
    HPPermissionID_ClassClutureEdit                  = 4001,//班牌文化编辑
    HPPermissionID_ClassArrayDuty                    = 4002,//安排值日生
    HPPermissionID_ClassSetSeat                      = 4003,//设置座位表
    HPPermissionID_ClassAddGreatEvent                = 4004,//发布大事记
    HPPermissionID_ClassAddHonour                    = 4005,//发布班级荣誉
    HPPermissionID_ClassAddPhotoAlbum                = 4006,//新建相册
    HPPermissionID_ClassUploadPhoto                  = 4007,//上传照片
};

- (instancetype)initWithPermissionList:(NSArray *)permissionList;
- (BOOL)hasPermissionWithPermissionID:(HPPermissionID)permissionID;

@end
