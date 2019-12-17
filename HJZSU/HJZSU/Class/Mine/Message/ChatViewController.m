//
//  ChatViewController.m
//  HJZSU
//
//  Created by pro1 on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<EaseMessageViewControllerDataSource,EaseMessageViewControllerDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = self;
    self.delegate = self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage qmui_imageWithColor:UIColorMake(255, 80, 0)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 25,25);
    UIImage *img = [[UIImage imageNamed:@"返回-白色"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftBtn setImage:img forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]}; // title颜色
}

- (void)leftBarBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (UITableViewCell *)messageViewController:(UITableView *)tableView
                       cellForMessageModel:(id<IMessageModel>)messageModel{
    EaseBaseMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[EaseBaseMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell" model:messageModel];
        cell.hasRead.hidden = YES;
        cell.messageNameIsHidden = YES;
        cell.model = messageModel;
    }
    return cell;
}

- (void)sendMessage:(EMMessage *)message isNeedUploadFile:(BOOL)isUploadFile{
    message.ext = [EMUserInfo currentUserInfo];
    __weak typeof(self) weakself = self;
    [self addMessageToDataSource:message progress:nil];
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        [weakself.dataSource messageViewController:weakself updateProgress:progress messageModel:nil messageBody:message.body];
    } completion:^(EMMessage *message, EMError *error) {
        [weakself.tableView reloadData];
    }];
}

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController modelForMessage:(EMMessage *)message{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    if (model.isSender) {//自己发送
        //头像
        model.avatarURLPath = [EMUserInfo current_heading_user];
        //昵称
        model.nickname = [EMUserInfo current_name_user];
        model.avatarImage = UIImageMake(@"Logo");
    }else{//对方发送
        //头像
        model.avatarURLPath = message.ext[@"from_heading_user"];
        //昵称
        model.nickname = self.toUserName;
        model.avatarImage = UIImageMake(@"Logo");
    }
    return model;
}
- (BOOL)messageViewControllerShouldMarkMessagesAsRead:(EaseMessageViewController *)viewController{
    return NO;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
shouldSendHasReadAckForMessage:(EMMessage *)message
                         read:(BOOL)read{
    return NO;
}

@end
