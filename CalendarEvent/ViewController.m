//
//  ViewController.m
//  CalendarEvent
//
//  Created by Ramdhas on May,21.
//  Copyright (c) 2014 Ramdhas. All rights reserved.
//

#import "ViewController.h"
#import <EventKitUI/EventKitUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddEvent:(id)sender
{
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
             NSString * appointmentDetail =@"Ramdhas";
             
             NSDate *startDate = [NSDate date];
             
             //Create the end date components
             NSDateComponents *tomorrowDateComponents = [[NSDateComponents alloc] init];
             tomorrowDateComponents.day = 1;
             
             NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:tomorrowDateComponents
                                                                             toDate:startDate
                                                                            options:0];
             
             event.title =@"Bullentin App";
             event.startDate=startDate;
             event.endDate=endDate;
             event.notes = appointmentDetail;
             // event.allDay=YES;
             
             [event setCalendar:[eventStore defaultCalendarForNewEvents]];
             
             NSError *err;
             [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
             
             UIAlertView * Alert = [[UIAlertView alloc]initWithTitle:nil message:@"Event added successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
               [Alert show];
             
         }
         else
         {
             NSLog(@"NoPermission to access the calendar");
         }
         
     }];
}

- (IBAction)ShowCalendar:(id)sender
{
    NSString* launchUrl = @"calshow://";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
}

@end
