#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)tirggerButtonOnClick:(UIButton *)sender {
    
    // --- USER --- //
    
    // You can crete Insider User and add attributes later on it.
    InsiderUser *currentUser = [Insider getCurrentUser];
    
    // Setting User Attributes in chainable way.
    currentUser.setName(@"Insider")
    .setSurname(@"Demo")
    .setAge(23)
    .setGender(InsiderGenderOther)
    .setBirthday([NSDate date])
    .setEmailOptin(true)
    .setSMSOptin(false)
    .setPushOptin(true)
    .setLocationOptin(true)
    .setFacebookID(@"Facebook-ID")
    .setTwitterID(@"Twittter-ID")
    .setLanguage(@"TR")
    .setLocale(@"tr_TR");
    
    // Setting User Identifiers.
    InsiderIdentifiers *identifiers = [[InsiderIdentifiers alloc] init];
    identifiers.addEmail(@"mobile@useinsider.com")
    .addPhoneNumber(@"+901234567")
    .addUserID(@"CRM-ID");
    
    // Login and Logout
    [currentUser login:identifiers];
    
    [currentUser logout];
    
    // Setting custom attributes.
    // MARK: Your attribute key should be all lowercased and should not include any special or non Latin characters or any space, otherwise this attribute will be ignored. You can use underscore _.
    currentUser.setCustomAttributeWithString(@"string_attribute", @"This is Insider.");
    currentUser.setCustomAttributeWithInt(@"int_attribute", 10);
    currentUser.setCustomAttributeWithDouble(@"double_attribute", 20.5);
    currentUser.setCustomAttributeWithBoolean(@"bool_attribute", true);
    currentUser.setCustomAttributeWithDate(@"date_attribute", [NSDate date]);
    
    NSArray *arr = [NSArray arrayWithObjects: @"value1", @"value2", @"value3", nil];
    
    // MARK: You can only call the method with array of string otherwise this attribute will be ignored.
    currentUser.setCustomAttributeWithArray(@"array_attribute", arr );
    
    // --- EVENT --- //
    
    // You can create an event without parameters and call the build method
    [[Insider tagEvent:@"first_event"] build];
    
    // You can create an event then add parameters and call the build method
    [[Insider tagEvent:@"second_event"].addParameterWithInt(@"int_parameter", 10) build];
    
    // You can create an object and add the parameters later
    InsiderEvent *insiderExampleEvent = [Insider tagEvent:@"third_event"];
    
    insiderExampleEvent.addParameterWithString(@"string_parameter", @"This is Insider.")
    .addParameterWithInt(@"int_parameter", 10)
    .addParameterWithDouble(@"double_parameter", 20.5)
    .addParameterWithBoolean(@"bool_parameter", true)
    .addParameterWithDate(@"date_parameter", [NSDate date]);
    
    // MARK: You can only call the method with array of string otherwise this event will be ignored.
    insiderExampleEvent.addParameterWithArray(@"array_parameter", arr);
    
    // Do not forget to call build method once you are done with parameters.
    // Otherwise your event will be ignored.
    [insiderExampleEvent build];
    
    // --- PRODUCT --- //
    
    // MARK: If any parameter which is passed to this method is nil / null or an empty string, it will return an empty and invalid Insider Product Object. Note that an invalid Insider Product object will be ignored for any product related operations.
    // You can crete Insider Product and add attributes later on it.
    NSArray *taxonomy = [NSArray arrayWithObjects: @"taxonomy1", @"taxonomy2", @"taxonomy3", nil];
    InsiderProduct *insiderExampleProduct = [Insider createNewProductWithID:@"productID" name:@"productName" taxonomy:taxonomy imageURL:@"imageURL" price:1000.5 currency:@"currency"];
    
    // Setting Product Attributes in chainable way.
    insiderExampleProduct.setColor(@"color")
    .setVoucherName(@"voucherName")
    .setVoucherDiscount(10.5)
    .setPromotionName(@"promotionName")
    .setPromotionDiscount(10.5)
    .setSize(@"size")
    .setSalePrice(10.5)
    .setShippingCost(10.5)
    .setQuantity(10)
    .setStock(10);
    
    // Setting custom attributes.
    // MARK: Your attribute key should be all lowercased and should not include any special or non Latin characters or any space, otherwise this attribute will be ignored. You can use underscore _.
    insiderExampleProduct.setCustomAttributeWithString(@"string_parameter", @"This is Insider.")
    .setCustomAttributeWithInt(@"int_parameter", 10)
    .setCustomAttributeWithDouble(@"double_parameter", 10.5)
    .setCustomAttributeWithBoolean(@"bool_parameter", true)
    .setCustomAttributeWithDate(@"date_parameter", [NSDate date]);
    
    // MARK: You can only call the method with array of string otherwise this event will be ignored.
    insiderExampleProduct.setCustomAttributeWithArray(@"array_parameter", arr);
    
    
    // --- REVENUE TRACKING --- //
    
    [Insider itemPurchasedWithSaleID:@"uniqueSaleID" product:insiderExampleProduct];
    
    // --- CART REMINDER --- //
    
    // Adding item to cart.
    [Insider itemAddedToCartWithProduct:insiderExampleProduct];
    
    // Removing item from the cart.
    [Insider itemRemovedFromCartWithProductID:@"productID"];
    
    // Removing all the items from the cart.
    // This method will automatically triggered when you call Revenue Tracking.
    [Insider cartCleared];
    
    // --- RECOMMENDATION ENGINE --- //
    
    // ID comes from your smart recommendation campaign.
    // Please follow the language code structure. For instance tr_TR.
    [Insider getSmartRecommendationWithID:1 locale:@"tr_TR" currency:@"TRY" smartRecommendation:^(NSDictionary *recommendation) {
        // Handle here
        NSLog(@"[INSIDER][getSmartRecommendationWithID]: %@", recommendation);
    }];
    
    [Insider getSmartRecommendationWithProduct:insiderExampleProduct recommendationID: 1 locale:@"tr_TR" smartRecommendation:^(NSDictionary *recommendation) {
        // Handle Here
        NSLog(@"[INSIDER][getSmartRecommendationWithProduct]: %@", recommendation);
    }];
    
    // --- SOCIAL PROOF --- //
    
    [Insider visitProductDetailPageWithProduct:insiderExampleProduct];
    
    // --- PAGE VISITING --- //
    
    [Insider visitHomepage];
    [Insider visitListingPageWithTaxonomy:taxonomy];
    
    NSArray *insiderExampleProducts = [NSArray arrayWithObjects: insiderExampleProduct, insiderExampleProduct, nil];
    [Insider visitCartPageWithProducts:insiderExampleProducts];
    
    // --- GDPR --- //
    
    // MARK: Please note that by default our SDK is collecting the data so you don't have to call this function if you are not asking users consents.
    
    // MARK: If you set false, the user will not share any data or receive any push until you set back true.
    [Insider setGDPRConsent:true];
    
    
    // --- MESSAGE CENTER --- //
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
    [Insider getMessageCenterDataWithLimit:20 startDate:yesterday endDate:today success:^(NSArray *messageCenterData) {
        NSLog(@"[INSIDER][getMessageCenterDataWithLimit]: %@", messageCenterData);
    }];
    
    // --- CONTENT OPTIMIZER --- //
    
    // String
    NSString *contentOptimizerString = [Insider getContentStringWithName:@"string_variable_name" defaultString:@"defaultValue" dataType:ContentOptimizerDataTypeElement];
    NSLog(@"[INSIDER][getMessageCenterDataWithLimit]: %@", contentOptimizerString);
    
    // Bool
    bool contentOptimizerBool = [Insider getContentBoolWithName:@"bool_variable_name" defaultBool:true dataType:ContentOptimizerDataTypeElement];
    NSLog(@"[INSIDER][getContentBoolWithName]: %d", contentOptimizerBool);
    
    // Integer
    int contentOptimizerInt = [Insider getContentIntWithName:@"int_variable_name" defaultInt:10 dataType:ContentOptimizerDataTypeElement];
    NSLog(@"[INSIDER][getContentBoolWithName]: %d", contentOptimizerInt);
}


@end
