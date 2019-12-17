//
//  MessageListViewController.m
//  HJZSU
//
//  Created by pro1 on 2019/4/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MessageListViewController.h"
#import "ChatViewController.h"
#import "MessageViewController.h"

@interface MessageListViewController ()<EaseConversationListViewControllerDataSource,EaseConversationListViewControllerDelegate>

@property (strong,nonatomic) UIView *projectMessage;
@property (strong,nonatomic) UIImageView *headerImage;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UILabel *time;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNaviationView];
    self.dataSource = self;
    self.delegate = self;
    self.showRefreshHeader = YES;
    [self.tableView setTableHeaderView:self.projectMessage];
}

- (void)setupNaviationView{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"消息";
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
    [self tableViewDidTriggerHeaderRefresh];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [ProjectTool uploadUserMessageCount];
    
}

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation {
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat) {
        NSDictionary *dict = conversation.lastReceivedMessage.ext;
        if(IsNullString(dict[@"from_name_user"]) || IsNullString(dict[@"from_heading_user"])){
            NSDictionary *localDict = [EMUserInfo findUserInfoByUserId:conversation.conversationId];
            model.title = [localDict objectForKey:@"from_name_user"];
            model.avatarURLPath = [localDict objectForKey:@"from_heading_user"];
//            model.avatarImage = kPlaceholderImage;
            
        }else{
            model.title = dict[@"from_name_user"];
            model.avatarURLPath = dict[@"from_heading_user"];
            //头像占位图
//            model.avatarImage = kPlaceholderImage;
        }
    }
    return model;
}

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController didSelectConversationModel:(id<IConversationModel>)conversationModel{
    EMConversation *conversation = conversationModel.conversation;
    if (conversation) {
//        [[EMClient sharedClient] ]
//        [self messagev]
        
        EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
        if (model.conversation.type == EMConversationTypeChat) {
            NSDictionary *dict = conversation.lastReceivedMessage.ext;
            if(IsNullString(dict[@"from_name_user"]) || IsNullString(dict[@"from_heading_user"])){
                NSDictionary *localDict = [EMUserInfo findUserInfoByUserId:conversation.conversationId];
                model.title = [localDict objectForKey:@"from_name_user"];
                model.avatarURLPath = [localDict objectForKey:@"from_heading_user"];
                //            model.avatarImage = kPlaceholderImage;
                
            }else{
                model.title = dict[@"from_name_user"];
                model.avatarURLPath = dict[@"from_heading_user"];
                //头像占位图
                //            model.avatarImage = kPlaceholderImage;
            }
        }
        ChatViewController *chat = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
        chat.title = model.title;
        [EMUserInfo saveToUserInfo:conversation.conversationId name:conversationModel.title avatarURLPath:conversationModel.avatarURLPath];
        [self.navigationController pushViewController:chat animated:YES];
    }
}
//- (BOOL)messa
//- messagevie

- (UIView *)projectMessage{
    if (!_projectMessage) {
        _projectMessage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        [_projectMessage addSubview:self.headerImage];
        _projectMessage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkSystemMessageList)];
        [_projectMessage addGestureRecognizer:tap];
        self.name = [LabelCreat creatLabelWith:@"系统消息" font:[UIFont boldSystemFontOfSize:15] color:UIColorMake(51, 51, 51) textAlignment:NSTextAlignmentLeft];
        self.time = [LabelCreat creatLabelWith:@"09-12 23:22" font:[UIFont systemFontOfSize:11] color:UIColorMake(137, 137, 137) textAlignment:NSTextAlignmentLeft];
        
        [self.projectMessage addSubview:self.headerImage];
        [self.projectMessage addSubview:self.name];
        [self.projectMessage addSubview:self.time];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.projectMessage).offset(15);
            make.left.equalTo(self.projectMessage).offset(13);
            make.bottom.equalTo(self.projectMessage).offset(-15);
            make.width.height.offset(30);
        }];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.projectMessage).offset(0);
            make.left.equalTo(self.headerImage.mas_right).offset(13);
        }];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.projectMessage).offset(0);
            make.right.equalTo(self.projectMessage).offset(-13);
        }];
        
        
        UIView *lien = [[UIView alloc] init];
        lien.backgroundColor = UIColorMake(239, 239, 239);
        [self.projectMessage addSubview:lien];
        [lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.projectMessage).offset(0);
            make.right.equalTo(self.projectMessage).offset(0);
            make.bottom.equalTo(self.projectMessage).offset(0);
            make.height.offset(1);
        }];
        
        
    }
    return _projectMessage;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] init];
        _headerImage.clipsToBounds = YES;
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
        _headerImage.layer.cornerRadius = 15;
        _headerImage.image = UIImageMake(@"系统消息");
    }
    return _headerImage;
}

- (void)checkSystemMessageList{
    [self.navigationController pushViewController:[[MessageViewController alloc] init] animated:YES];
}


@end
