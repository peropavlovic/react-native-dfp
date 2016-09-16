//
//  RNDFPAds.m
//  RNDFPAds
//
//  Created by Pero on 16/09/16.
//  Copyright © 2016 Pero. All rights reserved.
//

#import "RNDFPAds.h"
#import <GoogleMobileAds/GADAdLoader.h>

@interface RNDFPAds ()<GADNativeCustomTemplateAdLoaderDelegate>

@property (nonatomic,strong)GADAdLoader* adLoader;
@property (nonatomic, strong)RCTResponseSenderBlock callback;
@property (nonatomic, strong)NSString *tamplateId;

@end

@implementation RNDFPAds

// The React Native bridge needs to know our module
RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    return @{@"dfp": @"DFP ads custom rendering"};
}


RCT_EXPORT_METHOD(fetchAd:(NSString *)adID:(NSString *)templateID:(RCTResponseSenderBlock)callback) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.adLoader = [[GADAdLoader alloc]
                         initWithAdUnitID:adID
                         rootViewController:nil
                         adTypes:@[kGADAdLoaderAdTypeNativeCustomTemplate]
                         options:nil];
        self.adLoader.delegate  = self;
        
        [self.adLoader loadRequest:[DFPRequest request]];
    });
    self.callback = callback;
    self.tamplateId = templateID;
}

#pragma mark - delegates

-(void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error{
    
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeContentAd:(GADNativeContentAd *)nativeContentAd{
    //self.callback(@[[NSNull null], nativeContentAd.headline, text, image]);
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeCustomTemplateAd:(GADNativeCustomTemplateAd *)nativeCustomTemplateAd{
    NSString *title = [nativeCustomTemplateAd stringForKey:@"title"];
    NSString *text = [nativeCustomTemplateAd stringForKey:@"text"];
    NSString *image = [[nativeCustomTemplateAd imageForKey:@"image"].imageURL absoluteString];
    self.callback(@[[NSNull null], title,text,image]);
}

- (NSArray *)nativeCustomTemplateIDsForAdLoader:(GADAdLoader *)adLoader{
    
    return @[self.tamplateId];
}

@end
