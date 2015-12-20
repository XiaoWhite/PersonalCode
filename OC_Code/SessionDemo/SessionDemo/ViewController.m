//
//  ViewController.m
//  SessionDemo
//
//  Created by NCS on 18/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import "ViewController.h"

#define kWeatherURL @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"


@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
{
    NSMutableData *receivedData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    receivedData = [NSMutableData data];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startSession:(id)sender {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kWeatherURL]];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    
    
     
    // 下面两种方法任意一个都可以
    
    
#pragma mark - 方法1：使用 block 处理请求结果
    /*
    // 如果使用 block ，就不需要代理方法，即使创建 session 时设置了代理，代理方法也不会被调用
     
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            NSLog(@"%@",error);
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dict != nil) {
            NSLog(@"dict = %@",dict);
        }
        
    }];
    
    */
    
    
#pragma mark - 方法2：使用 代理 处理请求结果
    // 使用代理时，注意 URLSession:session dataTask: didReceiveResponse: completionHandler: 代理方法
    // completionHandler 这个block 一定要去调用，并传入适当的参数(方法中有详细解释)
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    
    
    
    // 启动task
    [dataTask resume];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (error != nil) {
        NSLog(@"%@",error);
        return;
    }
    
    NSLog(@"task request finished");
    NSLog(@"taskDescription = %@,and task.state = %ld",task.description,task.state);
    
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
    
    if (dict != nil) {
        NSLog(@"dict = %@",dict);
    }
    
}



#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{

    NSLog(@"didReceiveResponse");
    
    
    // completionHandler 一定要调用，否则请求就会到此结束，也就是说收到 response 后，请求便停止了
    
    // 这个 block 传入的参数是一个枚举类型，
    
     
//    NSURLSessionResponseCancel = 0,                                      /* Cancel the load, this is the same as -[task cancel] */
//    NSURLSessionResponseAllow = 1,                                       /* Allow the load to continue */
//    NSURLSessionResponseBecomeDownload = 2,                              /* Turn this request into a download */
//    NSURLSessionResponseBecomeStream NS_ENUM_AVAILABLE(10_11, 9_0) = 3,  /* Turn this task into a stream task */
    
    // 只有传入 NSURLSessionResponseAllow 时，请求才会继续，才会有数据返回
    
    completionHandler(NSURLSessionResponseAllow);
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    NSLog(@"taskDescription = %@",dataTask.description);
    
    
    [receivedData appendData:data];
    
}



@end









