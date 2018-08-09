//
//  MARXMLDictionary.m
//  MARExtensionDemo
//
//  Created by Martin.Liu on 2018/8/9.
//  Copyright © 2018年 MAR. All rights reserved.
//

#import "MARXMLDictionary.h"

@interface MARXMLDictionaryParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *root;
@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, strong) NSMutableString *text;

@property (nonatomic, strong) NSArray *useArrayNodeLabelArray;

@end

@implementation MARXMLDictionaryParser

+ (instancetype)sharedInstance
{
    static MARXMLDictionaryParser *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

+ (instancetype)useArrayWithNodeLabelArray:(NSArray<NSString *> *)array
{
    MARXMLDictionaryParser *instance = [self sharedInstance];
    instance->_useArrayNodeLabelArray = [array copy];
    return instance;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        _collapseTextNodes = YES;
        _stripEmptyNodes = YES;
        _trimWhiteSpace = YES;
        _alwaysUseArrays = NO;
        _preserveComments = NO;
        _wrapRootNode = NO;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    MARXMLDictionaryParser *copy = [[[self class] allocWithZone:zone] init];
    copy.collapseTextNodes = _collapseTextNodes;
    copy.stripEmptyNodes = _stripEmptyNodes;
    copy.trimWhiteSpace = _trimWhiteSpace;
    copy.alwaysUseArrays = _alwaysUseArrays;
    copy.preserveComments = _preserveComments;
    copy.attributesMode = _attributesMode;
    copy.nodeNameMode = _nodeNameMode;
    copy.wrapRootNode = _wrapRootNode;
    return copy;
}

- (NSDictionary<NSString *, id> *)dictionaryWithParser:(NSXMLParser *)parser
{
    parser.delegate = self;
    [parser parse];
    id result = _root;
    _root = nil;
    _stack = nil;
    _text = nil;
    return result;
}

- (NSDictionary<NSString *, id> *)dictionaryWithData:(NSData *)data
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    return [self dictionaryWithParser:parser];
}

- (NSDictionary<NSString *, id> *)dictionaryWithString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithData:data];
}

- (NSDictionary<NSString *, id> *)dictionaryWithFile:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self dictionaryWithData:data];
}

+ (NSString *)XMLStringForNode:(id)node withNodeName:(NSString *)nodeName
{
    if ([node isKindOfClass:[NSArray class]])
    {
        NSMutableArray<NSString *> *nodes = [NSMutableArray arrayWithCapacity:[node count]];
        for (id individualNode in node)
        {
            [nodes addObject:[self XMLStringForNode:individualNode withNodeName:nodeName]];
        }
        return [nodes componentsJoinedByString:@"\n"];
    }
    else if ([node isKindOfClass:[NSDictionary class]])
    {
        NSDictionary<NSString *, NSString *> *attributes = [(NSDictionary *)node mar_attributes];
        NSMutableString *attributeString = [NSMutableString string];
        [attributes enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, __unused BOOL *stop) {
            [attributeString appendFormat:@" %@=\"%@\"", key.description.mar_XMLEncodedString, value.description.mar_XMLEncodedString];
        }];
        
        NSString *innerXML = [node mar_innerXML];
        if (innerXML.length)
        {
            return [NSString stringWithFormat:@"<%1$@%2$@>%3$@</%1$@>", nodeName, attributeString, innerXML];
        }
        else
        {
            return [NSString stringWithFormat:@"<%@%@/>", nodeName, attributeString];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"<%1$@>%2$@</%1$@>", nodeName, [node description].mar_XMLEncodedString];
    }
}

