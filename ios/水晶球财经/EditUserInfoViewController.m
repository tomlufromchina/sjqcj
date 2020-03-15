//
//  EditUserInfoViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/1.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "UIViewExt.h"
#import "UIButton+setBackGroundImage.h"
#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"


typedef void(^ShowImageblockType)(NSArray*); //我定义这block类型 为了获取从QBImagePicker中选取的全部图片

@interface EditUserInfoViewController ()<UITextViewDelegate>
{
    UIImage* _headImage;  //保存选取的图片
    NSString* _filePath; //保存选取的图片的路径
    BOOL _isChangeHeadImage; //判断是否更换了头像
}

@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APPBackColor;
    // Do any additional setup after loading the view from its nib.
    self.line0View.width = SCREENWIDTH;
    self.line0View.top = 0;
    self.headImageView.image = self.headImage;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHeaderImage)];
    self.headImageView.userInteractionEnabled = YES;
    [self.headImageView addGestureRecognizer:tap];
    
    
    if(self.sex){
        [self.sexButton0 setBackgroundImage:[UIImage imageNamed:@"sex_taped"]];
        [self.sexButton1 setBackgroundImage:[UIImage imageNamed:@"sex_untap"]];
    }else{
        [self.sexButton0 setBackgroundImage:[UIImage imageNamed:@"sex_untap"]];
        [self.sexButton1 setBackgroundImage:[UIImage imageNamed:@"sex_taped"]];
    }
    
    //油风 股市菜鸟
    self.lineView.width = SCREENWIDTH;
    self.line2View.width = SCREENWIDTH;
    
    self.nameTF.placeholder = self.old_name;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.text = self.describStr;
    self.textView.tintColor = [UIColor lightGrayColor];
    self.textView.delegate = (id)self;
    
    //按钮响应
    [self.sexButton0 addTarget:self action:@selector(button0Action) forControlEvents:UIControlEventTouchUpInside];
    [self.sexButton1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认修改" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonAction)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 性别 button ancion
-(void)button0Action
{

    UIImage* pImage = [UIImage imageNamed:@"sex_taped"]; //被点击的图片
    if([self.sexButton0.currentBackgroundImage isEqual:pImage]){
        return;
    }
    
    UIImage* tempImage0 = self.sexButton0.currentBackgroundImage;
    UIImage* tempImage1 = self.sexButton1.currentBackgroundImage;
    [self.sexButton0 setBackgroundImage:tempImage1];
    [self.sexButton1 setBackgroundImage:tempImage0];
    
   
}


-(void)button1Action
{
    UIImage* pImage = [UIImage imageNamed:@"sex_taped"]; //被点击的图片
    if([self.sexButton1.currentBackgroundImage isEqual:pImage]){
        return;
    }

    UIImage* tempImage0 = self.sexButton0.currentBackgroundImage;
    UIImage* tempImage1 = self.sexButton1.currentBackgroundImage;
    [self.sexButton0 setBackgroundImage:tempImage1];
    [self.sexButton1 setBackgroundImage:tempImage0];
   
}
#pragma mark -- textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textView.text = nil;
    self.textView.textColor = [UIColor blackColor];
}

//确认修改资料
-(void)sureButtonAction
{
    BOOL flag = [self verdictInputItem]; //判断输入项 是否为空
    if(flag){
        [self show];
        [self uploadData]; //上传修改信息
        [self uploadHeadImage:_headImage]; //上传 修改用户头像
    }
}


-(BOOL)verdictInputItem
{
    if(self.nameTF.text.length == 0){
        [self showAlert:nil message:@"必须输入姓名额"];
        return NO;
    }
       return YES;
}



#pragma mark -- 点解了头像的UIImageView
-(void)changeHeaderImage
{
    [self getPhoto]; //获取照片
    
}

