//
//  TeamView.h
//  Sunswift
//
//  Created by Joshua CHIN on 11/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface TeamView : UIViewController
{
    sqlite3 *db;

    
}

@property (nonatomic, strong) IBOutlet UILabel *myLabel;

-(NSString *) filePath;
-(void) openDB;
-(void) createTableNamed:(NSString *) tableName
              withField1:(NSString *) field1
              withField2:(NSString *) field2;
-(void) insertRecordIntoTableNamed:(NSString *) tableName
                        withField1:(NSString *) field1
                       field1Value:(NSString *) field1Value
                         andField2:(NSString *) field2
                       field2Value:(NSString *) field2Value;
-(void) getAllRowsFromTableNamed: (NSString *) tableName;

@end