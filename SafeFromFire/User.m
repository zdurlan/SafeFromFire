//
//  User.m
//  SafeFromFire
//
//  Created by Alin Zdurlan on 29/04/2017.
//  Copyright © 2017 Alin Zdurlan. All rights reserved.
//

#import "User.h"

@implementation User
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.age forKey:@"age"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.secondaryAddress forKey:@"secondaryAddress"];
    [encoder encodeObject:self.disabilities forKey:@"disabilities"];
    [encoder encodeObject:self.phoneNo forKey:@"phoneNo"];
    [encoder encodeObject:self.isFirefighter forKey:@"isFirefighter"];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.age = [decoder decodeObjectForKey:@"age"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.secondaryAddress = [decoder decodeObjectForKey:@"secondaryAddress"];
        self.phoneNo = [decoder decodeObjectForKey:@"phoneNo"];
        self.disabilities = [decoder decodeObjectForKey:@"disabilities"];
        self.isFirefighter = [decoder decodeObjectForKey:@"isFirefighter"];
    }
    return self;
}
@end
