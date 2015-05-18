//
//  ContractType.h
//  
//
//  Created by Patryk Kaczmarek on 18/05/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface ContractType : NSManagedObject

@property (nonatomic, retain) NSNumber * uod;
@property (nonatomic, retain) NSNumber * uop;
@property (nonatomic, retain) NSNumber * dg;
@property (nonatomic, retain) NSSet *user;
@end

@interface ContractType (CoreDataGeneratedAccessors)

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end
