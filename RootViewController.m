//
//  RootViewController.m
//  Deprocrastinator
//
//  Created by Nicholas Naudé on 18/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *toDoTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL editModeIsOn;

@property NSMutableArray *toDoArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoArray = [[NSMutableArray alloc] initWithObjects:@"Code", @"More Code", @"Milk", @"Eggs and code", nil];
    self.editModeIsOn = false;
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRight:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:recognizer];
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];
    if (cell.backgroundColor != [UIColor whiteColor] && cell.backgroundColor != [UIColor yellowColor] && cell.backgroundColor != [UIColor greenColor] && cell.backgroundColor != [UIColor orangeColor] && cell.backgroundColor != [UIColor redColor]) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor yellowColor]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoArray removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    }
}

#pragma mark – other methods

- (IBAction)onAddButtonPressed:(UIButton *)sender
{
    if (![self.toDoTextField.text isEqualToString:@""]) {
        [self.toDoArray insertObject:self.toDoTextField.text atIndex:0];
    }
    
    [self.tableView reloadData];
    [self.view endEditing:YES];
    self.toDoTextField.text = nil;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem*)sender {
    if ([sender.title  isEqual: @"Edit"]) {
        sender.title = @"Done";
        self.editModeIsOn = true;
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        sender.title = @"Edit";
        [self.tableView setEditing:NO animated:NO];
        self.editModeIsOn = false;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editModeIsOn) {
        return YES;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *item = [self.toDoArray objectAtIndex:sourceIndexPath.row];
    [self.toDoArray removeObjectAtIndex:sourceIndexPath.row];
    [self.toDoArray insertObject:item atIndex:destinationIndexPath.row];
    
}


- (void) handleSwipeRight: (UISwipeGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath) {
        if (cell.backgroundColor == [UIColor whiteColor]) {
            [cell setBackgroundColor:[UIColor greenColor]];
            return;
        }
        if (cell.backgroundColor == [UIColor greenColor]) {
            [cell setBackgroundColor:[UIColor orangeColor]];
            return;
        }
        if (cell.backgroundColor == [UIColor orangeColor]) {
            [cell setBackgroundColor:[UIColor redColor]];
            return;
        }
        if (cell.backgroundColor == [UIColor redColor]) {
            [cell setBackgroundColor:[UIColor whiteColor]];
            return;
        }

    }
}

@end
