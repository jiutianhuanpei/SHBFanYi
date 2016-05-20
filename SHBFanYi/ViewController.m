//
//  ViewController.m
//  SHBFanYi
//
//  Created by shenhongbang on 16/5/19.
//  Copyright © 2016年 shenhongbang. All rights reserved.
//

#import "ViewController.h"
#import "MSTranslateAccessTokenRequester.h"
#import "MSTranslateVendor.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITextView    *inputView;
@property (nonatomic, strong) UITableView   *language;
@property (nonatomic, strong) UIButton      *btn;
@property (nonatomic, strong) UITextView    *outputView;

@end

@implementation ViewController {
    NSArray     *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *token = @"shb_microsofttranslation";
//    NSString *secret = @"26aaQCNwo6/8Wd1mr5TNuLFJGLObSeBUctzfscMHmbQ=";
    
    NSDictionary *dic = @{
                          @"ar" : @"Arabic",
                          @"bs-Latn" : @"Bosnian",
                          @"bg" : @"Bulgarian",
                          @"ca" : @"Catalan",
                          @"zh-CHS" : @"Chinese Simplified",
                          @"zh-CHT" : @"Chinese Traditional",
                          @"hr" : @"Croatian",
                          @"cs" : @"Czech",
                          @"da" : @"Danish",
                          @"nl" : @"Dutch",
                          @"en" : @"English",
                          @"et" : @"Estonian",
                          @"fi" : @"Finnish",
                          @"fr" : @"French",
                          @"de" : @"German",
                          @"el" : @"Greek",
                          @"ht" : @"Haitian Creole",
                          @"he" : @"Hebrew",
                          @"hi" : @"Hindi",
                          @"mww" : @"Hmong Daw",
                          @"hu" : @"Hungarian",
                          @"id" : @"Indonesian",
                          @"it" : @"Italian",
                          @"ja" : @"Japanese",
                          @"sw" : @"Kiswahili",
                          @"tlh" : @"Klingon",
                          @"tlh-Qaak" : @"Klingon (plqaD)",
                          @"ko" : @"Korean",
                          @"lv" : @"Latvian",
                          @"lt" : @"Lithuanian",
                          @"ms" : @"Malay",
                          @"mt" : @"Maltese",
                          @"no" : @"Norwegian",
                          @"fa" : @"Persian",
                          @"pl" : @"Polish",
                          @"pt" : @"portuguese",
                          @"otq" : @"Queretaro Otomi",
                          @"ro" : @"Romnian",
                          @"ru" : @"Russian",
                          @"sr-Cyrl" : @"Serbian(Cyrillic)",
                          @"sr-Latn" : @"Serbian(Latin)",
                          @"sk" : @"Slovak",
                          @"sl" : @"Slovenian",
                          @"es" : @"Spanish",
                          @"sv" : @"Swedish",
                          @"th" : @"Thai",
                          @"tr" : @"Turkish",
                          @"uk" : @"Ukrainian",
                          @"ur" : @"Urdu",
                          @"vi" : @"Vietnamese",
                          @"cy" : @"Welsh",
                          @"yua" : @"Yucatec Maya",
                          };
    _dataArray = [dic allKeys];
    
    
    [[MSTranslateAccessTokenRequester sharedRequester] requestAsynchronousAccessToken:CLIENT_ID clientSecret:CLIENT_SECRET];
    
    
    
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.outputView];
    [self.view addSubview:self.language];
    
    self.language.hidden = true;
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    self.inputView.frame = CGRectMake(20, 80, width - 40, 80);
    self.btn.frame = CGRectMake(20, CGRectGetMaxY(self.inputView.frame) + 20, width - 40, 40);
    self.language.frame = CGRectMake(20, CGRectGetMaxY(self.btn.frame), width - 40, 150);
    self.outputView.frame = CGRectMake(20, CGRectGetMaxY(self.btn.frame) + 20, width - 40, 80);
    
//    [self creatBtn:@"fanyi" action:@selector(fanyi) y:300];
    
}

- (void)fanyiTo:(NSString *)to {
    
    
    MSTranslateVendor *vendor = [[MSTranslateVendor alloc] init];
    [vendor requestTranslate:self.inputView.text from:nil to:to blockWithSuccess:^(NSString *translatedText) {
        NSLog(@"\ninput:%@\nto:%@\ntrans:%@", self.inputView.text, self.btn.titleLabel.text, translatedText);
       
        self.outputView.text = translatedText;
        
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
    
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    NSString *title = _dataArray[indexPath.row];
    NSString *text = NSLocalizedStringFromTable(title, @"Localization", nil);
    
    cell.textLabel.text = text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_language scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:true];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *title = NSLocalizedString(cell.textLabel.text, @"");
    
    [self.btn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    self.language.hidden = true;
    
    [self fanyiTo:_dataArray[indexPath.row]];
}

- (UIButton *)creatBtn:(NSString *)title action:(SEL)action y:(CGFloat)y {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn sizeToFit];
    btn.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2., y);
    return btn;
}

- (void)clickedBtn {
    self.language.hidden = false;
}

- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UITextView alloc] initWithFrame:CGRectZero];
        _inputView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _inputView;
}

- (UITableView *)language {
    if (_language == nil) {
        _language = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _language.backgroundColor = [UIColor grayColor];
        _language.delegate = self;
        _language.dataSource = self;
        [_language registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _language.rowHeight = 30;
    }
    return _language;
}

- (UITextView *)outputView {
    if (_outputView == nil) {
        _outputView = [[UITextView alloc] initWithFrame:CGRectZero];
        _outputView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _outputView.userInteractionEnabled = false;
    }
    return _outputView;
}

- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"choose language" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickedBtn) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
