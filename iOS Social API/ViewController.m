//
//  ViewController.m
//  iOS Social API
//
//  Created by 峰哥哥-.- on 15/7/13.
//  Copyright (c) 2015年 峰哥哥. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方法一、
    //UIActivityViewController
    
    NSString *message=@"分享测试！";
    UIImage *image=[UIImage imageNamed:@"item.jpg"];
    
    UIActivityViewController *activty=[[UIActivityViewController alloc]initWithActivityItems:@[message,image] applicationActivities:nil];
    [self presentViewController:activty animated:YES completion:nil];
//    这种方法系统会在底部弹出一个列表，不过得之前添加新浪微博账号，或腾讯微博账号。
    
    //方法二、SLComposeViewController
    //需要导入#import <Social/Social.h>头文件
    
    //    判断新浪微博是否可用
    BOOL available=[SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo];
    if(available)
    {
        SLComposeViewController *compose=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        SLComposeViewControllerCompletionHandler completHandler=^(SLComposeViewControllerResult reslut){
            if(reslut==SLComposeViewControllerResultCancelled)
                NSLog(@"取消");
            else
                NSLog(@"完成");
            [compose dismissViewControllerAnimated:YES completion:nil];
        };
        compose.completionHandler=completHandler;
        
        [compose setInitialText:message];
        [compose addImage:image];
        [compose addURL:[NSURL URLWithString:@"www.hao123.com"]];
        [self presentViewController:compose animated:YES completion:nil];
    }
    else
        NSLog(@"微博不可用");
    
}




@end
