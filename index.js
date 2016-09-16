/**
 * @providesModule RNDFPAds
 */

'use strict';

var { Platform, NativeModules } = require('react-native');
var DFPAds = NativeModules.RNDFPAds;

var RNDFPAds = {

    fetchAd(adUnitID, templateID) {
        DFPAds.fetchAd(adUnitID, templateID);
    },
};

module.exports = RNDFPAds;
