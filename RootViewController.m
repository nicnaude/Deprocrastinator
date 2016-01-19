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
    self.toDoArray = [[NSMutableArray alloc] init];
    self.editModeIsOn = false;
//    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeRight:)];
//    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.tableView addGestureRecognizer:recognizer];
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell.backgroundColor != [UIColor whiteColor] && cell.backgroundColor != [UIColor yellowColor] && cell.backgroundColor != [UIColor greenColor] && cell.backgroundColor != [UIColor orangeColor] && cell.backgroundColor != [UIColor redColor]) {
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell = [self.toDoArray objectAtIndex:indexPath.row];

    } 
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}

//on button press change color to green
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor greenColor]];
}

//allows us to use "setEditing"
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//allows for delete edit
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//calls
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark – other methods

- (IBAction)onAddButtonPressed:(UIButton *)sender
{
    if (![self.toDoTextField.text isEqualToString:@""]) {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = self.toDoTextField.text;
        [self.toDoArray addObject:cell];
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
    } else
    {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *item = [self.toDoArray objectAtIndex:sourceIndexPath.row];
    [self.toDoArray removeObjectAtIndex:sourceIndexPath.row];
    [self.toDoArray insertObject:item atIndex:destinationIndexPath.row];
    
}


- (IBAction)swipeRightRecognizer:(UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.backgroundColor == [UIColor whiteColor]) {
        [cell setBackgroundColor:[UIColor greenColor]];
    }
    else if(cell.backgroundColor == [UIColor greenColor]) {
        [cell setBackgroundColor:[UIColor yellowColor]];
    }
    else if (cell.backgroundColor == [UIColor yellowColor]) {
        [cell setBackgroundColor:[UIColor redColor]];
    }
    else if (cell.backgroundColor == [UIColor redColor]) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    [self.toDoArray replaceObjectAtIndex:indexPath.row withObject:cell];
    [self.tableView reloadData];
    
}




@end
