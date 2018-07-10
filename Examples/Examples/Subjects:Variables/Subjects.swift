
//
//  SubJects.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/10.
//  Copyright © 2018年 Asun. All rights reserved.
//


/**
 总结:
 Subjects :本身是订阅者,但是也有observer的功能
 分为四种 :PublishSubject、BehaviorSubject、ReplaySubject、Variable
 PublishSubject: 一条时间线,如果 在中间订阅PublishSubject,那么就会从当前位置开始
 
 BehaviorSubject: 不同于PublishSubject,会从头开始接收
 
 ReplaySubject: 与PublishSubject一样,但是有缓存,虽然从当前位置开始,但是 会先收到缓存的值, 值由自己设置
 
 Variable: 是基于BehaviorSubject的封装,会替换当前值,也能收到之前的值,订阅 需要使用asObersver(),value值能直接使用
 
*/
