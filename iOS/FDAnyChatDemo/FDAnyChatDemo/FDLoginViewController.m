//
//  FDLoginViewController.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/14.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDLoginViewController.h"
#import "SVProgressHUD.h"
#import "FDUserModel.h"
#import "FDUserModelTool.h"
#import "FDVideoViewController.h"


#define kAnyChatRoomID 1
#define kUserID 1001
#define kAnyChatIP @"demo.anychat.cn"
#define kAnyChatPort @"8906"
#define kAnyChatUserName @"AnyChat"

@interface FDLoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *ServerIPTextField;
@property (weak, nonatomic) IBOutlet UITextField *UserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ServerPortTextField;

@property (nonatomic, strong) FDVideoViewController *videoVC;

@property (nonatomic, strong) FDUserModel *userModel;


@end




@implementation FDLoginViewController


- (FDUserModel *)userModel {
    if (_userModel == nil) {
        _userModel = [[FDUserModel alloc] init];
    }
    return _userModel;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.UserNameTextField.text = kAnyChatUserName;
    self.ServerPortTextField.text = kAnyChatPort;
    self.ServerIPTextField.text = kAnyChatIP;
    
    FDUserModel *userModel = [FDUserModelTool userModel];

    if (userModel) {
        self.UserNameTextField.text = self.userModel.userName;
        self.ServerPortTextField.text = self.userModel.chatPort;
        self.ServerIPTextField.text = self.userModel.chatIp;
    }
    
    
}



#pragma mark - Instance IBAction
- (IBAction)loginBtnClick:(id)sender {

    if (self.ServerPortTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"端口号不能为空"];
        return;
    }
    if (self.ServerIPTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"IP地址不能为空"];
        return;
    }
    
    if (self.UserNameTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }

    self.userModel.userName = self.UserNameTextField.text;
    self.userModel.chatPort = self.ServerPortTextField.text;
    self.userModel.chatIp = self.ServerIPTextField.text;
    [FDUserModelTool saveUserModel:self.userModel];
    
    
    
    [self hideKeyBoard];
    
    self.videoVC = [FDVideoViewController new];
    _videoVC.userModel = self.userModel;
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:self.videoVC animated:YES];

}


- (void)hideKeyBoard {
    [self.UserNameTextField resignFirstResponder];
    [self.ServerPortTextField resignFirstResponder];
    [self.ServerIPTextField resignFirstResponder];
}



#pragma mark setting
- (void) updateUserVideoSettings
{
    //read user data
    NSMutableDictionary *theMDict;// = [self readPListToMDictionaryAtSandboxPList:@"UserVideoSettings.plist"];
    
    BOOL bUseP2P = [[self getValuesFromMDict:theMDict
                               firstMDictKey:@"usep2p"
                             secondValuesKey:@"Values"] boolValue];
    BOOL bUseServerVideoParam = [[self getValuesFromMDict:theMDict
                                            firstMDictKey:@"useserverparam"
                                          secondValuesKey:@"Values"] boolValue];
    int iVideoSolution = [[self getValuesFromMDict:theMDict
                                     firstMDictKey:@"videosolution"
                                   secondValuesKey:@"Values"] intValue];
    int iVideoBitrate = [[self getValuesFromMDict:theMDict
                                    firstMDictKey:@"videobitrate"
                                  secondValuesKey:@"Values"] intValue];
    int iVideoFrameRate = [[self getValuesFromMDict:theMDict
                                      firstMDictKey:@"videoframerate"
                                    secondValuesKey:@"Values"] intValue];
    int iVideoPreset = [[self getValuesFromMDict:theMDict
                                   firstMDictKey:@"videopreset"
                                 secondValuesKey:@"Values"] intValue];
    int iVideoQuality = [[self getValuesFromMDict:theMDict
                                    firstMDictKey:@"videoquality"
                                  secondValuesKey:@"Values"] intValue];
    
    // P2P
    [AnyChatPlatform SetSDKOptionInt:BRAC_SO_NETWORK_P2PPOLITIC : (bUseP2P ? 1 : 0)];
    
    if(bUseServerVideoParam)
    {
        // 屏蔽本地参数，采用服务器视频参数设置
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_APPLYPARAM :0];
    }
    else
    {
        int iWidth, iHeight;
        switch (iVideoSolution) {
            case 0:     iWidth = 1280;  iHeight = 720;  break;
            case 1:     iWidth = 640;   iHeight = 480;  break;
            case 2:     iWidth = 480;   iHeight = 360;  break;
            case 3:     iWidth = 352;   iHeight = 288;  break;
            case 4:     iWidth = 192;   iHeight = 144;  break;
            default:    iWidth = 352;   iHeight = 288;  break;
        }
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_WIDTHCTRL :iWidth];
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_HEIGHTCTRL :iHeight];
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_BITRATECTRL :iVideoBitrate];
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_FPSCTRL :iVideoFrameRate];
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_PRESETCTRL :iVideoPreset];
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_QUALITYCTRL :iVideoQuality];
        
        // 采用本地视频参数设置，使参数设置生效
        [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_APPLYPARAM :1];
    }
}


- (id)getValuesFromMDict:(NSMutableDictionary *)mainMDict firstMDictKey:(NSString *)firstKey secondValuesKey:(NSString *)secondKey
{
    NSMutableDictionary *theMDict = [mainMDict objectForKey:firstKey];
    NSNumber *theValues = [theMDict objectForKey:secondKey];
    
    return theValues;
}


@end
