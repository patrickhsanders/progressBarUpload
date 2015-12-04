//
//  ViewController.m
//  FetchWithProgress
//
//  Created by Aditya Narayan on 12/4/15.
//  Copyright © 2015 turntotech.io. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

@property (nonatomic) long long totalExpectedContentLength;
@property (nonatomic, strong) NSMutableData *downloadedData;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _progressBar.hidden = true;
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)loadLargeFile:(id)sender {
  NSLog(@"Button pressed");
  _progressBar.hidden = false;
  _progressBar.progress = 0;
  
//  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//  sessionConfig.timeoutIntervalForResource = 60.0;
  NSString *URLString = @"http://www.flag.st/m1.kmz";
  
  NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
  
  NSURL *url = [NSURL URLWithString: URLString];
  NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithURL: url];
//  NSURLSessionDataTask *dataTask2 = [defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    NSLog(@"Completed download");
//    _progressBar.hidden = true;
//    _downloadedData = nil;
//    _totalExpectedContentLength = 0;
//  }];
//  
//  NSURLSessionDataTask *dataTask3 = [defaultSession dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    NSLog(@"Completed download");
//    _progressBar.hidden = true;
//    _downloadedData = nil;
//    _totalExpectedContentLength = 0;
//  }];
//  
  [dataTask resume];
  //[dataTask2 resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
  completionHandler(NSURLSessionResponseAllow);
  
  _progressBar.progress = 0;
  _totalExpectedContentLength = [response expectedContentLength];
  _downloadedData = [[NSMutableData alloc]init];
  NSLog(@"%llu", _totalExpectedContentLength);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
  [_downloadedData appendData:data];
  _progressBar.progress = (float)[_downloadedData length]/(float)_totalExpectedContentLength;
}



@end
