//
//  SEViewController.m
//  水晶球财经
//
//  Created by 罗海方 on 15/11/24.
//  Copyright © 2015年 com.sjqcj. All rights reserved.
//

#import "SEViewController.h"
#import "SEInputAccessoryView.h"
#import "SEStampInputView.h"
#import "SEPhotoView.h"
#import "SETextView.h"
#import "UIViewExt.h"

static const CGFloat defaultFontSize = 18.0f;

@interface SEViewController ()<SETextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SETextView *textView;
@property(nonatomic,strong)UILabel* placeholder;  //textView的placeholder

@property (nonatomic) SEInputAccessoryView *inputAccessoryView;
@property (nonatomic) SEStampInputView *imageInputView;

@property (nonatomic) id normalFont;
@property (nonatomic) id boldFont;



@end

@implementation SEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    self.scrollView.delegate = (id)self;
    self.textView.delegate = (id)self;
    self.textView.backgroundColor = RGB(240, 240, 242);
    
    
    
    self.imageInputView = [[[UINib nibWithNibName:@"SEStampInputView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    [self.imageInputView.button0 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button1 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button2 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button3 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button4 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button5 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button6 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button7 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button8 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button9 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button10 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button11 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button12 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button13 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button14 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button15 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button16 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button17 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button18 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button19 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button20 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button21 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button22 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button23 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button24 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button25 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button26 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button27 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button28 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button29 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button30 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button31 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button32 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button33 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button34 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button35 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button36 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button37 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button38 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button39 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button40 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button41 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button42 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button43 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button44 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button45 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button46 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button47 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button48 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button49 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button50 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button51 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button52 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button53 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button54 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button55 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button56 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button57 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button58 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button59 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button60 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button61 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button62 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button63 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button64 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button65 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button66 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button67 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button68 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button69 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button70 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button71 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button72 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button73 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button74 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button75 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button76 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button77 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button78 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button79 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button80 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button81 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button82 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button83 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button84 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button85 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button86 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button87 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button88 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button89 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button90 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button91 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button92 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button93 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button94 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button95 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button96 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button97 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button98 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button99 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button100 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button101 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button102 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button103 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button104 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button105 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button106 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button107 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button108 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button109 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button110 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageInputView.button111 addTarget:self action:@selector(stamp:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    
    self.inputAccessoryView = [[[UINib nibWithNibName:@"SEInputAccessoryView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
#pragma mark -- 根据eidteStyle属性 设置是否改变UI属性   必须在这里进行设置额
    //处理当前VC的编辑类型，部分不能发图片等等
    if(self.editeStyle==EditeStyleShortWeiBo){ //如果是段微博  这里要处理下，然后键盘将要显示的时候也要处理下 主要针对textView
            // do something
    }
#pragma mark -- 添加属性改变结束
    
    self.inputAccessoryView.keyboardButton.target = self;
    self.inputAccessoryView.keyboardButton.action = @selector(showKeyboard:);
    self.inputAccessoryView.stampButton.target = self;
    self.inputAccessoryView.stampButton.action = @selector(showStampInputView:);
    self.inputAccessoryView.photoButton.target = self;
    self.inputAccessoryView.photoButton.action = @selector(showImagePicker:);
    self.inputAccessoryView.nomalButton.target = self;
    self.inputAccessoryView.nomalButton.action = @selector(nomal:);
    self.inputAccessoryView.boldButton.target = self;
    self.inputAccessoryView.boldButton.action = @selector(bold:);
    self.textView.inputAccessoryView = self.inputAccessoryView;
    self.textView.editable = YES;
    self.textView.lineSpacing = 8.0f;
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.textColor = [UIColor blackColor];
    
    

    
    
    
    NSString *initialText = @" ";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:initialText];
    
    
    UIFont *normalFont = [UIFont systemFontOfSize:defaultFontSize];
    CTFontRef ctNormalFont = CTFontCreateWithName((__bridge CFStringRef)normalFont.fontName, normalFont.pointSize, NULL);
    self.normalFont = (__bridge id)ctNormalFont;
    CFRelease(ctNormalFont);
    
    UIFont *boldFont = [UIFont boldSystemFontOfSize:defaultFontSize];
    CTFontRef ctBoldFont = CTFontCreateWithName((__bridge CFStringRef)boldFont.fontName, boldFont.pointSize, NULL);
    self.boldFont = (__bridge id)ctBoldFont;
    CFRelease(ctBoldFont);
    
    [attributedString addAttribute:(id)kCTFontAttributeName value:self.normalFont range:NSMakeRange(0, initialText.length)];
    
    self.textView.attributedText = attributedString;
    
    
    //为textView增加placeholder
    _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 10)];
    _placeholder.text = @"编辑内容";
    _placeholder.textColor = [UIColor lightGrayColor];
    [self.textView addSubview:_placeholder];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillLayoutSubviews
{
    [self updateLayout];
}



#pragma mark -

- (void)textViewDidBeginEditing:(SETextView *)textView
{
    if(_placeholder){
        [_placeholder removeFromSuperview];
        _placeholder = nil;
    }
}

- (void)textViewDidEndEditing:(SETextView *)textView
{
    
}

- (void)textViewDidChangeSelection:(SETextView *)textView
{
    NSRange selectedRange = textView.selectedRange;
    if (selectedRange.location != NSNotFound && selectedRange.length > 0) {
        self.inputAccessoryView.boldButton.enabled = YES;
        self.inputAccessoryView.nomalButton.enabled = YES;
    } else {
        self.inputAccessoryView.boldButton.enabled = NO;
        self.inputAccessoryView.nomalButton.enabled = NO;
    }
}

- (void)textViewDidChange:(SETextView *)textView
{
    [self updateLayout];
}

#pragma mark -

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    //保存scrollview的 frame
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(keyboardBounds) -40; //这里-40是因为textView占了40高度
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollView.scrollEnabled = NO;
    
    CGRect keyboardBounds;
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = self.scrollView.frame;
    containerFrame.size.height = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(keyboardBounds);
    
    self.scrollView.frame = containerFrame;
    
    self.scrollView.scrollEnabled = YES;
}

- (void)updateLayout
{
    //获取 scrollView的 宽高
    CGSize containerSize = self.scrollView.frame.size;
    
    //获取textView的contentSize的 宽高
    CGSize contentSize = [self.textView sizeThatFits:containerSize];
    
    // 获取textView的 frame
    CGRect frame = self.textView.frame;
    
    //重新设置frame的高度
    frame.size.height = MAX(contentSize.height, containerSize.height) ;
   
    
    self.textView.frame = frame;
    self.scrollView.contentSize = frame.size;
    [self.scrollView scrollRectToVisible:self.textView.caretRect animated:YES];
}

#pragma mark -

- (IBAction)showKeyboard:(id)sender
{
    self.textView.inputView = nil;
    [self.textView reloadInputViews];
    
    self.inputAccessoryView.keyboardButton.enabled = NO;
    self.inputAccessoryView.stampButton.enabled = YES;
}

- (IBAction)showStampInputView:(id)sender
{
    self.textView.inputView = self.imageInputView;
    [self.textView reloadInputViews];
    
    self.inputAccessoryView.keyboardButton.enabled = YES;
    self.inputAccessoryView.stampButton.enabled = NO;
}

- (IBAction)showImagePicker:(id)sender
{
    [self.textView resignFirstResponder];
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)nomal:(id)sender
{
    NSRange selectedRange = self.textView.selectedRange;
    if (selectedRange.location != NSNotFound && selectedRange.length > 0) {
        self.textView.font = nil;
        
        NSMutableAttributedString *attributedString = self.textView.attributedText.mutableCopy;
        [attributedString addAttribute:(id)kCTFontAttributeName value:self.normalFont range:selectedRange];
        self.textView.attributedText = attributedString;
    }
}

- (IBAction)bold:(id)sender
{
    NSRange selectedRange = self.textView.selectedRange;
    if (selectedRange.location != NSNotFound && selectedRange.length > 0) {
        self.textView.font = nil;
        
        NSMutableAttributedString *attributedString = self.textView.attributedText.mutableCopy;
        [attributedString addAttribute:(id)kCTFontAttributeName value:self.boldFont range:selectedRange];
        self.textView.attributedText = attributedString;
    }
}

- (IBAction)stamp:(id)sender
{
    UIButton *button = sender;
    UIImage *stampImage = [button imageForState:UIControlStateNormal];
    if (stampImage) {
        [self.textView insertObject:stampImage size:stampImage.size];
    }
}

#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    SEPhotoView *photoView = [[SEPhotoView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 80.0f)];
    photoView.image = image;
    
    [self.textView insertObject:photoView size:photoView.bounds.size];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
