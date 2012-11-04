//
//  MSImageCellBaseCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/11/04.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSImageCellBaseCell.h"

@implementation MSImageCellBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
