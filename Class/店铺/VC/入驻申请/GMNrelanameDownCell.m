//
//  GMNrelanameDownCell.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/19.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "GMNrelanameDownCell.h"
#import <AVFoundation/AVBase.h>
#import <AVFoundation/AVFoundation.h>

@implementation GMNrelanameDownCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.leftImg.clipsToBounds = YES;
    self.rightImg.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)rightClick:(UIButton *)sender {
//    image1 = @"no";
//    image2 = @"yes";
//    [self showphoto];
}

- (IBAction)leftClick:(UIButton *)sender {
    
//    image1 = @"yes";
//    image2 = @"no";
//    [self showphoto];
}

-(void)showphoto{
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    WEAK
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                NSString *errorStr = @"请您设置允许APP访问您的相机->设置->隐私->相机";
                [KEYWINDOW makeToast:errorStr duration:1 position:CSToastPositionCenter];

            }else{
                STRONG
                BOOL isOpen = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                if (isOpen) {
                    self->_imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;//相机获取照片
                    self->_imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;//相机捕获类型
                    self->_imagePickerController.delegate   = self;
                    [[YJLTools_sub getCurrentVC] presentViewController:self->_imagePickerController animated:YES completion:nil];
                }
            }
        }];
        
        UIAlertAction *deleteAction2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self->_imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            self->_imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self->_imagePickerController.delegate   = self;
            [[YJLTools_sub getCurrentVC] presentViewController:self->_imagePickerController animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
        }];
        [deleteAction setValue:MainColor forKey:@"titleTextColor"];
        [deleteAction2 setValue:MainColor forKey:@"titleTextColor"];
        [cancelAction setValue:RGB(67,67,67) forKey:@"titleTextColor"];
        [alertController addAction:deleteAction];
        [alertController addAction:deleteAction2];
        [alertController addAction:cancelAction];
        
        [[YJLTools_sub getCurrentVC] presentViewController:alertController animated:YES completion:nil];
        
    });
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // 获得原始的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
     NSLog(@"原始图片信息:%@",image);
    
    if ([image1 isEqualToString:@"yes"]) {
    
        self.leftImg.image = image;
        if (_photoBlcok) {
            self.photoBlcok([info objectForKey: @"UIImagePickerControllerOriginalImage"],0);
        }
    }
    
    if ([image2 isEqualToString:@"yes"]) {
        
        self.rightImg.image = image;
        if (_photoBlcok) {
            self.photoBlcok([info objectForKey: @"UIImagePickerControllerOriginalImage"],1);
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    GMNrelanameDownCell *cell = (GMNrelanameDownCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
@end
