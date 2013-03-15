//
//  TableViewDelegate.m
//  Aviation
//
//  Created by Movivation - HP on 29/01/13.
//  Copyright (c) 2013 com.movivation. All rights reserved.
//

#import "TableViewDelegate.h"
#import "AppDelegate.h"
#import "FetchedResultsControllerProtocol.h"
#import "People.h"

@implementation TableViewDelegate

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    id entity = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(configurecell:atindexpath:forentity:)]) {
        [self.delegate configurecell:cell atindexpath:indexPath forentity:entity];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [self configureCell:cell atIndexPath:indexPath];
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:viewforheaderinsection:)]) {
        headerView = [self.delegate tableView:tableView viewforheaderinsection:section];
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeaderHeight = 0.0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:heightforheaderinsection:)]) {
        sectionHeaderHeight = [self.delegate tableView:tableView heightforheaderinsection:section];
    }
    return sectionHeaderHeight;
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    id entity = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didselectrowatindexpath:forentity:)]) {
        [self.delegate tableView:tableView didselectrowatindexpath:indexPath forentity:entity];
    }
}

#pragma mark - fetchedResultsController

- (NSFetchedResultsController *)callFRCWithProtocolMethodsFromImplementatoin:(id)implementingClass {
    //    if (_fetchedResultsController != nil) {
    //        return _fetchedResultsController;
    //    }
    
    //this is very imp line
    id <FetchedResultsControllerProtocol>frcDelegate = implementingClass;
    
    NSString *entityName = [frcDelegate entityName];
    NSPredicate *predicate = [frcDelegate setOfPredicates];
    NSArray *sortDescriptors = [frcDelegate setOfSortDecsriptors];
    
    self.MOContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.MOContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setFetchBatchSize:40];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                         managedObjectContext:self.MOContext sectionNameKeyPath:nil
                                                    cacheName:nil] autorelease];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - FetchedResultsController delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    UITableView *tableView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    [tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    UITableView *tableView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    [tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    UITableView *tableView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(currenttableview)]) {
        tableView = [self.delegate currenttableview];
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

@end
