//
//  TableSort.h
//  testTable
//
//  Created by MrWu on 2017/11/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableSort : UIView<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
//m_table把这个放到h头文件是为了再外部方便设置上拉刷新或加拉加载更多等
@property (weak, nonatomic) IBOutlet UITableView *m_table1;


//设置TableView数据，并按首字母排序
- (void)setDataWithOrder:(NSArray*)DataArray Title:(NSString*)Title bOrder:(BOOL)bOrder;
@end
