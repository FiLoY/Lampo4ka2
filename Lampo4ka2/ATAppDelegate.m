//
//  ATAppDelegate.m
//  Lampo4ka2
//
//  Created by Александр Тарасов on 25.08.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ATAppDelegate.h"
#import "ORSSerialPort.h"
#import "ORSSerialPortManager.h"

@implementation ATAppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setFrame:CGRectMake(500, 400, 480, 400) display:YES];
    [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.button1 setTitle:@"Включить"];
    [self.button2 setTitle:@"Включить"];
    [self.button3 setTitle:@"Включить"];
  //  [self.button1 setHidden:YES];
    [self.button1 setEnabled:NO];
    [self.button2 setEnabled:NO];
    [self.button3 setEnabled:NO];

    self.availableBaudRates = [NSArray arrayWithObjects: [NSNumber numberWithInteger:300], [NSNumber numberWithInteger:1200], [NSNumber numberWithInteger:2400], [NSNumber numberWithInteger:4800], [NSNumber numberWithInteger:9600], [NSNumber numberWithInteger:14400], [NSNumber numberWithInteger:19200], [NSNumber numberWithInteger:28800], [NSNumber numberWithInteger:38400], [NSNumber numberWithInteger:57600], [NSNumber numberWithInteger:115200], [NSNumber numberWithInteger:230400],
                               nil];

    self.serialPortManager = [ORSSerialPortManager sharedSerialPortManager];
    NSMutableArray *availablePorts = (NSMutableArray*)self.serialPortManager.availablePorts;
    NSLog(@"%@",availablePorts);

}


#pragma mark - кнопка подключения

- (IBAction)openOrClosePort:(id)sender {
    
    if ([self.openClose.title  isEqual: @"Открыть"]) {
        [self.serialPort open]; // Открыть порт
        [self.openClose setTitle:@"Закрыть"];

    }
    else {
        [self.serialPort close]; // Открыть порт
        [self.openClose setTitle:@"Открыть"];
        
    }
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Уведомление"
                                     defaultButton:@"OK" alternateButton:nil
                                       otherButton:nil informativeTextWithFormat:
                      @"Порт успешно был открыт."];

    [alert runModal];
    NSLog(@"%@",self.serialPort);

    [self.serialPort isOpen] ? NSLog(@"YES") : NSLog(@"NO");
    self.serialPort.delegate = self;
    
}

#pragma mark - мини менюшка


-(void)awakeFromNib {
    
    self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:60.f];
    [self.statusBarItem setMenu:self.statusBarMenu];
    [self.statusBarItem setTitle:@"мини"];
    [self.statusBarItem setHighlightMode:YES];
}
- (IBAction)showme:(id)sender {
    
    [NSApp activateIgnoringOtherApps:YES];
    [_window makeKeyAndOrderFront:nil];
}

- (IBAction)quitttt:(id)sender {
    [NSApp terminate:nil];

}




#pragma mark - Кнопочки вкл/выкл

- (IBAction)Button1:(id)sender {
    if ([self.button1.title  isEqual: @"Включить"]) {
        [self sendData:@"1"];

        [self.button1 setTitle:@"Выключить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    }
    else {
        [self sendData:@"4"];

        [self.button1 setTitle:@"Включить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    }
    
}

- (IBAction)Button2:(id)sender {
    if ([self.button2.title  isEqual: @"Включить"]) {
        [self sendData:@"2"];

        
        [self.button2 setTitle:@"Выключить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    }
    else {
        [self sendData:@"5"];

        [self.button2 setTitle:@"Включить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    }
    
}

- (IBAction)Button3:(id)sender {
    
    if ([self.button3.title  isEqual: @"Включить"]) {
        [self sendData:@"3"];

        [self.button3 setTitle:@"Выключить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    }
    else {
        [self sendData:@"6"];
        [self.button3 setTitle:@"Включить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    }
    
}




#pragma mark - функция отправки данных

- (void)sendData:(NSString*)data {
    
    NSData* someData = [data dataUsingEncoding:NSUTF8StringEncoding];//передача в качестве NSData
    [self.serialPort sendData:someData];
    
    
}


- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    NSLog(@"gfjfgfgklfgl");
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	printf("\nReceived: \"%s\" %s", [string UTF8String], [[data description] UTF8String]);

}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    NSLog(@"gfjfgfgklfgl");

}



- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    
    NSLog(@"gfjfgfgklfgl");
    
}



- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    
    NSLog(@"gfjfgfgklfgl");

    
    
}


- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
 
    NSLog(@"gfjfgfgklfgl");

    
}








#pragma mark - Не забудь закрыть за собой дверь!!

- (void)applicationWillTerminate:(NSNotification *)notification
{
	NSArray *ports = [[ORSSerialPortManager sharedSerialPortManager] availablePorts];
	for (ORSSerialPort *port in ports) { [port close]; }
}

@end
