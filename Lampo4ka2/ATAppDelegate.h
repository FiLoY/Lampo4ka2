//
//  ATAppDelegate.h
//  Lampo4ka2
//
//  Created by Александр Тарасов on 25.08.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "ORSSerialPort.h"
#import "ORSSerialPortManager.h"
@interface ATAppDelegate : NSObject <ORSSerialPortDelegate, NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSImageCell *image1;
@property (weak) IBOutlet NSImageCell *image2;
@property (weak) IBOutlet NSImageCell *image3;


@property (weak) IBOutlet NSButton *button1;
@property (weak) IBOutlet NSButton *button2;
@property (weak) IBOutlet NSButton *button3;


@property (weak) IBOutlet NSButton *openClose;


- (IBAction)openOrClosePort:(id)sender;

- (IBAction)Button1:(id)sender;

- (IBAction)Button2:(id)sender;

- (IBAction)Button3:(id)sender;

@property (unsafe_unretained) IBOutlet NSTextView *myText;


@property IBOutlet NSMenu *statusBarMenu;
@property NSStatusItem *statusBarItem;

- (IBAction)showme:(id)sender;
- (IBAction)quitttt:(id)sender;



@property (nonatomic, strong) ORSSerialPort *serialPort;

@property (nonatomic, strong) ORSSerialPortManager *serialPortManager;

@property (nonatomic, strong) NSArray *availableBaudRates;





@end
