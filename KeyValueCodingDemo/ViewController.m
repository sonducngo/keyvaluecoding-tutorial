//
//  ViewController.m
//  KeyValueCodingDemo
//
//  Created by Son Ngo on 3/22/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "ViewController.h"
#import "Equipment.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *equipmentArray;

@end

#pragma mark -
@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // 1
  // populate data models
  self.equipmentArray = [NSMutableArray array];
  
  NSArray *names = [NSArray arrayWithObjects:@"iMac", @"iPhone 5s", @"iPhone 5c", @"Samsung Galaxy", nil];
  for (int i=0; i<20; i++) {
    Equipment *equipment = [[Equipment alloc] init];
    
    NSString *randomName = names[arc4random() % names.count];
    NSString *name = [NSString stringWithFormat:@"%@ - #%d", randomName, (arc4random() % 1000)];
    
    // 2
    [equipment setValue:name forKeyPath:@"name"];
    [equipment setValue:[NSNumber numberWithInt:(arc4random() % 1000)] forKeyPath:@"value"];
     
    [self.equipmentArray addObject:equipment];
  }
  
  // setup table
  self.tableView.dataSource = self;
}

#pragma mark - IBActions
- (IBAction)calculateButtonClicked:(id)sender {
  // 3
  // use key value coding collection operators
  NSNumber *count      = [self.equipmentArray valueForKeyPath:@"@count"];
  self.countLabel.text = [NSString stringWithFormat:@"%d", [count intValue]];
  
  NSNumber *avg          = [self.equipmentArray valueForKeyPath:@"@avg.value"];
  self.averageLabel.text = [NSString stringWithFormat:@"$%.02f", [avg floatValue]];
  
  NSNumber *sum      = [self.equipmentArray valueForKeyPath:@"@sum.value"];
  self.sumLabel.text = [NSString stringWithFormat:@"$%.02d", [sum intValue]];
  
  NSNumber *min      = [self.equipmentArray valueForKeyPath:@"@min.value"];
  self.minLabel.text = [NSString stringWithFormat:@"$%.02d", [min intValue]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.equipmentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  Equipment *equipment = self.equipmentArray[indexPath.row];
  cell.textLabel.text       = [equipment valueForKeyPath:@"name"];
  
  // 4
  NSNumber *value = [equipment valueForKey:@"value"];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"$%d", [value intValue]];
  
  return cell;
}

@end
