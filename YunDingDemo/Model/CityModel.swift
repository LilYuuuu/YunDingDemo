//
//  CityModel.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/23.
//

import Foundation


struct City: Codable {
    let id: Int
    let name: String
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case name = "Name"
    }
}

var cities: [City]?

func receiveJob() {
    if let url = URL(string: "http://39.105.175.189:9999/imitate/city"){
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
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        cities = try decoder.decode([City].self, from: data)
                        
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
//    print("3")
}
