//
//  User.h
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSNumber *isFirefighter;
@property (strong, nonatomic) NSString *secondaryAddress;
@property (strong, nonatomic) NSString *phoneNo;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *disabilities;
@end
