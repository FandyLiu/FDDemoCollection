//
//  FDVideoViewController.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/19.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"
#import "FDAlertViewTool.h"

@interface FDVideoViewController ()<AnyChatNotifyMessageDelegate, AnyChatTextMsgDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) AnyChatPlatform *anyChat;
@property (nonatomic, strong) NSMutableArray *onLineUserList;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UIView *localVideoView;
@property (strong, nonatomic) IBOutlet UIImageView *remoteVideoView;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *localVideoSurface;

// test
@property (nonatomic, weak) UITextField *roomTextField;
@property (nonatomic, weak) UITextField *remoteIDTextField;
@property (nonatomic, weak) UIButton *button;

@end

@implementation FDVideoViewController

#pragma mark 懒加载

- (NSMutableArray *)onLineUserList {
    if (_onLineUserList == nil) {
        _onLineUserList = [NSMutableArray array];
    }
    return _onLineUserList;
}

- (AnyChatPlatform *)anyChat {
    if (_anyChat == nil) {
        _anyChat = [AnyChatPlatform getInstance];
    }
    return _anyChat;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAnyChat];
    [self setupUI];
    
    
    [self setupTestUI];
    
    

}
#pragma mark test



- (void)setupTestUI {
    UITextField *roomTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 200, 40)];
    roomTextField.keyboardType = UIKeyboardTypeNumberPad;
    roomTextField.placeholder = @"请输入房间号";
    [self.view addSubview:roomTextField];
    
    
    UITextField *remoteIDTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 200, 40)];
    remoteIDTextField.placeholder = @"请输入客服ID";
    [self.view addSubview:remoteIDTextField];
    
    self.roomTextField = roomTextField;
    self.remoteIDTextField = remoteIDTextField;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, 250, 200, 40)];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
}

- (void)buttonClick {
    NSMutableArray* cameraDeviceArray = [AnyChatPlatform EnumVideoCapture];
    if (cameraDeviceArray.count > 0)
    {
        [AnyChatPlatform SelectVideoCapture:[cameraDeviceArray objectAtIndex:1]];
    }
    // open local video
    [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_OVERLAY :1];
    
    [AnyChatPlatform UserCameraControl:-1 : YES];
    if (self.roomTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"房间号不能为空"];
        return;
    }
    
    if (self.remoteIDTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"客服ID不能为空"];
        return;
    }
    self.userModel.roomId = self.roomTextField.text;
    self.userModel.remoteUserId = self.remoteIDTextField.text.intValue;
    
    [self.roomTextField resignFirstResponder];
    [self.remoteIDTextField resignFirstResponder];
    
    self.roomTextField.hidden = YES;
    self.remoteIDTextField.hidden = YES;
    self.button.hidden = YES;
    
    [self anyChatBegin];
    
}



#pragma mark 加载数据请求房间号和客服id
// 获取远程数据完成回掉
- (void)anyChatBegin {
    [AnyChatPlatform Connect:self.userModel.chatIp : [self.userModel.chatPort intValue]];
    [AnyChatPlatform Login:self.userModel.userName :nil];
}


#pragma mark - instance methord

#pragma mark 初始化
- (void)setupAnyChat {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(anyChatNotifyHandler:) name:@"ANYCHATNOTIFY" object:nil];
    
    // 初始化SDK
    [AnyChatPlatform InitSDK:0];
    
    
    self.anyChat.notifyMsgDelegate = self;
    self.anyChat.textMsgDelegate = self;
    
}


- (void)setupUI {
    self.nameLabel.text = @"E+账户面签专员";
    self.stateLabel.text = @"正在为您接通...";
    
    self.remoteVideoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.remoteVideoView.layer.borderWidth = 1.0f;
    self.remoteVideoView.layer.cornerRadius = 4;
    self.remoteVideoView.layer.masksToBounds = YES;
    self.remoteVideoView.hidden = YES;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)updateUI {
    self.remoteVideoView.hidden = NO;
    self.stateLabel.text = @"通话中...";
}


#pragma mark 事件
- (void)anyChatNotifyHandler:(NSNotification*)notify
{
    NSLog(@"%@",notify);
    NSDictionary* dict = notify.userInfo;
    [self.anyChat OnRecvAnyChatNotify:dict];
}



- (IBAction)endButtonClick:(id)sender {
    UIActionSheet *isFinish = [[UIActionSheet alloc]
                               initWithTitle:@"确定结束会话?"
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:@"确定",@"取消", nil];
    isFinish.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [isFinish showInView:self.view];
}

#pragma mark - AnyChatDelegate

#pragma mark AnyChatNotifyMessageDelegate

// 连接服务器消息
- (void) OnAnyChatConnect:(BOOL) bSuccess
{
    if (bSuccess)
    {
        [SVProgressHUD showSuccessWithStatus:@"链接成功"];
    }else {
        
        [SVProgressHUD showSuccessWithStatus:@"链接失败"];
    }
}

