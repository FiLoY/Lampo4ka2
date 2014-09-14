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

@property (weak) IBOutlet NSMenuItem *but1;
@property (weak) IBOutlet NSMenuItem *but2;

- (IBAction)showme:(id)sender;
- (IBAction)quitttt:(id)sender;
- (IBAction)allOn:(id)sender;
- (IBAction)allOff:(id)sender;


@property (nonatomic, strong) ORSSerialPort *serialPort;
@property (nonatomic, strong) ORSSerialPortManager *serialPortManager;
@property (nonatomic, strong) NSArray *availableBaudRates;



@property NSInteger sliderinoVal1;
@property NSInteger sliderinoVal2;
@property NSInteger sliderinoVal3;


- (IBAction)sliderinoAct1:(id)sender;
- (IBAction)sliderinoAct2:(id)sender;
- (IBAction)sliderinoAct3:(id)sender;

@property (weak) IBOutlet NSSlider *sliderinoOutlet1;
@property (weak) IBOutlet NSSlider *sliderinoOutlet2;
@property (weak) IBOutlet NSSlider *sliderinoOutlet3;

@property (weak) IBOutlet NSSliderCell *sliderin4ka;

@property (weak) IBOutlet NSBox *boxi;



@end
