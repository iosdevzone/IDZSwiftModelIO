//
//  ModelIOCategories.h
//  ModelView
//
//  Created by Danny Keogan on 5/29/16.
//  Copyright © 2016 iOS Developer Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ModelIO/ModelIO.h>

@interface MDLMaterial (Safe)

@property (readonly) NSArray<MDLMaterialProperty *> *idz_properties;

@end