//
//  MSFoodLineCell.m
//  Meshi365
//
//  Created by Mlle.Irene on 2012/10/28.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "MSFoodLineCell.h"

@implementation MSFoodLineCell


- (void) layoutSubviews {
    [super layoutSubviews];
	// self.imageView.frame = CGRectMake(5, 5, self.imageView.image.size.width * self.imageView.image.scale / [[UIScreen mainScreen] scale], self.imageView.image.size.height * self.imageView.image.scale / [[UIScreen mainScreen] scale]);
	self.imageView.frame = CGRectMake(5, 5, 100,100);

    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
	//   self.imageView.layer.masksToBounds = YES;
    //self.imageView.cornerRadius = 5.0;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		self.imageView.image = [UIImage imageNamed:@"no_image.png"];

		int length = [UIScreen mainScreen].bounds.size.width-10;
		self.imageView.frame = CGRectMake(60,5,30, 30);
	
		
		self.imageView.contentMode = UIViewContentModeScaleAspectFill;
		self.imageView.clipsToBounds = YES;
	

		//self.textLabel.text = @"ほげ";
	
												 //	UIImageView image
		
		UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 20)];
        [name setFont:[UIFont systemFontOfSize:18]];
		name.text = @"Rice";
        
		[self addSubview:name];
        // accessory
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
