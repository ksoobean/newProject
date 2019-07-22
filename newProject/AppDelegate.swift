//
//  AppDelegate.swift
//  newProject
//
//  Created by 김수빈 on 15/07/2019.
//  Copyright © 2019 김수빈. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    // 앱이 런칭된 후 가장 먼저 실행되는 메소드로 사용자에게 보여지기 전에 초기화가 가능한 메소드
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("func application")
        return true
    }
    
    
    // Actie -> Inactive 상태가 될 때
    // 전화, 메세지 등의 인터럽트에 대한 처리, 게임의 경우 일시정지 로직을 구현해야하는 메서드
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("func applicationWillResignActive")
    }

    
    // 앱이 Background 상태가 되었을 때(언제든 suspended 상태로 전환 가능)
    // 공유 자원을 해제하거나 유저 데이터 저장 등을 해야하는 메서드
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("func applicationDidEnterBackground")
    } 

    
    // Background -> Foreground 전환될 때(Active 상태가 되기 전)
    // API로 앱의 상태를 갱신할 때 사용. 버전체크, 메인테이닝 체크 등등
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // 
        print("func applicationWillEnterForeground")
    }

    
    // Active 상태로 전환되었을 때
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("func applicationDidBecomeActive")
    }

    
    // 종료될 때
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("func applicationWillTerminate")
    }


}

