//
//  TableViewController.m
//  Compose Demo
//
//  Created on 2021-03-05.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong, readwrite) NSArray<NSString *> *storyboardNames;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.storyboardNames = @[
        @"A",
        @"B",
        @"C",
        @"D",
        @"E",
        @"F",
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storyboardNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Solution" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Solution %@", self.storyboardNames[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:self.storyboardNames[indexPath.row] bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    viewController.modalPresentationStyle = UIModalPresentationFullScreen;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *solutionViewController = ((UINavigationController *)viewController).topViewController;
        solutionViewController.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        solutionViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSolutionViewController:)];
    }
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)dismissSolutionViewController: (UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }];
}

@end
