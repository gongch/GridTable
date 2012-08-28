//
//  AppDelegate.m
//  GridTable
//
//  Created by 池田 優一 on H.24/08/22.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import "AppDelegate.h"
#import "GridTableVC.h"
#import "User.h"
#import "GridColumn.h"

@implementation AppDelegate

- (void)dealloc
{
	[_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	GridTableVC *vc = [[GridTableVC alloc] init];
	
	NSMutableArray *rows = [[NSMutableArray alloc] init];
	[rows addObject:[[[User alloc] initWithName:@"山田太郎" mail:@"yamada1@example.com" phone:@"09011110001" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"山田二郎" mail:@"yamada2@example.com" phone:@"09011110002" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"山田三郎" mail:@"yamada3@example.com" phone:@"09011110003" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"田中武司" mail:@"takeshi.tanaka@example.com" phone:@"09011110004" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"田中聡" mail:@"satoshi.tanaka@example.com" phone:@"09011110005" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"鈴木啓太" mail:@"keita.suzuki@example.com" phone:@"09011110006" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"佐藤隆" mail:@"sato@example.com" phone:@"09011110007" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"斉藤亮" mail:@"saito@example.com" phone:@"09011110008" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"山崎太郎" mail:@"yamazaki@example.com" phone:@"09011110009" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"田中太郎" mail:@"tanaka@example.com" phone:@"09011110010" memo:@"テスト"] autorelease]];
	vc.rows = rows;
	[rows release];
	
	NSMutableArray *cols = [[NSMutableArray alloc] init];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"name" headerText:@"名前" width:100] autorelease]];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"mail" headerText:@"メールアドレス" width:280] autorelease]];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"phone" headerText:@"電話番号" width:100] autorelease]];
	vc.cols = cols;
	[cols release];
	
	self.window.rootViewController = vc;
	[vc release];
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
