//
//  EditWeiBoViewController.m
//  水晶球财经
//
//  Created by Tom lu on 15/11/1.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "EditWeiBoViewController.h"
#import "FaceBoard.h"
#import "UIViewExt.h"

#import "CommonMethod.h"
#import "AFNetworking.h"
#import "UserInfo.h"
#import "UIImage+scaleSize.h"
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h" //图片上传
#define kTextViewFontSize 18
@interface EditWeiBoViewController ()<UITextViewDelegate>
{
    UIView* _keyBoradSubView;
    UIButton* _faceButton;
    UIButton* _openImageButton;
    UIButton* _aiteButton;
    FaceBoard* _faceBoard;
    
    
    NSString* _filePath; //保存获取到的图片的位置
    NSMutableArray* _imagesArray;    //保存选取的本地图片
    NSMutableArray* _imageIDArray;   //保存选取的本地图片  上传后  返回的 id
    int     _tapedCount;    //被点击的imageView的tag值

    
    UIImageView* _imageView1;
    UIImageView* _imageView2;
    UIImageView* _imageView3;
    UIImageView* _imageView4;
    UIImageView* _imageView5;
    UIImageView* _imageView6;
    UIImageView* _imageView7;
    UIImageView* _imageView8;
    UIImageView* _imageView9;
    
}

@end

@implementation EditWeiBoViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    //鍵盤将要出現
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    
    //键盘将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = APPBackColor;
    self.view.width = SCREENWIDTH;
    self.view.height = SCREENHEIGHT;
    
    //处理nav 右上方item
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发表微博" style:UIBarButtonItemStylePlain target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //scrollView 增加 tap手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTouched:)];
    [self.scrollView addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view from its nib.
    self.scrollView.width = SCREENWIDTH;
    self.scrollView.height = SCREENHEIGHT;
    
    self.contentTV.width = SCREENWIDTH - self.contentTV.left * 2;
    self.contentTV.delegate = (id)self;
    self.contentTV.layer.borderWidth = 1;
    self.contentTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.fastTV.textColor = [UIColor blackColor];
    self.contentTV.left = 25;
    self.contentTV.height = 100;
    self.contentTV.font = [UIFont systemFontOfSize:kTextViewFontSize];
    self.contentTV.textColor = [UIColor blackColor];
    [self.contentTV becomeFirstResponder];

    
    
    //增加placeholder
    UILabel* placeHoldLabel = [UILabel new];
    placeHoldLabel.width = 80;
    placeHoldLabel.height = 10;
    [self.contentTV addSubview:placeHoldLabel];
    placeHoldLabel.left = 7;
    placeHoldLabel.top = 12;
    placeHoldLabel.text = @"正文";
    placeHoldLabel.font = [UIFont systemFontOfSize:14];
    placeHoldLabel.textColor = [UIColor clearColor];
    placeHoldLabel.enabled = NO;
    [placeHoldLabel setTag:1111];
    
     [self buildUI];
    _imagesArray = [[NSMutableArray alloc]init];  //装照片的数组 空数组
    _imageIDArray = [[NSMutableArray alloc]init];  //装照片ID
    _tapedCount = 0;
   
}

