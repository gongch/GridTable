//
//  GridTableVC.m
//  GridTable
//
//  Created by 池田 優一 on H.24/08/22.
//  Copyright (c) 平成24年 池田 優一. All rights reserved.
//

#import "GridTableVC.h"
#import "GridColumn.h"

@interface GridTableVC () <UITableViewDataSource, UITableViewDelegate> {
}
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UIView *headerView;
@end

@implementation GridTableVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
		UITableView *tableView = [[UITableView alloc] init];
		self.tableView = tableView;
		tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		tableView.delegate = self;
		tableView.dataSource = self;
		[tableView release];
		
		UIView *headerView = [[UIView alloc] init];
		self.headerView = headerView;
		[headerView release];
    }
    return self;
}

- (void) dealloc {
	self.tableView = nil;
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor grayColor];

	[self makeHeaderView];
	
	CGRect tableFrame = CGRectMake(0,self.headerView.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height);
	self.tableView.frame = tableFrame;
	[self.view addSubview:self.tableView];
	
	// セパレータ for tableView
	UIView *bgView = [[UIView alloc] initWithFrame:self.tableView.frame];
	bgView.backgroundColor = [UIColor whiteColor];
	self.tableView.backgroundView = bgView;
	[bgView release];

	for (int i = 0; i < [self.cols count]; i++) {
		float right = [self leftPositionOfColomnNumber:i+1];
		
		UIView *tableSeparator = [[UIView alloc] initWithFrame:CGRectMake(right,0,1,self.tableView.bounds.size.height)];
		tableSeparator.backgroundColor = [UIColor lightGrayColor];
		[self.tableView.backgroundView addSubview:tableSeparator];
		
		[tableSeparator release];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 30.0;
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.rows count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellId = [NSString stringWithFormat:@"GridViewCell:%d", indexPath.section];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
		UITableViewCellStyle style = UITableViewCellStyleDefault;
		cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:cellId];
		[cell autorelease];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	// 前回のビューを削除
	for (UIView *view in cell.contentView.subviews) {
		[view removeFromSuperview];
	}
	if (self.rowRenderer != nil) {
		self.rowRenderer(cell, indexPath.row);
	}
	
	NSObject *row = [self.rows objectAtIndex:indexPath.row];
	for (int i = 0; i < [self.cols count]; i++) {
		GridColumn *col = [self.cols objectAtIndex:i];

		NSObject *val = [row performSelector:NSSelectorFromString(col.propertyName)];
		
		float left = [self leftPositionOfColomnNumber:i];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left+5,5,0,0)];
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont systemFontOfSize:14];
		label.textColor = [UIColor darkGrayColor];
		
		if (col.textRenderer != nil) {
			label.text = col.textRenderer(val);
		} else {
			label.text = [NSString stringWithFormat:@"%@", val];
		}
		
		if (col.labelRenderer != nil) {
			col.labelRenderer(label, val);
		}
		[label sizeToFit];
		[cell.contentView addSubview:label];
		[label release];
		
		// セパレータ
		float right = [self leftPositionOfColomnNumber:i+1];
		UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(right,0,1,cell.contentView.bounds.size.height)];
		separator.backgroundColor = [UIColor lightGrayColor];
		[cell.contentView addSubview:separator];
		[separator release];
	}
	return cell;
}

- (void) makeHeaderView {
	self.headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.headerView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];

	CGRect headerFrame = CGRectMake(0,0,self.view.bounds.size.width,30);
	self.headerView.frame = headerFrame;
	[self.view addSubview:self.headerView];
	
	for (int i = 0; i < [self.cols count]; i++) {
		GridColumn *col = [self.cols objectAtIndex:i];
		
		// 列ヘッダラベル (ソートボタン)
		float left = [self leftPositionOfColomnNumber:i];
		UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
		sortButton.tag = i+1;
		sortButton.frame = CGRectMake(left+5,5,0,20);
		sortButton.titleLabel.font = [UIFont systemFontOfSize:14];
		[sortButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[sortButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
//		[sortButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
		[sortButton setTitle:col.headerText forState:UIControlStateNormal];
		[sortButton sizeToFit];
		[sortButton addTarget:self action:@selector(onSortClicked:) forControlEvents:UIControlEventTouchUpInside];
		[self.headerView addSubview:sortButton];
		
		// セパレータ
		float right = [self leftPositionOfColomnNumber:i+1];
		UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(right,0,1,self.headerView.bounds.size.height)];
		separator.backgroundColor = [UIColor lightGrayColor];
		[self.headerView addSubview:separator];
		[separator release];
	}
	
	// 下線を引く
	UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0,30-1,self.headerView.bounds.size.width,1)];
	bottomBorder.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	bottomBorder.backgroundColor = [UIColor lightGrayColor];
	[self.headerView addSubview:bottomBorder];
	[bottomBorder release];
}

// 列の左端の座標を取得
- (float) leftPositionOfColomnNumber:(int)colNumber {
	float x = 0;
	for (int i = 0; i < [self.cols count]; i++) {
		//TODO: width:-1で可変幅列
		GridColumn *col = [self.cols objectAtIndex:i];
		
		if (i == colNumber) {
			return x;
		}

		x += col.width;
	}
	// その他の場合は、length+1として受け付ける
	return x;
}

-(void) onSortClicked:(UIButton*)button {
	NSLog(@"%d", button.tag);
	
	int colNumber = abs(button.tag) - 1;
	GridColumn *col = [self.cols objectAtIndex:colNumber];

	// asc/descをトグル
	button.tag = -button.tag;
	BOOL asc = button.tag > 0;
	
	// ボタンの選択状態を設定
	for (UIView *view in self.headerView.subviews) {
		if ([view class] == [UIButton class]) {
			UIButton *titleButton = (UIButton*)view;
			GridColumn *titleCol = [self.cols objectAtIndex:abs(titleButton.tag)-1];
			
			if (titleButton == button) {
				titleButton.selected = YES;
				[titleButton setTitle:[NSString stringWithFormat:@"%@ %@", titleCol.headerText, (asc ? @"▲" : @"▼")] forState:UIControlStateNormal];
			} else {
				titleButton.selected = NO;
				[titleButton setTitle:titleCol.headerText forState:UIControlStateNormal];
			}
			[titleButton sizeToFit];
		}
	}
	
	// ソート実行
	NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:col.propertyName ascending:asc];
	[self.rows sortUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
	[self.tableView reloadData];
}

@end
