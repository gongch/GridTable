//
//  GridColumn.h
//  GridTable
//
//  Created by 池田 優一 on H.24/08/24.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridColumn : NSObject
@property(nonatomic, retain) NSString *propertyName;
@property(nonatomic, retain) NSString *headerText;
@property(nonatomic, assign) float width;

-(id) initWithPropertyName:(NSString*)propertyName headerText:(NSString*)headerText width:(float)width;

@end
