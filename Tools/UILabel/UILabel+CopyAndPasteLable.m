//
//  UILabel+CopyAndPasteLable.m
//
//
//  Created by yanjijlin on 2018/4/17.
//  Copyright © 2018年 selice. All rights reserved.
//

#import "UILabel+CopyAndPasteLable.h"
#import <objc/runtime.h>

@implementation UILabel (CopyAndPasteLable)

-(void)setIsPasteable:(BOOL)isPasteable
{
    objc_setAssociatedObject(self, @selector(isPasteable), [NSNumber  numberWithBool:isPasteable], OBJC_ASSOCIATION_ASSIGN);
    if (isPasteable) {
        [self   addCopyGesture];
    }
}
-(BOOL)isPasteable
{
    return [objc_getAssociatedObject(self, @selector(isPasteable)) boolValue];
}

-(void)setIsCopyable:(BOOL)number
{
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber  numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    if (number) {
        [self   addCopyGesture];
    }
}
-(BOOL)isCopyable
{
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

-(void)addCopyGesture
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPre:)];
    [self addGestureRecognizer:longPress];
}

- (void)longPre:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state != UIGestureRecognizerStateBegan)
    {
        return;
    };
    [self becomeFirstResponder];
    if (self.isCopyable && self.isPasteable) {
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(behaviorCopyAction:)];
        UIMenuItem *paste = [[UIMenuItem  alloc] init];
        paste.title = @"粘贴";
        paste.action = @selector(pasteAction:);
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copy, paste,nil]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }else if (self.isCopyable){
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(behaviorCopyAction:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copy,nil]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }else if (self.isPasteable){
                UIMenuItem *paste = [[UIMenuItem  alloc] init];
                paste.title = @"粘贴";
                paste.action = @selector(pasteAction:);
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:paste,nil]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(behaviorCopyAction:)) {
         return YES;
    }else if(action == @selector(pasteAction:)){
        return YES;
    }else{
        return NO;
    }
   
}

- (void)behaviorCopyAction:(UIMenuItem *)sender{
     UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    if (self.text) {
        pasteBoard.string = self.text;
    }else{
        pasteBoard.string = self.attributedText.string;
    }
}

-(void)pasteAction:(UIMenuItem *)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    self.text = pasteBoard.string;
}

@end
