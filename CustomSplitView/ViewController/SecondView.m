//
//  SecondView.m
//  CustomSplitView
//
//  Created by Pantech - Milan on 05/03/13.
//  Copyright (c) 2013 com.pantech. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor magentaColor]];
        
        UILabel *customTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 200, 200)];
        customTextLabel.text = @"second view";
        [customTextLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [customTextLabel setTextAlignment:UITextAlignmentCenter];
        [customTextLabel setTextColor:[UIColor darkGrayColor]];
        [customTextLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:customTextLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
