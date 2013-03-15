//
//  RootViewController.h
//  CustomSplitView
//
//  Created by Pantech - Milan on 05/03/13.
//  Copyright (c) 2013 com.pantech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic, retain) IBOutlet UIView *detailView;

@end
