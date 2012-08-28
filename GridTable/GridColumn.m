//
//  GridColumn.m
//  GridTable
//
//  Created by 池田 優一 on H.24/08/24.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import "GridColumn.h"

@implementation GridColumn

-(id) initWithPropertyName:(NSString*)propertyName headerText:(NSString*)headerText width:(float)width {
	self = [super init];
	if (self) {
		self.propertyName = propertyName;
		self.headerText = headerText;
		self.width = width;
	}
	return self;
}

@end
