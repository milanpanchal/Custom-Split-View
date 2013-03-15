//
//  TableViewDelegate.h
//  Aviation
//
//  Created by Movivation - HP on 29/01/13.
//  Copyright (c) 2013 com.movivation. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DelegateOfTableViewDelegate;

@interface TableViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *MOContext;

@property (assign, nonatomic) id <DelegateOfTableViewDelegate>delegate;

- (NSFetchedResultsController *)callFRCWithProtocolMethodsFromImplementatoin:(id)implementingClass;

@end

@protocol DelegateOfTableViewDelegate <NSObject>

@optional
- (UITableView *)currenttableview;
- (void)configurecell:(UITableViewCell *)cell atindexpath:(NSIndexPath *)indexPath forentity:(id)entity;
- (UIView *)tableView:(UITableView *)tableView viewforheaderinsection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightforheaderinsection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView didselectrowatindexpath:(NSIndexPath *)indexPath forentity:(id)entity;
@end