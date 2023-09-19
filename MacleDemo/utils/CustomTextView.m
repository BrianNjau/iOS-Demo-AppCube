//
//  CustomTextView.m
//  MacleDemo
//
//  Created by Macle
//

#import "CustomTextView.h"

@implementation CustomTextView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setDefaultInputAccessoryViewWithTarget:self action:@selector(numberFieldCancle)];
}

- (void)setDefaultInputAccessoryViewWithTarget:(id)target action:(SEL) action{
    UIToolbar *toolBar =[UIToolbar new];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"finish" style:UIBarButtonItemStyleDone target:target action:action];
    doneBtn.tintColor=[UIColor blueColor];
    NSArray*items =@[flexSpace,doneBtn];
    toolBar.items= items;
    [toolBar sizeToFit];
    self.inputAccessoryView = toolBar;
}
 
- (void)numberFieldCancle{
    [self resignFirstResponder];  //hide keyboard
}

@end
