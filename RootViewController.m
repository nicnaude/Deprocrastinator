//
//  RootViewController.m
//  Deprocrastinator
//
//  Created by Nicholas Naudé on 18/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
     cell.textLabel.text = [self.toDoArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoArray.count;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
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
    [self.toDoArray insertObject:self.toDoTextField.text atIndex:0];
    NSLog(@"%@", self.toDoArray);
     [self.tableView reloadData];
    [self.view endEditing:YES];
    self.toDoTextField.text = nil;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem*)sender {
    if ([sender.title  isEqual: @"Edit"]) {
        sender.title = @"Done";
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        sender.title = @"Edit";
        [self.tableView setEditing:NO animated:NO];
    }
}


@end
