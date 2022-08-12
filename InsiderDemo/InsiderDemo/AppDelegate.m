#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// FIXME: Please change with your app group.
static NSString *APP_GROUP = @"group.com.useinsider.InsiderDemo";

// FIXME: Please change with your partner name.
// Make sure that all the letters are lowercase.
static NSString *INSIDER_PARTNER_NAME = @"your_partner_name";

// FIXME: Please change your URL Types to your partner name with insider prefix.
// URL Type which identifier is Insider and URL Schemes is your Insider Partner Name with insider prefix.
// For instance, insideryourpartnername where yourpartnername is your partner name.

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    
    [Insider initWithLaunchOptions:launchOptions partnerName:INSIDER_PARTNER_NAME appGroup:APP_GROUP];
    [Insider setActiveForegroundPushView];
    [Insider registerWithQuietPermission:false];
    [Insider registerInsiderCallbackWithSelector:@selector(insiderCallback:) sender:self];
    [Insider enableIDFACollection:false];
    [Insider getCurrentUser].setLocale(@"tr_TR");
    
    // You need to have required permissions in order to have location information from the user.
    // MARK: Please add required permissons to your info.plist.
    // https://developer.apple.com/documentation/corelocation/requesting_authorization_for_location_services
    [Insider startTrackingGeofence];
    
    return YES;
}


-(void)insiderCallback:(NSDictionary *)dict {
    
    InsiderCallbackType type = (InsiderCallbackType)[[dict objectForKey:@"type"] intValue];
    
    switch (type) {
        case InsiderCallbackTypeNotificationOpen:
            [self showAlert:dict withTitle:@"InsiderCallbackTypeNotificationOpen"];
            NSLog(@"[INSIDER][CALLBACK][InsiderCallbackTypeNotificationOpen]: %@", dict);
            break;
        case InsiderCallbackTypeTempStoreCustomAction:
            [self showAlert:dict withTitle:@"InsiderCallbackTypeTempStoreCustomAction"];
            NSLog(@"[INSIDER][CALLBACK][InsiderCallbackTypeTempStoreCustomAction]: %@", dict);
            break;
        default:
            break;
    }
}


-(void)showAlert:(NSDictionary*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:[NSString stringWithFormat:@"%@", message]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:okAction];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
