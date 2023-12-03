//
//  selectedChessModel.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/30.
//

import Foundation

var selectedChess = [String: Int]()

func addSelectedChess(_ name:String){
    
    if addedImages.contains(name){
        print("重复添加")
        return
    }
    
    if let hero = heroes?.first(where: { $0.name == name }) {
        let chess: Hero = hero
        // 这里可以对 chess 进行操作
        
        for ci in chess.cities{
            let name = ci.name
            if var count = selectedChess[name] {
                // 如果存在，则将对应的值加1
                count += 1
                selectedChess[name] = count
            } else {
                // 如果不存在，则添加新的键值对
                selectedChess[name] = 1
            }
        }
        
        for jo in chess.jobs{
            let name = jo.name
            if var count = selectedChess[name] {
                // 如果存在，则将对应的值加1
                count += 1
                selectedChess[name] = count
            } else {
                // 如果不存在，则添加新的键值对
                selectedChess[name] = 1
            }
        }
    }
}

func reduceSelectedChess(_ name:String){
    
    if let hero = heroes?.first(where: {$0.name == name}) {
        let chess: Hero = hero
        
        for ci in chess.cities{
            let name = ci.name
            if var count = selectedChess[name] {
                // 如果存在，则将对应的值减去1
                count -= 1
                if count > 0 {
                    selectedChess[name] = count
                } else {
                    selectedChess.removeValue(forKey: name)
                }
            }
        }
        
        for jo in chess.jobs{
            let name = jo.name
            if var count = selectedChess[name] {
                // 如果存在，则将对应的值减去1
                count -= 1
                if count > 0 {
                    selectedChess[name] = count
                } else {
                    selectedChess.removeValue(forKey: name)
                }
            }
        }
        
        
    }
}


func helper(_ name:String, _ number:Int)->Int{
    
    var c:Int = 0
    
    if let city = CityNum?.first(where: {$0.name == name}) {
        let chess: CityNums = city
        for n in chess.numsArray{
            if n <= number{
                c = n
            }
        }
    }
    if let job = JobNum?.first(where: {$0.name == name}) {
        let chess: JobNums = job
        for n in chess.numsArray{
            if n <= number{
                c = n
            }
        }
    }
    
    return c
}
