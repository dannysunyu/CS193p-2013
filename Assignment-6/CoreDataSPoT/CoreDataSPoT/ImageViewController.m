//
//  ImageViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "ImageViewController.h"
#import "FlickrCache.h"
//#import "AttributedStringViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleBarButtonItem;
@property (strong, nonatomic) UIPopoverController *urlPopover;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Show URL"]) {
        return (self.imageURL && !self.urlPopover.popoverVisible) ? YES : NO;
    } else {
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"Show URL"]) {
//        if ([segue.destinationViewController isKindOfClass:[AttributedStringViewController class]]) {
//            AttributedStringViewController *asc = (AttributedStringViewController *)segue.destinationViewController;
//            asc.text = [[NSAttributedString alloc] initWithString:[self.imageURL description]];
//            if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
//                self.urlPopover = ((UIStoryboardPopoverSegue *)segue).popoverController;
//            }
//        }
//    }
//}

- (void)setTitle:(NSString *)title
{
    super.title = title;
    self.titleBarButtonItem.title = title;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        NSURL *imageURL = self.imageURL;    // grab the URL before we start (then check it below)
        if (!imageURL) return;
        
        [self.spinner startAnimating];      // if self.spinner is nil, does nothing
        
        dispatch_queue_t imageFetchQ = dispatch_queue_create("image fetcher", NULL);
        dispatch_async(imageFetchQ, ^{
            NSData *imageData = nil;
            NSURL *fileURL = [FlickrCache cachedFileURLforURL:self.imageURL];
            if (fileURL) {
                imageData = [[NSData alloc] initWithContentsOfURL:fileURL];
            } else {
                // really we should probably keep a count of threads claiming network activity
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    // bad
                imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
            [FlickrCache cacheData:imageData forURL:self.imageURL];
            
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            if (self.imageURL == imageURL) {
                // dispatch back to main queue to do UIKit work
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image) {
                        self.scrollView.zoomScale = 1.0;
                        self.scrollView.contentSize = image.size;
                        self.imageView.image = image;
                        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                    }
                    
                    [self.spinner stopAnimating];
                });
            }
        });
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    [self resetImage];
    self.titleBarButtonItem.title = self.title;
}

@end
