//
//  LineupChessModel.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/12/1.
//

import Foundation

struct LineupChess: Codable {
    let ID: Int
    let CompositionId:Int
    let ChessName: String
    enum CodingKeys: String, CodingKey{
        case ID = "ID"
        case CompositionId = "CompositionId"
        case ChessName = "ChessName"
    }
}


var LineupChessArr:[LineupChess]?

func receiveLineupChess(_ comId:Int){
    if let url = URL(string: "http://39.105.175.189:9999/lineup/xuanzelineup?comId=\(comId)"){
        
        dispatchGroup.enter()
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            defer {
                dispatchGroup.leave()
            }
            
            if let error = error {
                print("请求错误：\(error)")
                return
            }
            if let data = data {
                if let result = String(data: data, encoding: .utf8) {
                    do {
//                        print("返回结果：\(result)")
                        let decoder = JSONDecoder()
                        LineupChessArr = try decoder.decode([LineupChess].self, from: data)
                    } catch {
                        print("解析数据时出错：\(error)")
                    }
                }
            }
        }
        task.resume()
    }
    dispatchGroup.leave()
}