-(void)buildUI
{
    self.contentTV.delegate = (id)self;
    //增加键盘附加视图 动画显示效果
    _keyBoradSubView = [UIView new];
    [self.view addSubview:_keyBoradSubView];
    _keyBoradSubView.width = SCREENWIDTH;
    _keyBoradSubView.height = 50;
    _keyBoradSubView.left = 0;
    _keyBoradSubView.top = self.view.frame.size.height;
    _keyBoradSubView.layer.borderColor = RGB(221, 224, 227).CGColor;
    _keyBoradSubView.backgroundColor = RGB(249, 249, 249);

    //增加表情按钮按钮
    _faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_faceButton];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"笑脸"] forState:UIControlStateNormal];
    _faceButton.width = _faceButton.height = 30;
    _faceButton.top = 10;
    _faceButton.left = 20;
    [_faceButton addTarget:self action:@selector(faceButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //打开图片按钮
    _openImageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_openImageButton];
    [_openImageButton setBackgroundImage:[UIImage imageNamed:@"打开图片"] forState:UIControlStateNormal];
    _openImageButton.width = _openImageButton.height = 30 ;
    _openImageButton.top = 10;
    _openImageButton.centerX = SCREENWIDTH * 0.5;
    [_openImageButton addTarget:self action:@selector(openButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //    _aiteButton =[UIButton buttonWithType:UIButtonTypeCustom];
    //    [_keyBoradSubView addSubview:_aiteButton];
    //    [_aiteButton setBackgroundImage:[UIImage imageNamed:@"艾特"] forState:UIControlStateNormal];
    //    _aiteButton.width = _openImageButton.height = 30 ;
    //    _aiteButton.top = 10;
    //    _aiteButton.right = 240;
    //    [_aiteButton addTarget:self action:@selector(aiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //表情相关处理
    _faceBoard = [[FaceBoard alloc]init];
    _faceBoard.inputTextView = (id)self.contentTV;
    [self.view addSubview:_faceBoard];
    _faceBoard.left = 0;
    _faceBoard.bottom = self.view.height-64;
    _faceBoard.hidden = YES;
    
    //@相关处理
    _aiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_keyBoradSubView addSubview:_aiteButton];
    [_aiteButton setBackgroundImage:[UIImage imageNamed:@"艾特"] forState:UIControlStateNormal];
    _aiteButton.width = _aiteButton.height = 30;
    _aiteButton.top = 10;
    _aiteButton.right = SCREENWIDTH - 20;
    [_aiteButton addTarget:self action:@selector(aiteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //imageView 显示图片处理  图片之间 间隔5point  一行最多4张图片
    CGFloat imageWidth = (self.contentTV.width - 25) * 0.25;
    
    _imageView1 = [UIImageView new];
    [self.scrollView addSubview:_imageView1];
    _imageView1.tag = 1;
    _imageView1.width = _imageView1.height = imageWidth;
    _imageView1.left =  25+ 5;
    _imageView1.top = self.contentTV.bottom + 5;
    _imageView1.image = [UIImage imageNamed:@"虚线方格"];
    _imageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView1 addGestureRecognizer:tap1];
    
    _imageView2 = [UIImageView new];
    [_imageView2 setTag:2];
    _imageView2.width = _imageView2.height = imageWidth;
    [self.scrollView addSubview:_imageView2];
    _imageView2.left =  _imageView1.right + 5;
    _imageView2.top = self.contentTV.bottom + 5;
    _imageView2.image = [UIImage imageNamed:@"虚线方格"];
    _imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView2 addGestureRecognizer:tap2];
    
    
    _imageView3 = [UIImageView new];
    [_imageView3 setTag:3];
    _imageView3.width = _imageView3.height = imageWidth;
    [self.scrollView addSubview:_imageView3];
    _imageView3.left =  _imageView2.right + 5;
    _imageView3.top = self.contentTV.bottom + 5;
    _imageView3.image = [UIImage imageNamed:@"虚线方格"];
    _imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView3 addGestureRecognizer:tap3];
    
    _imageView4 = [UIImageView new];
    [_imageView4 setTag:4];
    _imageView4.width = _imageView4.height = imageWidth;
    [self.scrollView addSubview:_imageView4];
    _imageView4.left =  _imageView3.right + 5;
    _imageView4.top = self.contentTV.bottom + 5;
    _imageView4.image = [UIImage imageNamed:@"虚线方格"];
    _imageView4.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView4 addGestureRecognizer:tap4];
    
    _imageView5 = [UIImageView new];
    [_imageView5 setTag:5];
    _imageView5.width = _imageView5.height = imageWidth;
    [self.scrollView addSubview:_imageView5];
    _imageView5.left =  25 + 5;
    _imageView5.top = _imageView1.bottom + 5;
    _imageView5.image = [UIImage imageNamed:@"虚线方格"];
    _imageView5.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView4 addGestureRecognizer:tap5];
    
    _imageView6 = [UIImageView new];
    [_imageView6 setTag:6];
    _imageView6.width = _imageView6.height = imageWidth;
    [self.scrollView addSubview:_imageView6];
    _imageView6.left =  _imageView5.right +  5;
    _imageView6.top = _imageView5.top;
    _imageView6.image = [UIImage imageNamed:@"虚线方格"];
    _imageView6.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView5 addGestureRecognizer:tap6];
    
    _imageView7 = [UIImageView new];
    [_imageView7 setTag:7];
    _imageView7.width = _imageView7.height = imageWidth;
    [self.scrollView addSubview:_imageView7];
    _imageView7.left =  _imageView6.right +  5;
    _imageView7.top = _imageView6.top;
    _imageView7.image = [UIImage imageNamed:@"虚线方格"];
    _imageView7.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView7 addGestureRecognizer:tap7];
    
    _imageView8 = [UIImageView new];
    [_imageView8 setTag:8];
    _imageView8.width = _imageView8.height = imageWidth;
    [self.scrollView addSubview:_imageView8];
    _imageView8.left =  _imageView6.right +  5;
    _imageView8.top = _imageView7.top;
    _imageView8.image = [UIImage imageNamed:@"虚线方格"];
    _imageView8.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView8 addGestureRecognizer:tap8];
    
    _imageView9 = [UIImageView new];
    [_imageView9 setTag:9];
    _imageView9.width = _imageView9.height = imageWidth;
    [self.scrollView addSubview:_imageView9];
    _imageView9.left =  _imageView1.left;
    _imageView9.top = _imageView5.bottom + 5;
    _imageView9.image = [UIImage imageNamed:@"虚线方格"];
    _imageView9.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap9 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_imageView9 addGestureRecognizer:tap9];
    
    _imageView1.hidden = NO;
    _imageView2.hidden = YES;
    _imageView3.hidden = YES;
    _imageView4.hidden = YES;
    _imageView5.hidden = YES;
    _imageView6.hidden = YES;
    _imageView7.hidden = YES;
    _imageView8.hidden = YES;
    _imageView9.hidden = YES;
    
    
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark -- 发微博响应
-(void)publishAction
{
    if(self.contentTV.text.length ==0){
        [self showAlert:@"提示" message:@"请先输入微博内容"];
        return;
    }
    
    [self uploadShortWeiBoData]; //上传短微博
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 键盘通知回调
-(void)keyboardWillShown:(NSNotification*)aNotification
{
    NSLog(@"键盘要出现");
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    [UIView animateWithDuration:0.5 animations:^{
        if(self.contentTV.isFirstResponder==YES){
          _keyBoradSubView.bottom = self.view.frame.size.height - kbSize.height ;
            _keyBoradSubView.hidden = NO;
        }else{
            _keyBoradSubView.hidden = YES;
        }
    }];
    
}

-(void)keyboardWillHide:(NSNotification*)aNotification
{
    NSLog(@"键盘要隐藏了");
    _keyBoradSubView.bottom = self.view.frame.size.height + 50;
}




#pragma mark -- 表情库处理

-(void)faceButtonAction
{
    [self.contentTV resignFirstResponder];
    _faceBoard.hidden = NO;
}


#pragma mark -- textView delegate
- (void)textViewDidChange:(UITextView *)textView
{
   UILabel* pLabel = [self.contentTV viewWithTag:1111];
    
    if(pLabel){
        [pLabel removeFromSuperview];
        pLabel = nil;
    }
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.contentTV resignFirstResponder];
    if(_faceBoard.hidden == NO){
        [_faceBoard setHidden:YES];
    }
}


