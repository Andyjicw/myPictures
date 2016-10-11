//
//  MainViewController.m
//  myPicture
//
//  Created by andy on 16/4/29.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "MainViewController.h"

#import "MenuViewController.h"

#import "AndyPhotoBrowser.h"
#import <MJRefresh.h>

#import "POST.h"
#import "AndyCacheManeger.h"

@implementation ImageModel

@end

static NSString *kcellIdentifier   = @"CollectionViewCell";

@interface MainViewController () <AndyPhotoBrowserDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray     *models;
@property (nonatomic,strong) NSMutableArray     *dataArr;
@property long                                  selectIndex;
@property int                                   page;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.models = [[NSMutableArray alloc] init];
    self.dataArr = [[NSMutableArray alloc] init];
    
    self.page = 1;
    [self getDataFromDB];
    [self initUI];
    
}
- (void) getDataFromDB {
    
    DB *db = [[DB alloc] init];
    NSMutableArray *arr = [db DBGetTablePicture];
    [self toModel:arr];
    [self getDataFromNet];
}
- (void) setDataInDB:(id) result {
    UIColor *xx = [UIColor redColor];
    DB *db = [[DB alloc] init];
    if (_collection.mj_footer.isRefreshing) {
        [db DBSetTablePicture:result isDel:false];
        return;
    }
    [db DBSetTablePicture:result isDel:true];
}
- (void) toModel:(id)result {
    
    [_collection.mj_header endRefreshing];
    [_collection.mj_footer endRefreshing];
    
    if ([_collection.mj_header isRefreshing]) {
        [self.models removeAllObjects];
        [self.dataArr removeAllObjects];
    }
    
    [self.dataArr addObjectsFromArray:result];
    
    for (NSDictionary *dic in result) {
        ImageModel *model = [ImageModel new];
        NSString *tmp;
        tmp = [NSString stringWithFormat:@"%@/data/%@/%@/%@/0.jpg", BASE_URL, [dic objectForKey:@"set_name"], [dic objectForKey:@"class"], [dic objectForKey:@"group"]];
        model.image = tmp;
        [self.models addObject:model];
    }
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(myReloadData) withObject:nil waitUntilDone:NO];
    } else {
        [self myReloadData];
    }
    [self setDataInDB:result];
}

- (void) getDataFromNet {
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    [body setObject:[NSString stringWithFormat:@"%d", self.page] forKey:@"page"];
    
    [POST withUrl:BASE_URL
             body:body
             head:nil
          success:^(id result) {
              [self toModel:result];
          }
          failure:^(NSError *error) {
              [_collection.mj_header endRefreshing];
              [_collection.mj_footer endRefreshing];
          }];
}

- (void) myReloadData {
    [_collection reloadData];
}

- (void)initUI {
    
    self.title = @"颜颜";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    [_collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kcellIdentifier];
    
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataFromNet];
    }];
    
    _collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getDataFromNet];
    }];
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageModel *model = self.models[indexPath.row];
    //重用cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    //赋值
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    
    //添加四个边阴影
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(0, 0);
    imageView.layer.shadowOpacity = 1.0;
    imageView.layer.shadowRadius = 4.0;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 8) / 3, 170 * DEVICE_HEIGHT_RATIO);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AndyPhotoBrowser *browser = [[AndyPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.imageCount = [[self.dataArr[indexPath.row] objectForKey:@"pic_count"] intValue];
    browser.delegate = self;
    self.selectIndex = indexPath.row;
    [browser show];
}

#pragma maek - 相册
- (NSURL *)photoBrowser:(AndyPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSDictionary * dic = (NSDictionary *)self.dataArr[self.selectIndex];
    NSString *urlStr = [NSString stringWithFormat:@"%@/data/%@/%@/%@/%ld.jpg", BASE_URL,[dic objectForKey:@"set_name"], [dic objectForKey:@"class"], [dic objectForKey:@"group"], (long)index];
    return [NSURL URLWithString:urlStr];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window) {
        self.view = nil;
    }
}
#pragma mark - showMenu
- (void) showMenu {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
@end
