//
//  ViewController.m
//  Demo
//
//  Created by HHIOS on 2017/4/18.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "ViewController.h"

#import "YYModel.h"

@interface YYTag : NSObject <NSCoding>
@property (nonatomic, strong) NSString *tagName; ///< 标签名字，例如"上海·上海文庙"
@property (nonatomic, strong) NSString *tagScheme; ///< 链接 sinaweibo://...
@property (nonatomic, assign) int32_t tagType; ///< 1 地点 2其他
@property (nonatomic, assign) int32_t tagHidden;
@property (nonatomic, strong) NSURL *urlTypePic; ///< 需要加 _default
@property (nonatomic, copy)NSString *wbName;
@end
@implementation YYTag
YYCodingImplementation
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"wbName" : @"wb_name.newName.info[1].nameChangedTime[1].bbb.text[2].text.page[1].test[1]"};
}
+ (NSString *)replaceKeyFromPropertyName:(NSString *)propertyName {
    return [propertyName mapperWithType:NSStringMapperUnderLineFromCamel];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self demo];
}

- (void)demo {
    YYTag *tag = [YYTag modelWithJSON:@{@"tag_hidden" : @2 , @"tag_name" : @"上海·上海文庙", @"tag_scheme" : @"http://www.scheme", @"tag_type" : @1, @"url_type_pic" : @"http://www.pic", @"tag_topic" : @"#today is hot", @"wb_name" : @{@"newName" : @{ @"info" : @[@"test-data", @{@"nameChangedTime" : @[@{@"aaa" : @"2013-01"}, @{@"bbb" : @{@"text" : @[@"2014-01", @"2014-02", @{@"text" : @{@"page" : @[@"2017-08", @{@"test" : @[@"2017-09", @"2017-10"]}]}}]}}]}] } }}];
    
    NSLog(@"%@", [tag modelToJSONString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
