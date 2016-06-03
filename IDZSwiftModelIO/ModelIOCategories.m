//
//  ModelIOCategories.m
//  ModelView
//
//  Created by Danny Keogan on 5/29/16.
//  Copyright © 2016 iOS Developer Zone. All rights reserved.
//

#import "ModelIOCategories.h"

@implementation MDLMaterial (Safe)

- (NSArray<MDLMaterialProperty *> *)idz_properties {
    NSMutableArray* retval = [[NSMutableArray alloc] init];
    for (MDLMaterialProperty* property in self) {
        [retval addObject:property];
    }
    return retval;
}

@end