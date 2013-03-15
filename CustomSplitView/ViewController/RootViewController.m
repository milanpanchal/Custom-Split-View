//
//  RootViewController.m
//  CustomSplitView
//
//  Created by Pantech - Milan on 05/03/13.
//  Copyright (c) 2013 com.pantech. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"
#import "SecondView.h"

@interface RootViewController () {
    FirstViewController *firstVC;
    SecondView *secondV;
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tblView reloadData];
    firstVC = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    secondV = [[SecondView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}



- (void)removeViews
{
    [firstVC.view removeFromSuperview];
    [secondV removeFromSuperview];
}

#pragma mark - DelegateOfTableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"First";
        }else {
            cell.textLabel.text = @"Second";
        }
        
    }   else {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Third";
        }else {
            cell.textLabel.text = @"Fourth";
        }
        
    }
    
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"First Section";
    }
    
    if (section == 1) {
        return @"Second Section";
    }

    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        [self removeViews];
        [self.detailView addSubview:firstVC.view];
        
    }else if (indexPath.row == 1) {
        [self removeViews];
        [self.detailView addSubview:secondV];
    }
}

@end