-(void)openButtonAction //打开相册
{
    int count = (int)[_imagesArray count];
    _tapedCount = count+1;
    [self getPhoto];
}

-(void)aiteButtonAction //@某个人
{
    
}

#pragma mark -- ScrollView touch
-(void)scrollViewTouched:(UITapGestureRecognizer*)tap
{
    [self.contentTV resignFirstResponder];
}


#pragma mark -- ========== 打开照片相关函数 ==========
#pragma mark -- 获取图片产生AlertController  在button Action中调用这个方法
-(void) getPhoto
{
    NSString * cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString * albumButtonTitle = NSLocalizedString(@"相册", nil);
    NSString * phoneButtonTitle = NSLocalizedString(@"拍照", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择获取方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //点击取消响应
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    //点击相册响应
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:albumButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self LocalPhoto];
    }];
    
    //点击拍照响应
    UIAlertAction* phoneAction = [UIAlertAction actionWithTitle:phoneButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
        //对图片压缩
        image = [UIImage scaleImage:image toScale:0.1];
        
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
       
        
        
        
        //计算保存个数
        int imageCount = (int)[_imagesArray count];
        
        //下个显示
        if(_tapedCount ==  (imageCount+1) ){ //点击了最后一张图片，如果点击的图片是3，同时数组里有三张图片
            UIImageView* nextImageView =  (UIImageView*)[self.scrollView viewWithTag:(imageCount+2)];
            if(nextImageView.hidden==YES){
                nextImageView.hidden = NO;
            }
            //这个改变图片
            UIImageView* currentImageView =  (UIImageView*)[self.scrollView viewWithTag:(imageCount+1)];
            currentImageView.image = image;
             [_imagesArray addObject:image]; //增加数组
             [self uploadimage:image imagePath:_filePath]; //发送请求
        }else{  //如果不是点击的最后一张图片，而是其他图片 那么 删除被点击的图片，同时在对应的imageView上显示最后一个数组元素
            [_imagesArray removeObjectAtIndex:(_tapedCount-1)];
            [_imagesArray addObject:image];
             [self uploadimage:image imagePath:_filePath]; //发送请求
            UIImageView* pImageView = [self.scrollView viewWithTag:_tapedCount];
            pImageView.image = image;
        }
       
        
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- 计算textView中文本的高度
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    if(value==nil || value.length ==0){
        return 0;
    }else{
        UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
        detailTextView.font = [UIFont systemFontOfSize:fontSize];
        detailTextView.text = value;
        CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
        return deSize.height;
    }
   
}

