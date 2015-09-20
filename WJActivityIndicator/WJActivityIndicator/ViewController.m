//
//  ViewController.m
//  WJActivityIndicator
//
//  Created by Alireza Arabi on 9/1/15.
//  Copyright (c) 2015 Alireza Arabi. All rights reserved.
//

#import "ViewController.h"
#import "WJActivityIndicatorView.h"

#define VIEWHEIGHT_7	(([[UIScreen mainScreen] bounds].size.height / 7) - 20)
#define VIEWWIDTH_4		(([[UIScreen mainScreen] bounds].size.width / 4) - 10)

@interface ViewController ()
{
	int counter;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	[self setTitle:@"WJ Activity Indicator"];
	[self.navigationController.navigationBar setTranslucent:NO];
	
	[self.collectionView setBackgroundColor:[UIColor clearColor]];
	[self.view setBackgroundColor:[UIColor colorWithRed:132/255.0 green:100/255.0 blue:220/255.0 alpha:1]];
	
	counter = 0;
}

- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning];
}

#pragma mark - CollectionView DataSource Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	return AnimationTypesCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	counter = (int)indexPath.item + 1;
	
	static NSString *identifier = @"CellID";
 
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
	
	[cell.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
	
	[cell setBackgroundColor:[UIColor clearColor]];

	CGRect cellFrame = CGRectMake(0, 0, VIEWWIDTH_4, VIEWHEIGHT_7);
	WJActivityIndicatorView *activityIndicator = [[WJActivityIndicatorView alloc] init];
	[activityIndicator completeWithFrame:cellFrame Type:counter Color:[UIColor whiteColor] Size:CGSizeMake(VIEWWIDTH_4 * 2 / 3, VIEWWIDTH_4 * 2 / 3)];
	[cell addSubview:activityIndicator];
	[activityIndicator startAnimation];
	
	return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	
	return 1;
}

#pragma mark - CollectionVIew Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

	return CGSizeMake(VIEWWIDTH_4, VIEWHEIGHT_7);
}


@end
