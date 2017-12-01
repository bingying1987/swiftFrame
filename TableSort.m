//
//  TableSort.m
//  testTable
//
//  Created by MrWu on 2017/11/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TableSort.h"
#import "NSString+MyString.h"
@interface TableSort()
{
    NSArray *m_OrgDataArray;
    NSMutableArray *m_SortedArray;//排序后的二维数组
    NSMutableArray *m_IndexArray;//索引数组
    NSMutableArray *searchListArry;//搜索完成后的数组
}

@property (nonatomic) UISearchController *searchController;

@end

@implementation TableSort
@synthesize m_table1;
@synthesize searchController;
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];//使用setUp的话则可直接在xib中添加一个view指定为TableSort类型,另外同时注意IBOutlet 应该从类绑定到视图，而不是从视图绑定到类，如果使用视图绑定到类的话(ctrl加鼠标点击视图到File owner 运行会崩溃的)，应该使用从类绑定到视图(,先写好属性代码,然后点击File owner在右边的 最后1个选项中 点击拖动到视图来完成绑定),好坑啊
                     //不使用setUp的话 则可以外部手动调用 [[[NSBundle mainBundle] loadNibNamed:@"TableSort" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}


- (void)setUp
{
    
    //两种方法都可以
    UIView *viewtop = [[[NSBundle mainBundle] loadNibNamed:@"TableSort" owner:self options:nil] objectAtIndex:0];
    //   UIView *viewtop = [[[UINib nibWithNibName:@"MyScrollView" bundle:nil] instantiateWithOwner:self options:ni] objectAtIndex:0];
    viewtop.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:viewtop];
    
}

- (void)setDataWithOrder:(NSArray*)DataArray Title:(NSString*)Title bOrder:(BOOL)bOrder
{
    if(!searchController)
    {
        searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.delegate = self;
        searchController.searchResultsUpdater = self;
        searchController.searchBar.barTintColor = [UIColor yellowColor];
        searchController.searchBar.placeholder = @"请输入关键字";
        searchController.searchBar.text = @"我是周杰伦";
        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时背景变暗色
        searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时背景变模糊
//        searchController.obscuresBackgroundDuringPresentation = YES;
        //点击搜索时是否隐藏导航栏
//        searchController.hidesNavigationBarDuringPresentation = YES;
        searchController.searchBar.frame = CGRectMake(searchController.searchBar.frame.origin.x, searchController.searchBar.frame.origin.y, searchController.searchBar.frame.size.width, 44);
        
        m_table1.tableHeaderView = searchController.searchBar;
        searchListArry = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    
    NSMutableArray *ChineseSortArray = [NSString ReturnSortChineseArrar:DataArray SortIndex:Title type:0 bOrder:bOrder];//得到简单按首字母排序后的一维数组
    m_SortedArray = [NSString LetterSortArray:ChineseSortArray];
    m_IndexArray = [NSString IndexArray:ChineseSortArray];
    [m_table1 reloadData];
}


#pragma mark --UITableView

- (NSArray<NSString*> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (searchController.active) {
        return nil;
    }
    else
    {
        return m_IndexArray;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (searchController.active) {
        return 1;
    }
    else
    {
        return m_IndexArray.count;
    }
    
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (searchController.active) {
        return nil;
    }
    else
    {
        return m_IndexArray[section];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchController.active) {
        return searchListArry.count;
    }
    else
    {
        return [m_SortedArray[section] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;//根据自己修改
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [m_table1 dequeueReusableCellWithIdentifier:@"temp"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"temp"];
    }
    if (searchController.active) {
        cell.textLabel.text = [searchListArry[indexPath.row] objectForKey:@"title"];
    }
    else
    {
        cell.textLabel.text = [m_SortedArray[indexPath.section][indexPath.row] objectForKey:@"title"];
    }
    
    return cell;
}

//搜索过滤
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //也可在这里放入历史搜索记录
    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = searchController.searchBar.text;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@",searchString];
    if (searchListArry) {
        [searchListArry removeAllObjects];
    }
    //过滤数据
    NSMutableArray *tmp;
    for (int i = 0; i < m_SortedArray.count; i++) {
        tmp = [NSMutableArray arrayWithArray:[m_SortedArray[i] filteredArrayUsingPredicate:preicate]];
        [searchListArry addObjectsFromArray:tmp];
    }
    [m_table1 reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