#pragma mark -- 获取照片
-(void) getPhoto
{
    NSString * cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString * albumButtonTitle = NSLocalizedString(@"相册", nil);
    NSString * phoneButtonTitle = NSLocalizedString(@"拍照", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择获取方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //点击取消响应
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消");
    }];
    
    //点击相册响应
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:albumButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了相册");
        [self LocalPhoto];
    }];
    
    //点击拍照响应
    UIAlertAction* phoneAction = [UIAlertAction actionWithTitle:phoneButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了拍照");
        [self takePhoto];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:albumAction];
    [alertController addAction:phoneAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = (id)self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        _filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:nil completion:nil];
        self.headImageView.image = image;
        _headImage = image; //保存这个image
        
        _isChangeHeadImage = YES;  //状态，已经更换过了图片
      
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- ==========上传修改信息==========
-(void)uploadData
{
    int sex;
    if([self.sexButton0.currentBackgroundImage isEqual:[UIImage imageNamed:@"sex_taped"]]){
        sex = 1; //男
    }else{
        sex = 2; //女
    }
    UIImage* tempImage0 = self.sexButton0.currentBackgroundImage;
    UIImage* tempImage1 = self.sexButton1.currentBackgroundImage;
    [self.sexButton0 setBackgroundImage:tempImage1];
    [self.sexButton1 setBackgroundImage:tempImage0];
    
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_ChangeInfo];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:self.old_name forKey:@"old_name"];
    [parameterDic setObject:self.nameTF.text forKey:@"uname"];
    [parameterDic setObject:[NSString stringWithFormat:@"%@",self.textView.text] forKey:@"intro"];
    [parameterDic setObject:[NSString stringWithFormat:@"%d",sex] forKey:@"sex"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        if([jsonDic[@"status"] isEqual:@1]){
            [self showAlert:nil message:@"修改资料成功!"];
        }

        [self dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"精华帖请求错误%@",error);
    }];
}

#pragma mark -- 网络请求 上传后 跟新头像
-(void)uploadHeadImage:(UIImage*)image
{
    if(_isChangeHeadImage){ //如果没有图片 上传图片网络请求   //[self.headImageView.image isEqual:PLACEHOLDERIMAGE])
        
        NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_UploadHeadImage];
        NSMutableDictionary* parameterDic = [NSMutableDictionary new];
        
        [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
        [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
        
        //有风
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager POST:url parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"Filedata" fileName:_filePath mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation * operation, id responseObject) {
            NSDictionary* jsonDic = responseObject;
            NSLog(@"上传头像返回数据为：%@",jsonDic);
            if([jsonDic[@"status"]isEqualToString:@"1"]){ //如果上传头像图片成功，修改头像
                NSDictionary* imageInfo = [jsonDic valueForKey:@"data"];
                [self changeHeadWithNewImage:imageInfo];
            }//有风
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"上传头像操作失败:%@",error);
        }];
    } //如果没有选取相册，不上传图片
}

#pragma mark -- 网络请求 根据返回的新图片信息 修改头像
-(void)changeHeadWithNewImage:(NSDictionary*)imageInfo
{
    NSString* url = [CommonMethod UrlAddAction:Url_UserInfo_ChangeHeadImage];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[imageInfo valueForKey:@"picurl"] forKey:@"picurl"];  //图片路径
    [parameterDic setObject:[imageInfo valueForKey:@"picwidth"] forKey:@"picwidth"];  //图片宽度
    [parameterDic setObject:[imageInfo valueForKey:@"fullpicurl"] forKey:@"fullpicurl"]; //图片绝路径
    [parameterDic setObject:@"0" forKey:@"x1"];   // 选择区域左上角x轴坐标
    [parameterDic setObject:@"0" forKey:@"y1"];   // 选择区域左上角y轴坐标
    [parameterDic setObject:[imageInfo valueForKey:@"picwidth"] forKey:@"x2"];  // 选择区域右下角x轴坐标
    [parameterDic setObject:[imageInfo valueForKey:@"picheight"] forKey:@"y2"];  // 选择区域右下角y轴坐标
    [parameterDic setObject:[imageInfo valueForKey:@"picwidth"] forKey:@"w"];  // 选择区的宽度
    [parameterDic setObject:[imageInfo valueForKey:@"picheight"] forKey:@"h"];  // 选择区的高度
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
      //  [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"Filedata" fileName:_filePath mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSDictionary* jsonDic =responseObject;
        NSLog(@"更改头像返回数据为：%@",jsonDic);
        if([jsonDic[@"status"]isEqual:@1]){
            NSLog(@"修改用户头像成功!");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"更改头像操作失败:%@",error);
    }];

}