// 用户登陆消息
- (void) OnAnyChatLogin:(int) dwUserId : (int) dwErrorCode
{
    if(dwErrorCode == GV_ERR_SUCCESS)
    {
        [SVProgressHUD showSuccessWithStatus:@"登入成功"];
        
        self.userModel.localUserId = dwUserId;
        
        [AnyChatPlatform EnterRoom:(int)[self.userModel.roomId integerValue] :@""];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"登入失败"];
    }
    
}

// 用户进入房间消息
- (void) OnAnyChatEnterRoom:(int) dwRoomId : (int) dwErrorCode
{
    if (dwErrorCode != 0) {
        [SVProgressHUD showSuccessWithStatus:@"进入房间失败"];
    }else {
        // 进入房间成功
        [SVProgressHUD showSuccessWithStatus:@"进入房间成功"];
        [self updateUI];
        [self startVideoChat:self.userModel.remoteUserId];
    }
}

// 房间在线用户消息
- (void)OnAnyChatOnlineUser:(int) dwUserNum : (int) dwRoomId
{
    self.onLineUserList = [AnyChatPlatform GetOnlineUser];
}

// 有用户进入房间消息
- (void)OnAnyChatUserEnterRoom:(int) dwUserId
{
    self.onLineUserList = [AnyChatPlatform GetOnlineUser];
}

// 用户退出房间消息
- (void)OnAnyChatUserLeaveRoom:(int) dwUserId
{
    if (self.userModel.remoteUserId == dwUserId) {
        [self finishVideoChat];
        

        NSString *name = [AnyChatPlatform GetUserName:dwUserId];
        
        NSString *theLeaveRoomName = [[NSString alloc] initWithFormat:@"\"%@\"已离开房间!",name];
        UIAlertView *leaveRoomAlertView = [[UIAlertView alloc] initWithTitle:theLeaveRoomName
                                                                     message:@"The remote user Leave Room."
                                                                    delegate:self
                                                           cancelButtonTitle:nil
                                                           otherButtonTitles:@"确定",nil];
        [leaveRoomAlertView show];
        self.userModel.remoteUserId = -1;
    }
    self.onLineUserList = [AnyChatPlatform GetOnlineUser];
    
}

// 网络断开消息
- (void) OnAnyChatLinkClose:(int) dwErrorCode {
    [self finishVideoChat];
    
    [self.onLineUserList removeAllObjects];
    [SVProgressHUD showSuccessWithStatus:@"网络断开"];
}

#pragma mark AnyChatTextMsgDelegate

- (void)OnAnyChatTextMsgCallBack:(int)dwFromUserid :(int)dwToUserid :(BOOL)bSecret :(NSString *)lpMsgBuf {
    [FDAlertViewTool showAlertBottomViewWithTitle:@"2222" content:lpMsgBuf];
}


#pragma mark - 本地摄像头图像处理

- (void) OnLocalVideoRelease:(id)sender
{
    if(self.localVideoSurface) {
        self.localVideoSurface = nil;
    }
}

- (void) OnLocalVideoInit:(id)session
{
    self.localVideoSurface = [AVCaptureVideoPreviewLayer layerWithSession: (AVCaptureSession*)session];
    self.localVideoSurface.frame = CGRectMake(0, 0, self.localVideoView.frame.size.width, self.localVideoView.frame.size.height);
    self.localVideoSurface.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.localVideoView.layer addSublayer:self.localVideoSurface];
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self finishVideoChat];
    }
}


#pragma mark - AnyChat开始和完成退出
- (void)startVideoChat:(int)userId {
    //Get a camera, Must be in the real machine.
    NSMutableArray* cameraDeviceArray = [AnyChatPlatform EnumVideoCapture];
    if (cameraDeviceArray.count > 0)
    {
        [AnyChatPlatform SelectVideoCapture:[cameraDeviceArray objectAtIndex:1]];
    }
    // open local video
    [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_OVERLAY :1];
    [AnyChatPlatform UserSpeakControl: -1:YES];
    [AnyChatPlatform SetVideoPos:-1 :self :0 :0 :0 :0];
    [AnyChatPlatform UserCameraControl:-1 : YES];
    // request other user video
    [AnyChatPlatform UserSpeakControl:userId :YES];
    [AnyChatPlatform SetVideoPos:userId :self.remoteVideoView :0:0:0:0];
    [AnyChatPlatform UserCameraControl:userId : YES];
    
    //远程视频显示时随设备的方向改变而旋转（参数为int型， 0表示关闭， 1 开启[默认]，视频旋转时需要参考本地视频设备方向参数）
    [AnyChatPlatform SetSDKOptionInt:BRAC_SO_LOCALVIDEO_ORIENTATION : self.interfaceOrientation];
}



- (void)finishVideoChat {
    // 关闭摄像头
    [AnyChatPlatform UserSpeakControl: -1 : NO];
    [AnyChatPlatform UserCameraControl: -1 : NO];
    
    [AnyChatPlatform UserSpeakControl: self.userModel.remoteUserId : NO];
    [AnyChatPlatform UserCameraControl: self.userModel.remoteUserId : NO];
    
    self.userModel.remoteUserId = -1;
    [self logout];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)logout {
    [AnyChatPlatform LeaveRoom:-1];
    [AnyChatPlatform Logout];
}


@end
