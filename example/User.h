//
//  User.h
//  GridTable
//
//  Created by 池田 優一 on H.24/08/24.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *mail;
@property(nonatomic, retain) NSString *phone;
@property(nonatomic, retain) NSString *memo;

-(id) initWithName:(NSString*)name mail:(NSString*)mail phone:(NSString*)phone memo:(NSString*)memo;

@end
