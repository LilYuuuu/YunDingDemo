//
//  CityNumsModel.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/30.
//

import Foundation

struct CityNums: Codable {
    let name: String
    let numsArray: [Int]
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case numsArray = "nums_array"
    }
}

var CityNum : [CityNums]?

func receiveCityNum() {
    if let url = URL(string: "http://39.105.175.189:9999/imitate/cityNums"){
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let error = error {
                print("请求错误：\(error)")
                return
            }
            if let data = data {
                if let result = String(data: data, encoding: .utf8) {
//                    print("返回结果：\(result)")
                    // 在这里解析和处理返回的数据
                    do {
//                        print("返回结果：\(result)")
                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase   //自动把下划线转化为驼峰
                        CityNum = try decoder.decode([CityNums].self, from: data)
                        
                    // 在这里使用解析后的数据
                    } catch {
                        print("解析数据时出错：\(error)")
                    }
                }
            }
        }
        task.resume()
    }
    dispatchGroup.leave()
//    print("4")
}
