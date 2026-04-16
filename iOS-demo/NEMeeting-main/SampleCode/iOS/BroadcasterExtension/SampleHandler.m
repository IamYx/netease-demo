#import "SampleHandler.h"
#import <NERtcReplayKit/NERtcReplayKit.h>

static NSString *kAppGroup =@"group.com.netease.yunxin.app.screenshare.example";//具体实现时，只需修改此 kAppGroup 部分。

@interface SampleHandler () <NEScreenShareSampleHandlerDelegate>

@end

@implementation SampleHandler

- (void)broadcastStartedWithSetupInfo:(NSDictionary<NSString *,NSObject *> *)setupInfo {
    // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
    NEScreenShareBroadcasterOptions *options = [[NEScreenShareBroadcasterOptions alloc] init];
    options.appGroup = kAppGroup;
    // 设置采集帧率 30 帧
    options.frameRate = 30;
    // 设置需要采集系统音频数据
    options.needAudioSampleBuffer = YES;
    [[NEScreenShareSampleHandler sharedInstance] broadcastStartedWithSetupInfo:options];
    NEScreenShareSampleHandler.sharedInstance.delegate = self;
}

- (void)broadcastPaused {
    // User has requested to pause the broadcast. Samples will stop being delivered.
    [[NEScreenShareSampleHandler sharedInstance] broadcastPaused];
}

- (void)broadcastResumed {
    // User has requested to resume the broadcast. Samples delivery will resume.
    [[NEScreenShareSampleHandler sharedInstance] broadcastResumed];
}

- (void)broadcastFinished {
    // User has requested to finish the broadcast.
    [[NEScreenShareSampleHandler sharedInstance] broadcastFinished];
}

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer withType:(RPSampleBufferType)sampleBufferType {
    [[NEScreenShareSampleHandler sharedInstance] processSampleBuffer:sampleBuffer
                                                            withType:sampleBufferType];
}

- (void)onRequestToFinishBroadcastWithError:(NSError *)error {
    [self finishBroadcastWithError:error];
}

@end
