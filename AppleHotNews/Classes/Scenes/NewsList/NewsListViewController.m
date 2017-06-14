//
//  ListViewController.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailsViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "ActivityIndicatorManager.h"
#import "Helpers.h"
#import "NewsListViewModel.h"
#import "NewsListConfigurator.h"

@interface NewsListViewController ()
@property(nonatomic, strong) RSSChannel *channel;
@end

@implementation NewsListViewController

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [NewsListConfigurator configureView:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUI];
    [self bindViewModelAndView];
    [self reloadData];
}

-(void)dealloc
{
    [_channel release];
    [_newsDetailsViewController release];
    [_viewModel release];
    _channel = nil;
    _newsDetailsViewController = nil;
    _viewModel = nil;
    [super dealloc];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self splitViewController])
        [[self navigationController] pushViewController:_newsDetailsViewController animated:YES];
    else
    {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_newsDetailsViewController];
        NSArray *vcs = [NSArray arrayWithObjects:[self navigationController], nav, nil];
        [nav release];
        [[self splitViewController] setViewControllers:vcs];
        [[self splitViewController] setDelegate:_newsDetailsViewController];
    }
    [_newsDetailsViewController setItem:[self.channel itemsStore][indexPath.row]];
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:@"UITableViewCell"] autorelease];
        [cell.textLabel setNumberOfLines:0];
        [cell.textLabel setFont:[self titleFont]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.detailTextLabel setNumberOfLines:0];
        [cell.detailTextLabel setFont:[self detailFont]];
    }
    RSSItem *item = [self.channel itemsStore][indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger c = [[self.channel itemsStore] count];
    return c;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem *item = [self.channel itemsStore][indexPath.row];
    
    return [self heightForItem:item];
}

#pragma mark - Privat Getters

-(UIFont*)titleFont
{
    return [UIFont fontWithName:@"Helvetica" size:17.0];
}

-(UIFont*)detailFont
{
    return [UIFont fontWithName:@"Helvetica" size:14.0];
}

#pragma mark - Helpers

- (void)configureUI
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)bindViewModelAndView
{
    _viewModel.didUpdatedChanelInfo = ^(RSSChannel * _Nonnull chanel) {
        [ActivityIndicatorManager hideHUD];
        self.channel = chanel;
        [self.tableView reloadData];
    };
}

- (void)reloadData
{
    [ActivityIndicatorManager showHUD];
    [_viewModel fetchEntries];
}

- (CGFloat)heightForItem:(RSSItem *)item
{
    CGSize constraintSize = CGSizeMake(self.view.frame.size.width - 40, 0);
    
    CGRect titleRect = [item.title boundingRectWithSize:constraintSize
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[self titleFont]}
                                                       context:nil];
    CGRect detailRect = [item.detail boundingRectWithSize:constraintSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[self detailFont]}
                                                         context:nil];
    return titleRect.size.height + detailRect.size.height + 20;
}

@end
