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
    [self.window setFrame:CGRectMake(500, 400, 480, 410) display:YES];
    [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.button1 setTitle:@"Включить"];
    [self.button2 setTitle:@"Включить"];
    [self.button3 setTitle:@"Включить"];
  //  [self.button1 setHidden:YES];
    [self.button1 setEnabled:YES];
    [self.button2 setEnabled:YES];
    [self.button3 setEnabled:YES];
    self.availableBaudRates = [NSArray arrayWithObjects: [NSNumber numberWithInteger:300], [NSNumber numberWithInteger:1200], [NSNumber numberWithInteger:2400], [NSNumber numberWithInteger:4800], [NSNumber numberWithInteger:9600], [NSNumber numberWithInteger:14400], [NSNumber numberWithInteger:19200], [NSNumber numberWithInteger:28800], [NSNumber numberWithInteger:38400], [NSNumber numberWithInteger:57600], [NSNumber numberWithInteger:115200], [NSNumber numberWithInteger:230400],
                               nil];

    self.serialPortManager = [ORSSerialPortManager sharedSerialPortManager];
    NSMutableArray *availablePorts = (NSMutableArray*)self.serialPortManager.availablePorts;
    NSLog(@"%@",availablePorts);
    
    self.statusBarItem = [[NSStatusBar systemStatusBar] statusItemWithLength:60.f];
    [self.statusBarItem setMenu:self.statusBarMenu];
    // [self.statusBarItem setTitle:@"мини"];
    [self.statusBarItem setImage:[NSImage imageNamed:@"indicator6.png"]];
    [self.statusBarItem setHighlightMode:YES];
    
    [self.sliderin4ka allowsTickMarkValuesOnly];
    
}



#pragma mark - кнопка подключения

- (IBAction)openOrClosePort:(id)sender {
    self.serialPort.delegate = self;

    if ([self.openClose.title  isEqual: @"Открыть"]) {
        [self.serialPort open]; // Открыть порт
        [self.openClose setTitle:@"Закрыть"];
    }
    else {
        [self.serialPort close]; // Закрыть порт
        [self.openClose setTitle:@"Открыть"];
    }
    

    NSLog(@"%@",self.serialPort);

    [self.serialPort isOpen] ? NSLog(@"YES") : NSLog(@"NO");
    
}

#pragma mark - мини менюшка



- (IBAction)showme:(id)sender {
    
    [NSApp activateIgnoringOtherApps:YES];
    [_window makeKeyAndOrderFront:nil];
    NSLog(@"Приложение открыто.");

}

- (IBAction)quitttt:(id)sender {
    [NSApp terminate:nil];
    NSLog(@"Приложение завершило работу.");
}




#pragma mark - Кнопочки вкл/выкл

