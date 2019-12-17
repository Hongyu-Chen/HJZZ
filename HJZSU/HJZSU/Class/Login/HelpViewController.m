//
//  HelpViewController.m
//  HJZSS
//
//  Created by apple on 2019/3/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"

@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) UITextView *textView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
}

- (void)setType:(HelpStatus)type{
    _type = type;
    
    switch (_type) {
        case HelpStatusAboutMe:
        {
            self.titleLab.text = @"关于我们";
            [self.tableView reloadData];
            __weak typeof(self) weakself = self;
            [self getNormalQuestionwithCode:@"about" success:^(id  _Nonnull result) {
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",SCREEN_WIDTH - 26,result[@"content"]];
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                weakself.textView.attributedText = attrStr;
            } failed:^(NSString * _Nonnull reson) {
                NSLog(@"%@",reson);
            }];
        }
            break;
        case HelpStatusQuestion:
        {
            self.titleLab.text = @"常见问题";
            [self.tableView reloadData];
            __weak typeof(self) weakself = self;
            [self getNormalQuestionwithCode:@"problem" success:^(id  _Nonnull result) {
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",SCREEN_WIDTH - 26,result[@"content"]];
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                weakself.textView.attributedText = attrStr;
            } failed:^(NSString * _Nonnull reson) {
                NSLog(@"%@",reson);
            }];
        }
            break;
        case HelpStatusProtol:
        {
            self.titleLab.text = @"用户协议";
            [self.tableView reloadData];
            __weak typeof(self) weakself = self;
            [self getNormalQuestionwithCode:@"agreement" success:^(id  _Nonnull result) {
                NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",SCREEN_WIDTH - 26,result[@"content"]];
                NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                weakself.textView.attributedText = attrStr;
            } failed:^(NSString * _Nonnull reson) {
                NSLog(@"%@",reson);
            }];
        }
            break;
            
        default:
            break;
    }
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _textView.editable = NO;
        _textView.textColor = UIColorMake(137, 137, 137);
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationContentTopConstant)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        [_tableView registerClass:[HelpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HelpTableViewCell class])];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.type == HelpStatusAboutMe || self.type == HelpStatusProtol  ? 1 : 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == HelpStatusAboutMe || self.type == HelpStatusProtol) {
        return 0;
    }
    else{
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.type == HelpStatusAboutMe || self.type == HelpStatusProtol) {
        return nil;
    }
    else{
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        header.backgroundColor = self.view.backgroundColor;
        UILabel *tip = [LabelCreat creatLabelWith:@"1.版本XXXXXXX" font:[UIFont boldSystemFontOfSize:18] color:UIColorMake(73, 73, 73) textAlignment:NSTextAlignmentLeft];
        tip.frame = CGRectMake(13, 0, SCREEN_WIDTH - 26, 30);
        [header addSubview:tip];
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HelpTableViewCell class])];
    return cell;
}

@end
