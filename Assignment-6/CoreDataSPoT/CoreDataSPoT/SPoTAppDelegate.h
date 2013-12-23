//
//  AppDelegate.h
//  CoreDataSPoT
//
//  Created by 孙 昱 on 13-12-16.
//  Copyright (c) 2013年 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPoTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// file url for SPoT managedDocument
@property (strong, nonatomic) NSURL *managedDocumentURL;

// one instance of UIManagedDocument throughout the entire application
// for each actual document.  Then all changes will always be seen by
// all writers and readers of the document
@property (strong, nonatomic) UIManagedDocument *managedDocument;



@end
