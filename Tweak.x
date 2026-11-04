#import <Foundation/Foundation.h>

@interface SBTelephonyManager : NSObject
- (int)registrationStatus;
@end

static int computeBarsFromRaw(long rsrp) {
    if (rsrp >= -80) {
        return 5;
    } else if (rsrp >= -89) {
        return 4;
    } else if (rsrp >= -98) {
        return 3;
    } else if (rsrp >= -104) {
        return 2;
    } else if (rsrp >= -122) {
        return 1;
    } else {
        return 0;
    }
}

%hook SBTelephonyManager

- (void)_setSignalStrength:(long)signalStrength andBars:(long)bars {
    int status = [self registrationStatus];

    NSLog(@"[CellBarsX] _setSignalStrength called signalStrength=%ld origBars=%ld status=%d", signalStrength, bars, status);

    if (signalStrength == 0 || status == 0 || status == 1 || status == 4) {
        %orig(signalStrength, bars);
        return;
    }

    long computedBars = computeBarsFromRaw(signalStrength);
    NSLog(@"[CellBarsX] overriding computedBars=%ld", computedBars);

    %orig(signalStrength, computedBars);
}

%end
