//
//  ViewController.m
//  sheepRecorder
//
//  Created by Simon on 16/2/24.
//  Copyright © 2016年 sheep. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MZTimerLabel.h"
#import "SheepTools.h"

#define kRecordAudioFile @"myRecord.caf"
#define kBottomPadding 60
#define kLeftPadding 40

@interface ViewController ()<AVAudioRecorderDelegate>

@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property(nonatomic,strong) AVAudioRecorder *recorder;
@property(nonatomic,strong) AVAudioPlayer  *player;
@property(nonatomic,assign) BOOL recording;

@property(weak,nonatomic)UIProgressView *audioPower;


@property(nonatomic,strong) CAEmitterLayer *fireWorkLayer;


@property(nonatomic,strong)UIView *buttonsView;
@property(nonatomic,weak)UIButton *recordButton;
@property(nonatomic,weak)UIButton *stopButton;

@property(nonatomic,weak)MZTimerLabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     self.buttonsView.hidden = NO;
    [self setAudioSession];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

#pragma mark - lazy loading

- (CAEmitterLayer *)fireWorkLayer
{
    if (!_fireWorkLayer) {
        _fireWorkLayer = self.view.fireWorkLayer;
    }
    return _fireWorkLayer;
}



- (UIView *)buttonsView
{
    if (!_buttonsView) {
        _buttonsView = [[UIView alloc]init];
        [self.view addSubview:_buttonsView];
        [_buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.bottom.mas_equalTo(- kBottomPadding);
            
        }];
        [self setButtons];
    }
    return _buttonsView;
}

- (void)setButtons{
    
    //progressBar
    UIProgressView *audioPower = [[UIProgressView alloc]init];
    audioPower.progress = 0;
    [self.buttonsView addSubview:audioPower];
    
    [audioPower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buttonsView.mas_top).mas_offset(10);
        make.left.mas_equalTo(self.buttonsView.mas_left).mas_offset(kLeftPadding);
        make.right.mas_equalTo(self.buttonsView.mas_right).mas_offset(- kLeftPadding);
    }];
    self.audioPower = audioPower;
    
    
    UIButton * recordButton = [self getOneButtonsWithTitle: nil  Image:@"start" andSelectImage:@"pause"];
    // 音频开始录制  /  暂停录制
    recordButton.tag = 1001;
    [self.buttonsView addSubview:recordButton];
    [recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.mas_equalTo(self.buttonsView.mas_centerY);
        make.left.mas_equalTo(kLeftPadding);
    }];
    self.recordButton = recordButton;
    
    UIButton *stopButton = [self getOneButtonsWithTitle: nil  Image:@"stop" andSelectImage:@"stop"];
    stopButton.tag = 1002;
    [self.buttonsView addSubview:stopButton];
    [stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.buttonsView.mas_centerY);
        make.right.mas_equalTo(-kLeftPadding);
    }];
    self.stopButton = stopButton;
    
    
    //timeLabel
    MZTimerLabel *timeLabel = [[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeStopWatch];
    timeLabel.timeFormat = @"HH:mm:ss";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:23];
    [self.buttonsView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.buttonsView.mas_centerY);
        make.left.mas_equalTo(recordButton.mas_right).offset(10);
        make.right.mas_equalTo(stopButton.mas_left).offset(-10);
    }];
    
    
    self.timeLabel = timeLabel;
    
}
- (UIButton *)getOneButtonsWithTitle:(NSString *)title Image:(NSString *)image andSelectImage:(NSString *)selectedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    if (selectedImage) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    [button sizeToFit];
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

    return button;
}

- (void)buttonTap:(UIButton *)sender
{
    switch (sender.tag) {
        case 1001:   //开始录制、暂停录制、恢复录制
        {
            [self startRecord];
            break;
        }
            
        case 1002:  //停止录制
        {
            [self stopRecord];
          
            break;
        }
        default:
            
            break;
    }
    self.timer.fireDate = [NSDate distantPast];
}

/**
 *  startRecord / pauseRecord
 *
 *  @return nil
 */
- ( void) startRecord
{
    if (!self.recording) {
        self.recording = YES;
        self.recordButton.selected = YES;
        //开启背景动画
        [self.view startBackgroundAnimation:self.fireWorkLayer];
        //开始录制 音频
        [self.recorder record];
        [self.timeLabel start];
        
        
    }else{
        self.recording = NO;
        self.recordButton.selected = NO;
        //关闭背景动画
        [self.view stopBackgroundAnimation:self.fireWorkLayer];
        //暂停录制
        [self pauseRecord];
        
    }
}

/**
 *  pauseRecord
 *
 *  @return void
 */
- (void)pauseRecord
{
    [self.recorder pause];
    [self.timeLabel pause];
}

/**
 *  stopRecord
 *
 *  @return void
 */
- (void)stopRecord
{
    self.recording = NO;
    self.recordButton.selected = NO;
    [self.view stopBackgroundAnimation:self.fireWorkLayer];
    self.audioPower.progress=0.0;
    
    [self.recorder stop];
    [self.timeLabel pause];

}





//set for session of voice
- (void)setAudioSession
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    // status for recording and playing
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

//url for audioPath
- (NSURL *)getSavePath {
    NSString *urlString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlString = [urlString stringByAppendingPathComponent:kRecordAudioFile];
    
    return [NSURL fileURLWithPath:urlString];
}

//settings for record file
- (NSDictionary *)getAudioSettings{
    NSMutableDictionary *dicm = [NSMutableDictionary dictionary];
    //设置录音格式
    dicm[AVFormatIDKey] = @(kAudioFormatLinearPCM); //luyin ge shi
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    dicm[AVSampleRateKey] = @(8000);
    //设置通道,这里采用单声道
    dicm[AVNumberOfChannelsKey] = @(1);
    //每个采样点位数,分为8、16、24、32
    dicm[AVLinearPCMBitDepthKey] = @(8);
    //是否使用浮点数采样
    dicm[AVLinearPCMIsFloatKey] = @(YES);
    //....其他设置等
    return dicm;
    
}

- (AVAudioRecorder *)recorder{
    if (!_recorder) {
        NSURL *url = [self getSavePath];
        //创建录音格式设置
        NSDictionary *settings =[self getAudioSettings];
        NSError *error;
        _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:settings error:&error];
        _recorder.delegate = self;
        //如果要监控声波则必须设置为YES
        _recorder.meteringEnabled = YES;
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _recorder;
    
}

- (AVAudioPlayer *)player {
    if (!_player) {
        NSURL *url = [self getSavePath];
        NSError *error;
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _player.numberOfLoops = 0;
        [_player prepareToPlay];
        
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _player;
}


/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.recorder updateMeters];//更新测量值
    float power= [self.recorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}


#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    if (![self.player isPlaying]) {
        [self.player play];
    }
    
    NSLog(@"录音完成!%0.2f;时长：%@",[SheepTools fileSizeAtPath: [kAppDocumentsDomain stringByAppendingPathComponent:kRecordAudioFile]] ,self.timeLabel.text);
   
    //重置timeLabel
   [self.timeLabel reset];
}





//- (void)startBackgroundAnimation
//{
//    [self.view.layer addSublayer:self.fireWorkLayer];
//}
//- (void)stopBackgroundAnimation
//{
//    [self.fireWorkLayer removeFromSuperlayer];
//}

 
@end
