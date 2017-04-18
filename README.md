简介
==============
对YYModel库的一个扩展。<br/>


Demo Project
==============

查看并运行 `Demo/Demo.xcodeproj`


扩展的功能
==============

### 可对json的key和model的属性名做一个统一的转换

    + (NSString *)replaceKeyFromPropertyName:(NSString *)propertyName;

此方法功能: 以属性名转换后的字符串作为key去json中取值赋给此属性名

封装好的转换类型:

    typedef NS_ENUM(NSUInteger, NSStringMapperType) {
        NSStringMapperDefault = 0,///< 不做转换
        NSStringMapperFirstCharLower = 1,///< 首字母变小写
        NSStringMapperFirstCharUpper, ///< 首字母变大写
        NSStringMapperUnderLineFromCamel, ///< 驼峰转下划线（loveYou -> love_you）
        NSStringMapperCamelFromUnderLine, ///< 下划线转驼峰（love_you -> loveYou）
    };

    @interface NSString (YYModel)

    - (NSString *)mapperWithType:(NSStringMapperType)type;

    @end

如果不满足你也可以自定义转换方式


### 支持属性名映射到数组

Example:

    + (NSDictionary *)modelCustomPropertyMapper {
        return @{@"tag" : @"topics[0].status.tag"};
    }


Demo
==============

    @interface YYTag : NSObject
    @property (nonatomic, strong) NSString *tagName;
    @property (nonatomic, strong) NSString *tagScheme;
    @property (nonatomic, assign) int32_t tagType;
    @property (nonatomic, assign) int32_t tagHidden;
    @property (nonatomic, strong) NSURL *urlTypePic;
    @property (nonatomic, copy)NSString *wbName;
    @end

    @implementation YYTag
    + (NSDictionary *)modelCustomPropertyMapper {
        return @{@"wbName" : @"wb_name.newName.info[1].nameChangedTime[1].bbb.text[2].text.page[1].test[1]"};
    }
    + (NSString *)replaceKeyFromPropertyName:(NSString *)propertyName {
        return [propertyName mapperWithType:NSStringMapperUnderLineFromCamel];
    }
    @end

    YYTag *tag = [YYTag modelWithJSON:@{@"tag_hidden" : @2 , @"tag_name" : @"上海·上海文庙", @"tag_scheme" : @"http://www.scheme", @"tag_type" : @1, @"url_type_pic" : @"http://www.pic", @"tag_topic" : @"#today is hot", @"wb_name" : @{@"newName" : @{ @"info" : @[@"test-data", @{@"nameChangedTime" : @[@{@"aaa" : @"2013-01"}, @{@"bbb" : @{@"text" : @[@"2014-01", @"2014-02", @{@"text" : @{@"page" : @[@"2017-08", @{@"test" : @[@"2017-09", @"2017-10"]}]}}]}}]}] } }}];

    NSLog(@"%@", [tag modelToJSONString]);

控制台输出:

    {"tag_scheme":"http:\/\/www.scheme","url_type_pic":"http:\/\/www.pic","tag_type":1,"wb_name":{"newName":{"info":[null,{"nameChangedTime":[null,{"bbb":{"text":[null,null,{"text":{"page":[null,{"test":[null,"2017-10"]}]}}]}}]}]}},"tag_hidden":2,"tag_name":"上海·上海文庙"}


其他
==============

还对NSObject扩展了以下方法

    @interface NSObject (CustomMethod)

    + (nullable NSDictionary *)modelDictionaryWithJSON:(id)json;

    + (nullable NSArray *)modelArrayWithKeyValuesArray:(id)json;

    /**
    通过plist来创建一个模型数组
    @param filename 文件名(仅限于mainBundle中的文件)
    @return 模型数组
    */
    + (NSArray *)modelArrayWithFilename:(NSString *)filename;

    /**
    *  通过plist来创建一个模型数组
    *  @param file 文件全路径
    *  @return 模型数组
    */
    + (NSArray *)modelArrayWithFile:(NSString *)file;

    @end


感谢YYModel的作者, 欢迎提出问题!
