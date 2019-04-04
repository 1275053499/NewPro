//
//  GMNrelanameDownCell.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/19.
//  Copyright © 2018 yanjinlin. All rights reserved.
//  220

#import <UIKit/UIKit.h>

@interface GMNrelanameDownCell : UITableViewCell<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    UIImagePickerController *_imagePickerController;
    NSString *image1;
    NSString *image2;
    
}
@property (weak, nonatomic) IBOutlet UIImageView    *leftImg;
@property (weak, nonatomic) IBOutlet UIButton       *leftBtn;
@property (weak, nonatomic) IBOutlet UIImageView    *rightImg;
@property (weak, nonatomic) IBOutlet UIButton       *rightBtn;

@property(nonatomic,strong) void(^photoBlcok)(UIImage *image,NSInteger index);//初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView;//注册xib

@end

