//
//  File.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/10.
//  Copyright © 2018年 Asun. All rights reserved.
//
/**
 总结:
 RXSwift中的操作符
 
 buffer: 缓冲组合,设置缓冲时间,缓冲个数,缓冲线程
 缓存成集合发送,搜集完成才会发送
 
 window: 缓冲但是以Observable发送,实时发送
 
 map:传入闭包变成一个新的Observable序列,容易产生升维操作
 
 flatMap:降维操作
 
 flatMapLatest:降维操作,但是只会接受最新的事件
 
 falstMapFirst:降维操作,只会接收老的事件
 
 concatMap:前序列完成,才会调用其他序列
 
 scan:给予初始化的值,不断拿 前一个结果与最新值对比
 
 groupBy:分流
 
 filter: 过滤不符合要求的值
 
 distinctUntilChanged:过滤连续重复的值
 
 single:限制只发送一次事件，或者满足条件的第一个事件
 如果存在有多个事件或者没有事件都会发出一个 error 事件
 如果只有一个事件，则不会发出 error 事件
 
 elementAt: 只处理在指定位置的事件
 
 ignoreElements: 忽略所有元素,只关注出错或者结束
 
 take:只关注前几个事件,满足条件后会结束
 
 takeLast:只关注倒数几个事件
 
 skip:跳过前几个事件
 
 Sample:除了订阅源Observable之外,还能监听另一个Observable ,每当收到 另一个Observable 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值
 
 debounce:队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉
 
 */
