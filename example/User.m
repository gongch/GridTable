//
//  User.m
//  GridTable
//
//  Created by 池田 優一 on H.24/08/24.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithName:(NSString*)name mail:(NSString*)mail phone:(NSString*)phone memo:(NSString*)memo {
	self = [super init];
	if (self) {
		self.name = name;
		self.mail = mail;
		self.phone = phone;
		self.memo = memo;
	}
	return self;
}

@end
