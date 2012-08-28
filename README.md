# GridTable

大抵のGUIライブラリにはGridと呼ばれる複数列/複数行のデータを表形式で表示するためのコンポーネントが用意されています。
しかしiOS UIKitにはなかったのでUITableViewをベースにGridTableを作りました。

### 対象者

- データ閲覧用アプリを最速で作りたい
- 業務用のアプリなので見た目は拘らない
- UITableViewCellカスタマイズめんどい
- グリッドを使ったWebやPC用アプリをiOSに移植したい

### 使い方

GridTableはViewControllerとして定義されています。

```
	GridTableVC *vc = [[GridTableVC alloc] init];
	self.window.rootViewController = vc;
	[vc release];
```

任意のモデルオブジェクトの配列をデータとして追加できます。

```
	NSMutableArray *rows = [[NSMutableArray alloc] init];
	[rows addObject:[[[User alloc] initWithName:@"山田太郎" mail:@"yamada1@example.com" phone:@"09011110001" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"山田二郎" mail:@"yamada2@example.com" phone:@"09011110002" memo:@"テスト"] autorelease]];
	[rows addObject:[[[User alloc] initWithName:@"山田三郎" mail:@"yamada3@example.com" phone:@"09011110003" memo:@"テスト"] autorelease]];
	vc.rows = rows;
	[rows release];
```

列情報はGridColumnオブジェクトで定義します。

```
	NSMutableArray *cols = [[NSMutableArray alloc] init];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"name" headerText:@"名前" width:150] autorelease]];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"mail" headerText:@"メールアドレス" width:300] autorelease]];
	[cols addObject:[[[GridColumn alloc] initWithPropertyName:@"phone" headerText:@"電話番号" width:150] autorelease]];
	vc.cols = cols;
	[cols release];
```

![Screenshot](https://raw.github.com/yuch/GridTable/screenshot/sample.png)

