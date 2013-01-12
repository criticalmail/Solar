//
//  TeamView.m
//  Sunswift
//
//  Created by Joshua CHIN on 11/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import "TeamView.h"

@implementation TeamView

@synthesize myLabel;

-(NSString *) filePath {
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,                                                                                           NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"database.sql"];
}

-(void) openDB {
    //—-create database—-
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open.");
    }
}

-(void) createTableNamed:(NSString *) tableName
              withField1:(NSString *) field1
              withField2:(NSString *) field2 {
    
    char *err;
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                     "TEXT PRIMARY KEY, '%@' TEXT);",
                     tableName, field1, field2];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
        != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Tabled failed to create.");
    }
}

-(void) insertRecordIntoTableNamed:(NSString *) tableName
                        withField1:(NSString *) field1
                       field1Value:(NSString *) field1Value
                         andField2:(NSString *) field2
                       field2Value:(NSString *) field2Value {
    
    /*
     NSString *sql = [NSString stringWithFormat:
     @"INSERT OR REPLACE INTO '%@' ('%@', '%@') "
     "VALUES ('%@','%@')", tableName, field1, field2,
     field1Value, field2Value];
     
     char *err;
     if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
     != SQLITE_OK) {
     sqlite3_close(db);
     NSAssert(0, @"Error updating table.");
     }
     */
    
    NSString *sqlStr = [NSString stringWithFormat:
                        @"INSERT OR REPLACE INTO '%@' ('%@', '%@') "
                        "VALUES (?,?)", tableName, field1, field2];
    const char *sql = [sqlStr UTF8String];
    
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [field1Value UTF8String],
                          -1, NULL);
        sqlite3_bind_text(statement, 2, [field2Value UTF8String],
                          -1, NULL);
    }
    
    
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating table.");
    sqlite3_finalize(statement);
    
}

-(void) getAllRowsFromTableNamed: (NSString *) tableName {
    //—-retrieve rows—-
    NSString *qsql = [NSString stringWithFormat:@"SELECT * FROM %@",
                      tableName];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( db, [qsql UTF8String], -1,
                           &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1Str =
            [[NSString alloc] initWithUTF8String: field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2Str =
            [[NSString alloc] initWithUTF8String: field2];
            
            NSString *str = [[NSString alloc] initWithFormat:@"%@ - %@",
                             field1Str, field2Str];
            NSLog(@"%@", str);
            myLabel.text = str;
            
            [field1Str release];
            [field2Str release];
            [str release];
        }
        
        //—-deletes the compiled statement from memory—-
        sqlite3_finalize(statement);
    }
}

- (void)viewDidLoad
{
    [self openDB];
    [self createTableNamed:@"Contacts"
                withField1:@"email"
                withField2:@"name"];
    for (int i=0; i<=2; i++) {
        NSString *email = [[NSString alloc] initWithFormat:
                           @"user%d@learn2develop.net",i];
        
        NSString *name = [[NSString alloc] initWithFormat: @"user %d",i];
        [self insertRecordIntoTableNamed:@"Contacts"
                              withField1:@"email" field1Value:email
                               andField2:@"name" field2Value:name];
        [email release];
        [name release];
    }
    
    [self getAllRowsFromTableNamed:@"Contacts"];
    sqlite3_close(db);
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [myLabel release];
    [super dealloc];
}
@end