- (IBAction)Button1:(id)sender {
    if ([self.button1.title  isEqual: @"Включить"]) {
        [self sendData:@"255r"];

        [self.button1 setTitle:@"Выключить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №1 включен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet1 setIntValue:255];
    }
    else {
        [self sendData:@"0r"];

        [self.button1 setTitle:@"Включить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №1 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet1 setIntValue:0];
    }
    
}

- (IBAction)Button2:(id)sender {
    if ([self.button2.title  isEqual: @"Включить"]) {
        [self sendData:@"255g"];

        [self.button2 setTitle:@"Выключить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №2 включен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet2 setIntValue:255];


    }
    else {
        [self sendData:@"0g"];

        [self.button2 setTitle:@"Включить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №2 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet2 setIntValue:0];

    }
    
}

- (IBAction)Button3:(id)sender {
    
    if ([self.button3.title  isEqual: @"Включить"]) {
        [self sendData:@"255y"];

        [self.button3 setTitle:@"Выключить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №3 включен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet3 setIntValue:255];

    }
    else {
        [self sendData:@"0y"];
        [self.button3 setTitle:@"Включить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №3 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        [self.sliderinoOutlet3 setIntValue:0];

    }
    
}






#pragma mark - функция отправки данных

- (void)sendData:(NSString*)data {
    
    NSData* someData = [data dataUsingEncoding:NSUTF8StringEncoding];//передача в качестве NSData
    [self.serialPort sendData:someData];
    
    
}

#pragma mark - делегированные методы


- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    NSLog(@"Данные были получены.");
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	printf("\nReceived: \"%s\" %s\n", [string UTF8String], [[data description] UTF8String]);

}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    NSLog(@"00000000000");

}



- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Уведомление"
                                     defaultButton:@"OK" alternateButton:nil
                                       otherButton:nil informativeTextWithFormat:
                      @"Порт успешно был открыт."];
    [alert setIcon:[NSImage imageNamed:@"iconko.png"]];
    [alert runModal];
    
    [self.button1 setEnabled:YES];
    [self.button2 setEnabled:YES];
    [self.button3 setEnabled:YES];
    
    [self.myText.textStorage.mutableString appendString:@"Порт успешно открыт.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    NSLog(@"Порт открыт.");
    
}



- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Уведомление"
                                     defaultButton:@"OK" alternateButton:nil
                                       otherButton:nil informativeTextWithFormat:
                      @"Порт успешно был закрыт."];
    [alert setIcon:[NSImage imageNamed:@"iconko.png"]];

    [alert runModal];
    
    [self.button1 setEnabled:NO];
    [self.button2 setEnabled:NO];
    [self.button3 setEnabled:NO];
    

    
    [self.myText.textStorage.mutableString appendString:@"Порт успешно закрыт.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    NSLog(@"Порт закрыт.");

    
    
}


- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
 
    NSLog(@"Ошибка");

    
}



- (IBAction)allOn:(id)sender {
    
    [self sendData:@"255r"];
    [self.button1 setTitle:@"Выключить"];
    [self.image1 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №1 включен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self sendData:@"255g"];
    [self.button2 setTitle:@"Выключить"];
    [self.image2 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №2 включен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self sendData:@"255y"];
    [self.button3 setTitle:@"Выключить"];
    [self.image3 setImage:[NSImage imageNamed:@"indicator1.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №3 включен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self.sliderinoOutlet1 setIntValue:255];
    [self.sliderinoOutlet2 setIntValue:255];
    [self.sliderinoOutlet3 setIntValue:255];
    
}

- (IBAction)allOff:(id)sender {
    
    [self sendData:@"0r"];
    [self.button1 setTitle:@"Включить"];
    [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №1 выключен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self sendData:@"0g"];
    [self.button2 setTitle:@"Включить"];
    [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №2 выключен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self sendData:@"0y"];
    [self.button3 setTitle:@"Включить"];
    [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
    [self.myText.textStorage.mutableString appendString:@"Светодиод №3 выключен.\n "];
    [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    [self.sliderinoOutlet1 setIntValue:0];
    [self.sliderinoOutlet2 setIntValue:0];
    [self.sliderinoOutlet3 setIntValue:0];

    
}



#pragma mark - Не забудь закрыть за собой дверь!!

- (void)applicationWillTerminate:(NSNotification *)notification
{
	NSArray *ports = [[ORSSerialPortManager sharedSerialPortManager] availablePorts];
	for (ORSSerialPort *port in ports) { [port close]; }
}

- (IBAction)sliderinoAct1:(id)sender {
    if (self.sliderinoVal1 > 0) {
        [self.button1 setTitle:@"Выключить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:[NSString stringWithFormat:@"Светодиод №1,яркость = %ld\n",(long)self.sliderinoVal1]];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    
    }else {
        [self.button1 setTitle:@"Включить"];
        [self.image1 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №1 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    }
    [self sendData:[NSString stringWithFormat:@"%ldr",(long)self.sliderinoVal1]];

}

- (IBAction)sliderinoAct2:(id)sender {
    if (self.sliderinoVal2 > 0) {
        [self.button2 setTitle:@"Выключить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:[NSString stringWithFormat:@"Светодиод №2,яркость = %ld\n",(long)self.sliderinoVal2]];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        
    }else {
        [self.button2 setTitle:@"Включить"];
        [self.image2 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №2 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    }
    [self sendData:[NSString stringWithFormat:@"%ldg",(long)self.sliderinoVal2]];

}

- (IBAction)sliderinoAct3:(id)sender {
    if (self.sliderinoVal3 > 0) {
        [self.button3 setTitle:@"Выключить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator1.png" ]];
        [self.myText.textStorage.mutableString appendString:[NSString stringWithFormat:@"Светодиод №3,яркость = %ld\n",(long)self.sliderinoVal3]];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
        
    }else {
        [self.button3 setTitle:@"Включить"];
        [self.image3 setImage:[NSImage imageNamed:@"indicator2.png" ]];
        [self.myText.textStorage.mutableString appendString:@"Светодиод №3 выключен.\n "];
        [self.myText scrollRangeToVisible: NSMakeRange(self.myText.string.length, 0)];
    }
    [self sendData:[NSString stringWithFormat:@"%ldy",(long)self.sliderinoVal3]];


}
@end