#pragma mark --辅助方法
-(void)showAlert:(NSString*)title
         message:(NSString*)message
{
    
    if(title==nil){
        title = @"提示";
    }
    if(message==nil){
        message = @"正在开发...";
    }
    
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //点击取消的响应
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    //点击确定的响应
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- 上传图片
//- (void) UpLoadImage :(UIImage*) image
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    //    UIImage * image1 = [UIImage imageNamed:image];
//    NSData* data  = UIImagePNGRepresentation(image);
//    
//    
//    //准备发送请求
//    
//    //ip地址
//    NSString* sufStr = @"file/upload-file";
//    NSString* URLstr = [NSString stringWithFormat:@"%@%@",MAIN_URL,sufStr];
//    
//    NSString *company = @"6F79078F79D77550739EF61CD0DC2A83";
//    NSString * noncestr = [URLViewController ret32bitString];//32位随机数
//    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;//毫秒时间戳
//    
//    NSString * urlStr1 = [NSString stringWithFormat:@"company=%@&nonce_str=%@&timeStamp=%llu&key=smartlink",company,noncestr,recordTime];
//    
//    NSString * str =[MyMD5 md5:urlStr1];
//    
//    NSString * urlStr2 = [NSString stringWithFormat:@"%@?company=%@&nonce_str=%@&timeStamp=%llu&sign=%@&client=IOS",URLstr,company,noncestr,recordTime,str];
//    
//    //图片保存在本地的路径
//    NSString *imagePath2 = [filePath stringByReplacingOccurrencesOfString:@"/image.png" withString:@".png"];
//    [imagePath2 stringByAppendingString:@"/save.png"];
//    
//    NSArray * userInfo =[[NSUserDefaults standardUserDefaults]valueForKey:@"loging"];
//    NSString* userid =[userInfo valueForKey:@"storeId"];
//    
//    //参数
//    NSDictionary *dic=@{@"oldImageRealPath":@"",
//                        @"id":userid};
//    
//    //发送网络请求
//    [manager POST:urlStr2 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:data name:@"file" fileName:imagePath2 mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
//        
//        NSLog(@"上传成功");
//        NSString *requestTmp = [NSString stringWithString:operation.responseString];
//        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
//        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
//        if(progress)
//        {
//            [progress removeFromSuperview];
//            progress = nil;
//        }
//        NSInteger defaultImg;
//        NSString * content = [[NSString alloc]init];
//        if (imagepicker ==1) {
//            defaultImg = 1;//[[imagearray[imageindex] valueForKey:@"id"]integerValue];
//            content = self.imageText_textview.text;
//        }else{
//            defaultImg =2;// [[imagearray[imageindex+1] valueForKey:@"id"]integerValue];
//            content =contentcell;
//        }
//        
//        NSString *imageurl = [dic[@"message"] valueForKey:@"imgUrl"];
//        NSString *imgRealPath = [dic[@"message"] valueForKey:@"imgRealPath"];
//        NSMutableDictionary* tempDIc = [[NSMutableDictionary alloc]init];
//        [tempDIc setObject:imageurl forKey:@"imgUrl"];
//        [tempDIc setObject:imgRealPath forKey:@"imgRealPath"];
//        [tempDIc setObject:@(defaultImg) forKey:@"defaultImg"];
//        [tempDIc setObject:content forKey:@"content"];
//        if (imagepicker ==1&&imagearray.count>0) {
//            [imagearray replaceObjectAtIndex:0 withObject:tempDIc];
//        }else{
//            [imagearray replaceObjectAtIndex:imageindex+1 withObject:tempDIc];
//        }
//        
//        
//        [self.imageText_tableview reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"上传失败");
//        if(progress)
//        {
//            [progress removeFromSuperview];
//            progress = nil;
//        }
//        
//    }];
//
//}

@end
