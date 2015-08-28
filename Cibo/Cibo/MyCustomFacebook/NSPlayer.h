//
//  NSPlayer.h
//  VideoD
//
//  Created by mithun ravi on 27/05/14.
//  Copyright (c) 2014 Ethenic Developers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPlayer : NSObject

@end


/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/Frameworks/MediaPlayer.framework/MediaPlayer
 */

#import <Foundation/NSObject.h>

@class NSMutableArray, MPItem, AVController, MPQueueFeeder, MPAudioDeviceController, NSNotification, MPAVErrorResolver, CALayer, MPAVControllerToAggregateDCommunicator, MPVolumeController;

@interface MPAVController : NSObject {
	AVController* _avController;
	double _connectionFailTime;
	unsigned _valid : 1;
	int _playbackMode;
	MPAudioDeviceController* _audioDeviceController;
	MPQueueFeeder* _feeder;
	MPAVErrorResolver* _itemErrorResolver;
	MPVolumeController* _volumeController;
	CALayer* _videoLayer;
	unsigned _videoLayerUsageCount;
	unsigned _tickTimerEnabled;
	CFRunLoopTimerRef _tickTimer;
	double _tickInterval;
	CFRunLoopTimerRef _currentItemBookkeepingTimer;
	int _indexChangeDirection;
	unsigned _itemIndexAtDeath;
	int _lastDisconnectReason;
	double _lastKnownTimeBeforeDeath;
	double _lastPlaybackIndexChangeTime;
	double _lastSetTime;
	double _lastSetTimeChangeTime;
	unsigned _hasDelayedCurrentTimeToSet : 1;
	unsigned _forceDelayedCurrentTimeToSet : 1;
	double _delayedCurrentTimeToSet;
	int _delayedCurrentTimeOptions;
	unsigned _lastSetTimeMarker;
	unsigned _autoPlayWhenLikelyToKeepUp : 1;
	unsigned _closedCaptioningEnabled : 1;
	int _eqPreset;
	double _nextFadeOutDuration;
	double _repeatGap;
	float _rateBeforeSeek;
	float _inflightSeekRate;
	unsigned _scanLevel;
	int _scanDirection;
	int _resetRateAfterSeekingUpdateDisabled;
	unsigned _seeklessState;
	unsigned _isSeekingOrScrubbing : 1;
	unsigned _resetRateAfterSeeking : 1;
	unsigned _activeRewindHoldingAtStart : 1;
	unsigned _alwaysPlayWheneverPossible : 1;
	unsigned _stopAtEnd : 1;
	unsigned _didReachEnd : 1;
	unsigned _pausedDuringInterruption : 1;
	unsigned _useApplicationAudioSession : 1;
	unsigned _subtitlesEnabled : 1;
	id _subtitlesRecipient;
	unsigned _state;
	unsigned _displayOverridePlaybackState;
	unsigned _bufferingState;
	NSNotification* _delayedPlaybackStateNotification;
	NSMutableArray* _queueFeederStateStack;
	int _feederMode;
	MPAVControllerToAggregateDCommunicator* _aggregateDCommunicator;
}
@property(readonly, retain, nonatomic) MPAudioDeviceController* audioDeviceController;
@property(readonly, assign, nonatomic) unsigned bufferingState;
@property(assign, nonatomic) int EQPreset;
@property(retain, nonatomic) MPQueueFeeder* feeder;
@property(assign, nonatomic) double nextFadeOutDuration;
@property(assign, nonatomic) double repeatGap;
@property(assign, nonatomic) unsigned state;
@property(readonly, retain, nonatomic) id subtitlesRecipient;
@property(readonly, retain, nonatomic) CALayer* videoLayer;
@property(readonly, retain, nonatomic) MPVolumeController* volumeController;
@property(assign, nonatomic) int feederMode;
@property(assign, nonatomic, getter=destinationIsTVOut, setter=setDestinationIsTVOut:) BOOL destinationIsTVOut;
@property(assign, nonatomic) float rate;
@property(readonly, assign, nonatomic) BOOL handlingRemoteEvent;
@property(readonly, retain, nonatomic) AVController* avController;
@property(readonly, assign, nonatomic) BOOL isCurrentItemIsReadyToPlay;
@property(assign, nonatomic) BOOL useApplicationAudioSession;
@property(assign, nonatomic) BOOL stopAtEnd;
@property(assign, nonatomic) int playbackMode;
@property(assign, nonatomic) BOOL alwaysPlayWheneverPossible;
@property(readonly, assign, nonatomic, getter=isValid) BOOL valid;
@property(assign, nonatomic) BOOL subtitlesEnabled;
@property(readonly, assign, nonatomic, getter=isRewindHoldingAtStart) BOOL rewindHoldingAtStart;
@property(readonly, assign, nonatomic, getter=isPlaying) BOOL playing;
@property(readonly, assign, nonatomic) unsigned numberOfItems;
@property(assign, nonatomic) double currentTime;
@property(readonly, retain, nonatomic) MPItem* currentItem;
@property(readonly, assign, nonatomic) unsigned activeShuffleType;
@property(readonly, assign, nonatomic) unsigned activeRepeatType;
@property(readonly, assign, nonatomic) BOOL muted;
@property(assign, nonatomic) float volume;
@property(assign, nonatomic) unsigned shuffleType;
@property(readonly, assign, nonatomic, getter=isShuffled) BOOL shuffled;
@property(assign, nonatomic) unsigned repeatType;
@property(assign, nonatomic) BOOL closedCaptioningEnabled;
@property(assign, nonatomic) BOOL autoPlayWhenLikelyToKeepUp;
+(id)sharedInstance;
+(void)purgeSharedInstance;
+(id)sharedIPCAppInstance;
-(id)init;
-(void)dealloc;
-(void)beginSeek:(int)seek;
-(void)dequeueOnDemandItemIfInactive;
-(void)_updateCurrentTimeToNextStartTimeForQueueFeeder:(id)queueFeeder withItemIndex:(int)itemIndex;
-(void)_setAVControllerQueueFeeder:(id)feeder startIndex:(unsigned)index;
-(void)setPlaybackIndex:(int)index;
-(void)_changePlaybackItemIndexToIndex:(unsigned)index fromIndex:(unsigned)index2 changeByDelta:(int)delta;
-(void)changePlaybackIndexBy:(int)by;
-(void)changePlaybackIndexBy:(int)by deltaType:(int)type;
-(void)changePlaybackIndexBy:(int)by deltaType:(int)type ignoreElapsedTime:(BOOL)time;
-(void)endSeek;
-(BOOL)fadeOutForQuit;
-(BOOL)isSeekingOrScrubbing;
-(void)endPlayback;
-(void)pauseWithFadeout:(float)fadeout;
-(void)pause;
-(void)play;
-(void)playItemAtIndex:(unsigned)index;
-(void)playItemAtIndex:(unsigned)index forceRestart:(BOOL)restart;
-(void)playChapterTimeMarkerAtIndex:(unsigned)index;
-(void)togglePlayback;
-(BOOL)forceRestartPlaybackIfNecessary;
-(void)beginTickTimerWithInterval:(double)interval;
-(void)endTickTimer;
-(BOOL)isTickTimerEnabled;
-(BOOL)_showsPlayingWhenInState:(unsigned)state;
-(unsigned)_seeklessStateForState:(unsigned)state;
-(BOOL)shouldDisplayAsPlaying;
-(void)applicationDidReceiveMemoryWarningAsUrgent:(BOOL)application;
-(void)applicationWillTerminate;
-(void)applyRepeatSettings;
-(void)applyShuffleSettings;
-(void)beginUsingVideoLayer;
-(void)endUsingVideoLayer;
-(void)prepareVideoLayerForReuse;
-(void)feederChangedContents:(id)contents;
-(void)reloadFeederWithStartIndex:(unsigned)startIndex;
-(void)setCurrentTime:(double)time options:(int)options;
-(void)switchToAudioPlayback:(BOOL)audioPlayback;
-(void)switchToVideoPlayback:(BOOL)videoPlayback;
-(void)saveCurrentFeederState;
-(void)restorePreviousFeederState;
-(void)ensureFeederIsClass:(Class)aClass;
-(void)updateBookkeepingNow;
-(double)timeOfPlayableStart;
-(double)timeOfPlayableEnd;
-(double)timeOfSeekableStart;
-(double)timeOfSeekableEnd;
-(void)skipToSeekableStart;
-(void)skipToSeekableEnd;
-(void)controller:(id)controller crossedTimeMarker:(int)marker forItem:(id)item context:(id)context;
-(BOOL)controller:(id)controller shouldBeginPlayingItem:(id)item error:(id*)error;
-(void)audioDeviceControllerAudioRoutesChanged:(id)changed;
-(void)errorResolver:(id)resolver didResolveError:(id)error withResolution:(int)resolution;
-(void)ensureHasAVController;
-(void)volumeControllerDidFade:(id)volumeController fadeDirection:(int)direction;
-(void)volumeControllerWillFade:(id)volumeController fadeDirection:(int)direction;
-(void)_itemAttributeAvailableNotification:(id)notification;
-(void)_itemCompletedDecodeNotification:(id)notification;
-(void)_itemDidChangeNotification:(id)_item;
-(void)_itemFailedToPlayNotification:(id)playNotification;
-(void)_itemPlaybackDidEndNotification:(id)_itemPlayback;
-(void)_itemReadyToPlayNotification:(id)playNotification;
-(void)_itemWillChangeNotification:(id)_item;
-(void)_playbackInterruptedNotification:(id)notification;
-(void)_playbackInterruptionDidEndNotification:(id)_playbackInterruption;
-(void)_updateCurrentItemBookkeeping;
-(void)_rateDidChangeNotification:(id)_rate;
-(void)_disconnectAVControllerWithReason:(int)reason;
-(void)_serverConnectionDiedNotification:(id)notification;
-(void)_sizeDidChangeNotification:(id)_size;
-(void)_streamBufferFullNotification:(id)notification;
-(void)_streamLikelyToKeepUpNotification:(id)keepUpNotification;
-(void)_streamRanDryNotification:(id)notification;
-(void)_streamUnlikelyToKeepUpNotification:(id)keepUpNotification;
-(void)_timeHasJumpedNotification:(id)notification;
-(void)_firstVideoFrameDisplayedNotification:(id)notification;
-(void)_timedMetadataAvailableNotification:(id)notification;
-(void)_resumedEventsOnly:(BOOL)only;
-(void)_resumedEventsOnlyNotification:(id)notification;
-(void)_resumedNotification:(id)notification;
-(void)_suspendedEventsOnlyNotification:(id)notification;
-(void)_suspendedNotification:(id)notification;
-(void)_delayedPlaybackIndexChange;
-(void)_delayedUpdateScanningRate;
-(void)_delayedUpdateTimeMarker;
-(id)_avController;
-(BOOL)_changeChapterTimeMarkerIndexBy:(int)by;
-(void)_clearVideoLayer;
-(void)_configureAVController:(id)controller;
-(BOOL)_connectAVController;
-(void)_endSeekAndChangeRate:(BOOL)rate;
-(unsigned)_playbackIndexForDelta:(int)delta fromIndex:(unsigned)index currentItemIsOnDemand:(BOOL)demand ignoreElapsedTime:(BOOL)time;
-(void)_prepareToPlayItem:(id)playItem;
-(id)embeddedDataTimesForItem:(id)item;
-(void)_registerForAVItemNotifications:(id)avitemNotifications;
-(void)_registerForAVNotifications:(id)avnotifications;
-(void)_resetInternalState;
-(void)_resetQueue:(BOOL)queue videoLayer:(id)layer;
-(void)_attemptAutoPlay;
-(void)_setBufferingState:(unsigned)state;
-(void)_setActionAtEndAttributeForState:(unsigned)state;
-(void)_delayedPostPlaybackStateChangedNotification;
-(void)_postPlaybackStateChangedNotificationWithOriginalState:(unsigned)originalState newState:(unsigned)state delayable:(BOOL)delayable;
-(void)setDisplayOverridePlaybackState:(unsigned)state;
-(unsigned)_displayPlaybackState;
-(void)_scheduleUpdateCurrentItemBookkeepingTimer;
-(void)_cancelUpdateCurrentItemBookkeepingTimer;
-(void)_configureUpdateCurrentItemBookkeepingTimer;
-(void)_clearResetRateAfterSeeking;
-(void)_setItemErrorResolver:(id)resolver;
-(void)_setState:(unsigned)state;
-(void)_setVideoLayerOnAVController:(id)controller force:(BOOL)force;
-(void)_setValid:(BOOL)valid;
-(void)_unregisterForAVItemNotifications:(id)avitemNotifications;
-(void)_unregisterForAVNotifications:(id)avnotifications;
-(void)_updateProgress:(CFRunLoopTimerRef)progress;
-(void)setRateForScanning:(float)scanning;
-(void)_updateScanningRate;
-(void)_delayedSetCurrentTime;
-(id)_metadataDictionariesFromMetadataPayload:(id)metadataPayload;
-(id)_extractImageFromMetadataPayload:(id)metadataPayload;
-(void)_pauseTickTimer;
-(void)_resumeTickTimer;
-(void)_playbackFailedWithError:(id)error;
@end