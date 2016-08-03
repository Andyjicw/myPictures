//
//  DB.h
//  myPicture
//
//  Created by andy on 16/5/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface DB : NSObject

-(NSMutableArray *) DBGetTablePicture;

-(BOOL) DBSetTablePicture:(NSArray *) arr isDel:(BOOL)isDel;

@end