#pragma mark -- textViewdelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"111");
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
     NSLog(@"222");
}

#pragma makr -- 增加的图片的手势响应
-(void)tapAction:(id)sender
{
    UITapGestureRecognizer* pTap = sender;
    UIImageView* pImageView = (UIImageView*)pTap.view;
    _tapedCount = (int)pImageView.tag;
    [self getPhoto];
}

//提示框  这个方法 只能在当前类中使用
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

#pragma mark -- ===============网路请求================
#pragma mark -- 图片上传
-(void)uploadimage:(UIImage*)tempImage
         imagePath:(NSString*)imagePath
{
    NSString* url = [CommonMethod UrlAddAction:Url_Bar_ShortPost_UploadImage];
    NSMutableDictionary* parameterDic = [NSMutableDictionary dictionary];
    
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:@"feed_image" forKey:@"attach_type"];
    [parameterDic setObject:@"1" forKey:@"thumb"];
    [parameterDic setObject:@"image" forKey:@"upload_type"];
    
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 10.0f; //超时
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json" , @"text/json" , @"text/javascript" , @"text/html" , nil];
    
    [manager POST:url parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        
          [formData appendPartWithFileData:UIImageJPEGRepresentation(tempImage, 1.0) name:@"attach" fileName:imagePath mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        //NSLog(@"上传操作结果：%@",responseObject[@"info"]);
       // NSLog(@"返回内容是:%@",responseObject);
      
        if([responseObject[@"status"] isEqual:@1]){
            NSString* ID = [responseObject[@"data"] valueForKey:@"attach_id"]; //获取到图片ID
            //判断点击了哪张图片
            if(_tapedCount==_imagesArray.count){ //如果点击的是租后一张，直接加入数组
                [_imageIDArray addObject:ID];
            }else{
                [_imageIDArray removeObjectAtIndex:(_tapedCount-1)];
                [_imageIDArray addObject:ID];
            }
            
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传操作失败:%@",error);
    }];
}

#pragma mark -- 发段=短微博网络请求
-(void)uploadShortWeiBoData
{
    NSString* url = [CommonMethod UrlAddAction:Url_Bar_ShortPost_Upload];
    NSMutableDictionary* parameterDic = [NSMutableDictionary new];
    [parameterDic setObject:[UserInfo sharedInfo].userId forKey:@"mid"];
    [parameterDic setObject:[UserInfo sharedInfo].userPwd forKey:@"login_password"];
    
     if([_imageView1.image isEqual:[UIImage imageNamed:@"虚线方格"]] &&  _imageView2.hidden == YES){
         [parameterDic setObject:@"post" forKey:@"type"];
     }else{
          [parameterDic setObject:@"postimage" forKey:@"type"];
     }
    [parameterDic setObject:self.contentTV.text forKey:@"body"];
    [parameterDic setObject:@"public" forKey:@"app_name"];
    [parameterDic setObject:@"postimage" forKey:@"type"];

    
    NSString* allIamgesIDString = @"|";
    
    if(_imageIDArray.count==0){
        allIamgesIDString = @"";
    }
    for(int i = 0; i < [_imageIDArray count]; i++){
        NSString* oneImageStr = [_imageIDArray objectAtIndex:i];
        oneImageStr = [NSString stringWithFormat:@"%@|",oneImageStr];
        allIamgesIDString = [allIamgesIDString stringByAppendingString:oneImageStr];
    }
    NSLog(@"%@",allIamgesIDString);
    [parameterDic setObject:allIamgesIDString forKey:@"attach_id"];
    NSLog(@"参数=%@",parameterDic);
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager new];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameterDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary* jsonDic =[CommonMethod serializdDictionaryWithResponseObject:responseObject];
        NSLog(@"%@",jsonDic[@"info"]);
        [self dismiss];
        if([jsonDic[@"status"]isEqual:@1]){
            [self showAlert:@"提示" message:@"发送成功"];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self showError];  //只显示失败 成功不显示了
        NSLog(@"精华帖请求错误%@",error);
    }];

}
@end