- (void)endText
{
    if (_trimWhiteSpace)
    {
        _text = [[_text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    }
    if (_text.length)
    {
        NSMutableDictionary *top = _stack.lastObject;
        id existing = top[MARXMLDictionaryTextKey];
        if ([existing isKindOfClass:[NSArray class]])
        {
            [existing addObject:_text];
        }
        else if (existing)
        {
            top[MARXMLDictionaryTextKey] = [@[existing, _text] mutableCopy];
        }
        else
        {
            top[MARXMLDictionaryTextKey] = _text;
        }
    }
    _text = nil;
}

- (void)addText:(NSString *)text
{
    if (!_text)
    {
        _text = [NSMutableString stringWithString:text];
    }
    else
    {
        [_text appendString:text];
    }
}

- (void)parser:(__unused NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(__unused NSString *)namespaceURI qualifiedName:(__unused NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self endText];
    
    NSMutableDictionary<NSString *, id> *node = [NSMutableDictionary dictionary];
    switch (_nodeNameMode)
    {
        case MARXMLDictionaryNodeNameModeRootOnly:
        {
            if (!_root)
            {
                node[MARXMLDictionaryNodeNameKey] = elementName;
            }
            break;
        }
        case MARXMLDictionaryNodeNameModeAlways:
        {
            node[MARXMLDictionaryNodeNameKey] = elementName;
            break;
        }
        case MARXMLDictionaryNodeNameModeNever:
        {
            break;
        }
    }
    
    if (attributeDict.count)
    {
        switch (_attributesMode)
        {
            case MARXMLDictionaryAttributesModePrefixed:
            {
                for (NSString *key in attributeDict)
                {
                    node[[MARXMLDictionaryAttributePrefix stringByAppendingString:key]] = attributeDict[key];
                }
                break;
            }
            case MARXMLDictionaryAttributesModeDictionary:
            {
                node[MARXMLDictionaryAttributesKey] = attributeDict;
                break;
            }
            case MARXMLDictionaryAttributesModeUnprefixed:
            {
                [node addEntriesFromDictionary:attributeDict];
                break;
            }
            case MARXMLDictionaryAttributesModeDiscard:
            {
                break;
            }
        }
    }
    
    if (!_root)
    {
        _root = node;
        _stack = [NSMutableArray arrayWithObject:node];
        if (_wrapRootNode)
        {
            _root = [NSMutableDictionary dictionaryWithObject:_root forKey:elementName];
            [_stack insertObject:_root atIndex:0];
        }
    }
    else
    {
        NSMutableDictionary<NSString *, id> *top = _stack.lastObject;
        id existing = top[elementName];
        if ([existing isKindOfClass:[NSArray class]])
        {
            [(NSMutableArray *)existing addObject:node];
        }
        else if (existing)
        {
            top[elementName] = [@[existing, node] mutableCopy];
        }
        else if (_alwaysUseArrays || [_useArrayNodeLabelArray containsObject:elementName])
        {
            top[elementName] = [NSMutableArray arrayWithObject:node];
        }
        else
        {
            top[elementName] = node;
        }
        [_stack addObject:node];
    }
}

- (NSString *)nameForNode:(NSDictionary<NSString *, id> *)node inDictionary:(NSDictionary<NSString *, id> *)dict
{
    if (node.mar_nodeName)
    {
        return node.mar_nodeName;
    }
    else
    {
        for (NSString *name in dict)
        {
            id object = dict[name];
            if (object == node)
            {
                return name;
            }
            else if ([object isKindOfClass:[NSArray class]] && [(NSArray *)object containsObject:node])
            {
                return name;
            }
        }
    }
    return nil;
}

- (void)parser:(__unused NSXMLParser *)parser didEndElement:(__unused NSString *)elementName namespaceURI:(__unused NSString *)namespaceURI qualifiedName:(__unused NSString *)qName
{
    [self endText];
    
    NSMutableDictionary<NSString *, id> *top = _stack.lastObject;
    [_stack removeLastObject];
    
    if (!top.mar_attributes && !top.mar_childNodes && !top.mar_comments)
    {
        NSMutableDictionary<NSString *, id> *newTop = _stack.lastObject;
        NSString *nodeName = [self nameForNode:top inDictionary:newTop];
        if (nodeName)
        {
            id parentNode = newTop[nodeName];
            NSString *innerText = top.mar_innerText;
            if (innerText && _collapseTextNodes)
            {
                if ([parentNode isKindOfClass:[NSArray class]])
                {
                    parentNode[[parentNode count] - 1] = innerText;
                }
                else
                {
                    newTop[nodeName] = innerText;
                }
            }
            else if (!innerText)
            {
                if (_stripEmptyNodes)
                {
                    if ([parentNode isKindOfClass:[NSArray class]])
                    {
                        [(NSMutableArray *)parentNode removeLastObject];
                    }
                    else
                    {
                        [newTop removeObjectForKey:nodeName];
                    }
                }
                else if (!_collapseTextNodes)
                {
                    top[MARXMLDictionaryTextKey] = @"";
                }
            }
        }
    }
}

- (void)parser:(__unused NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self addText:string];
}

- (void)parser:(__unused NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    [self addText:[[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding]];
}

- (void)parser:(__unused NSXMLParser *)parser foundComment:(NSString *)comment
{
    if (_preserveComments)
    {
        NSMutableDictionary<NSString *, id> *top = _stack.lastObject;
        NSMutableArray<NSString *> *comments = top[MARXMLDictionaryCommentsKey];
        if (!comments)
        {
            comments = [@[comment] mutableCopy];
            top[MARXMLDictionaryCommentsKey] = comments;
        }
        else
        {
            [comments addObject:comment];
        }
    }
}

@end


@implementation NSDictionary(MARXMLDictionary)

+ (NSDictionary<NSString *, id> *)mar_dictionaryWithXMLParser:(NSXMLParser *)parser
{
    return [[[MARXMLDictionaryParser sharedInstance] copy] dictionaryWithParser:parser];
}

+ (NSDictionary<NSString *, id> *)mar_dictionaryWithXMLData:(NSData *)data
{
    return [[[MARXMLDictionaryParser sharedInstance] copy] dictionaryWithData:data];
}

+ (NSDictionary<NSString *, id> *)mar_dictionaryWithXMLString:(NSString *)string
{
    return [[[MARXMLDictionaryParser sharedInstance] copy] dictionaryWithString:string];
}

+ (NSDictionary<NSString *, id> *)mar_dictionaryWithXMLFile:(NSString *)path
{
    return [[[MARXMLDictionaryParser sharedInstance] copy] dictionaryWithFile:path];
}

- (nullable NSDictionary<NSString *, NSString *> *)mar_attributes
{
    NSDictionary<NSString *, NSString *> *attributes = self[MARXMLDictionaryAttributesKey];
    if (attributes)
    {
        return attributes.count? attributes: nil;
    }
    else
    {
        NSMutableDictionary<NSString *, id> *filteredDict = [NSMutableDictionary dictionaryWithDictionary:self];
        [filteredDict removeObjectsForKeys:@[MARXMLDictionaryCommentsKey, MARXMLDictionaryTextKey, MARXMLDictionaryNodeNameKey]];
        for (NSString *key in filteredDict.allKeys)
        {
            [filteredDict removeObjectForKey:key];
            if ([key hasPrefix:MARXMLDictionaryAttributePrefix])
            {
                filteredDict[[key substringFromIndex:MARXMLDictionaryAttributePrefix.length]] = self[key];
            }
        }
        return filteredDict.count? filteredDict: nil;
    }
    return nil;
}

- (nullable NSDictionary *)mar_childNodes
{
    NSMutableDictionary *filteredDict = [self mutableCopy];
    [filteredDict removeObjectsForKeys:@[MARXMLDictionaryAttributesKey, MARXMLDictionaryCommentsKey, MARXMLDictionaryTextKey, MARXMLDictionaryNodeNameKey]];
    for (NSString *key in filteredDict.allKeys)
    {
        if ([key hasPrefix:MARXMLDictionaryAttributePrefix])
        {
            [filteredDict removeObjectForKey:key];
        }
    }
    return filteredDict.count? filteredDict: nil;
}

- (nullable NSArray *)mar_comments
{
    return self[MARXMLDictionaryCommentsKey];
}

- (nullable NSString *)mar_nodeName
{
    return self[MARXMLDictionaryNodeNameKey];
}

- (id)mar_innerText
{
    id text = self[MARXMLDictionaryTextKey];
    if ([text isKindOfClass:[NSArray class]])
    {
        return [text componentsJoinedByString:@"\n"];
    }
    else
    {
        return text;
    }
}

- (NSString *)mar_innerXML
{
    NSMutableArray *nodes = [NSMutableArray array];
    
    for (NSString *comment in [self mar_comments])
    {
        [nodes addObject:[NSString stringWithFormat:@"<!--%@-->", [comment mar_XMLEncodedString]]];
    }
    
    NSDictionary *childNodes = [self mar_childNodes];
    for (NSString *key in childNodes)
    {
        [nodes addObject:[MARXMLDictionaryParser XMLStringForNode:childNodes[key] withNodeName:key]];
    }
    
    NSString *text = [self mar_innerText];
    if (text)
    {
        [nodes addObject:[text mar_XMLEncodedString]];
    }
    
    return [nodes componentsJoinedByString:@"\n"];
}

- (NSString *)mar_XMLString
{
    if (self.count == 1 && ![self mar_nodeName])
    {
        //ignore outermost dictionary
        return [self mar_innerXML];
    }
    else
    {
        return [MARXMLDictionaryParser XMLStringForNode:self withNodeName:[self mar_nodeName] ?: @"root"];
    }
}

- (nullable NSArray *)mar_arrayValueForKeyPath:(NSString *)keyPath
{
    id value = [self valueForKeyPath:keyPath];
    if (value && ![value isKindOfClass:[NSArray class]])
    {
        return @[value];
    }
    return value;
}

- (nullable NSString *)mar_stringValueForKeyPath:(NSString *)keyPath
{
    id value = [self valueForKeyPath:keyPath];
    if ([value isKindOfClass:[NSArray class]])
    {
        value = ((NSArray *)value).firstObject;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return [(NSDictionary *)value mar_innerText];
    }
    return value;
}

- (nullable NSDictionary<NSString *, id> *)mar_dictionaryValueForKeyPath:(NSString *)keyPath
{
    id value = [self valueForKeyPath:keyPath];
    if ([value isKindOfClass:[NSArray class]])
    {
        value = [value count]? value[0]: nil;
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return @{MARXMLDictionaryTextKey: value};
    }
    return value;
}

@end


@implementation NSString (XMLDictionary)

- (NSString *)mar_XMLEncodedString
{
    return [[[[[self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]
               stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"]
              stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"]
             stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"]
            stringByReplacingOccurrencesOfString:@"\'" withString:@"&apos;"];
}

@end
