//
//  CoreDataModel+CoreDataProperties.h
//  ListenFM
//
//  Created by lanouhn on 16/3/22.
//  Copyright © 2016年 Orange. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
