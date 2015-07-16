//
//  ViewController.m
//  MySafari
//
//  Created by John Tan on 13/7/15.
//  Copyright (c) 2015 John Tan. All rights reserved.
//

#import "ViewController.h"
@import UIKit;


@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UILabel *webPageTitle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *urlString =@"http://www.google.com";
    NSURL *url = [NSURL URLWithString: urlString ];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.urlTextField.text =@"http://www.google.com";
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scalesPageToFit=YES;
    self.webView.scrollView.delegate = self;
}
- (IBAction)clearText:(UIButton *)sender {
    self.urlTextField.text = nil;
    self.urlTextField.text = @"enter URL here";
}
- (IBAction)GoButton:(UIButton *)sender {
    BOOL checkPrefix = [self.urlTextField.text hasPrefix:@"http://"];
    NSURL *url= nil;
    
    if (checkPrefix) {
        url = [NSURL URLWithString: self.urlTextField.text];
    }
    else {
        NSString *found = [NSString stringWithFormat:@"http://%@", [self.urlTextField text]];
        url = [NSURL URLWithString: found];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    self.urlTextField.text = self.urlTextField.text;
    [self.urlTextField resignFirstResponder];
    

}


- (IBAction)onBackButtonPressed:(UIButton *)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}
- (IBAction)onTeaserButtonPressed:(UIButton *)sender {
    NSLog(@"Coming soon!");
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    {
        NSString* title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
        self.webPageTitle.text = title;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    BOOL checkPrefix = [self.urlTextField.text hasPrefix:@"http://"];
    NSURL *url= nil;
    
    if (checkPrefix) {
        url = [NSURL URLWithString: self.urlTextField.text];
    }
    else {
        NSString *found = [NSString stringWithFormat:@"http://%@", [self.urlTextField text]];
        url = [NSURL URLWithString: found];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    self.urlTextField.text = self.urlTextField.text;
    
    [textField resignFirstResponder];
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 0.0){ //(scrollView.contentSize.height - scrollView.frame.size.height)){
        //hide textfield
        self.urlTextField.hidden=YES;
    }
    if (scrollView.contentOffset.y <= 0.0){
        //show textfield
        self.urlTextField.hidden=NO;
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
