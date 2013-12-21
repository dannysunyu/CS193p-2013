//
//  ImageViewController.h
//  SPoT
//
//  Created by 孙 昱 on 13-10-2.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

// the Model for this VC
// simply the URL of a UIImage-compatible image (jpg, png, etc.)
@property (nonatomic, strong) NSURL *imageURL;

@end
