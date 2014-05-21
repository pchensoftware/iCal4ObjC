//
//  NSDate+CGICalendar.m
//
//  Created by Satoshi Konno on 5/12/11.
//  Copyright 2011 Satoshi Konno. All rights reserved.
//

#import "NSDate+CGICalendar.h"

#define CGNSDATE_ICALENDAR_DATETMEFORMAT @"YYYYMMdd'T'kkmmss'Z'"
#define CGNSDATE_ISO8601_DATETMEFORMAT @"YYYY-MM-dd kk:mm:ss"

@implementation NSDate(CGICalendar)

+ (NSDateFormatter *)cgi_icalendarDateFormatter {
   static NSDateFormatter *_cgi_icalendarDateFormatter = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      _cgi_icalendarDateFormatter = [[NSDateFormatter alloc] init];
      _cgi_icalendarDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
      _cgi_icalendarDateFormatter.dateFormat = CGNSDATE_ICALENDAR_DATETMEFORMAT;
   });
   return _cgi_icalendarDateFormatter;
}

+ (NSDateFormatter *)cgi_iso8601DateFormatter {
   static NSDateFormatter *_cgi_iso8601DateFormatter = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      _cgi_iso8601DateFormatter = [[NSDateFormatter alloc] init];
      _cgi_iso8601DateFormatter.timeStyle = NSDateFormatterFullStyle;
      _cgi_iso8601DateFormatter.dateFormat = CGNSDATE_ISO8601_DATETMEFORMAT;
   });
   return _cgi_iso8601DateFormatter;
}

+ (NSDateFormatter *)cgi_iso8601DescriptionDateFormatter {
   static NSDateFormatter *_cgi_iso8601DescriptionDateFormatter = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      _cgi_iso8601DescriptionDateFormatter = [[NSDateFormatter alloc] init];
      _cgi_iso8601DescriptionDateFormatter.locale = [NSLocale systemLocale];
      _cgi_iso8601DescriptionDateFormatter.dateFormat = CGNSDATE_ISO8601_DATETMEFORMAT;
   });
   return _cgi_iso8601DescriptionDateFormatter;
}

+ (id)dateWithICalendarString:(NSString *)aString
{
   return [[self cgi_icalendarDateFormatter] dateFromString:aString];
}

+ (id)dateWithICalendarISO8601:(NSString *)aString
{
   return [[self cgi_iso8601DateFormatter] dateFromString:aString];
}

- (NSString *)descriptionICalendar
{
	return [[NSDate cgi_icalendarDateFormatter] stringFromDate:self];
}

- (NSString *)descriptionISO8601
{
	return [[NSDate cgi_iso8601DescriptionDateFormatter] stringFromDate:self];
}

@end
