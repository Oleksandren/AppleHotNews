//
//  ListViewController.m
//  Apple Hot News
//
//  Created by oleksandr on 15.10.14.
//  Copyright (c) 2014 Access Softek. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

static NSString *const appleNewsUrlString = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";

@implementation ListViewController

#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self fetchEntries];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (connection)
        show_hud(self.view);
}

-(void)dealloc
{
    [super dealloc];
    connection = nil;
    xmlData = nil;
    channel = nil;
    _webViewController = nil;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self splitViewController])
        [[self navigationController] pushViewController:_webViewController animated:YES];
    else
    {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_webViewController];
        NSArray *vcs = [NSArray arrayWithObjects:[self navigationController], nav, nil];
        [[self splitViewController] setViewControllers:vcs];
        [[self splitViewController] setDelegate:_webViewController];
    }
    [_webViewController setItem:[channel itemsStore][indexPath.row]];
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
    RSSItem *item = [channel itemsStore][indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.detail;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel itemsStore] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RSSItem *currentItem = [channel itemsStore][indexPath.row];
    
    return [self heightForItem:currentItem];
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

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    [parser release];
    
    [xmlData release];
    [connection release];
    xmlData = nil;
    connection = nil;
    hide_hud(self.view);
    [self.navigationItem setTitle:channel.title];
    [[self tableView] reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (isIPAD && [[channel itemsStore] firstObject])
    {
        [_webViewController setItem:[[channel itemsStore] firstObject]];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                               animated:NO
                         scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
    [xmlData release];
    [connection release];
    connection = nil;
    xmlData = nil;
    hide_hud(self.view);
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                 message:errorString
                                                delegate:nil
                                       cancelButtonTitle:@"OK"
                                       otherButtonTitles:nil];
    [av show];
}

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqual:@"channel"])
    {
        channel = [[RSSChannel alloc] init];
        [channel setParentParserDelegate:self];
        [parser setDelegate:channel];
    }
}

#pragma mark - Heplers

- (void)fetchEntries
{
    xmlData = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString:appleNewsUrlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    connection = [[NSURLConnection alloc] initWithRequest:req
                                                 delegate:self
                                         startImmediately:YES];
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
