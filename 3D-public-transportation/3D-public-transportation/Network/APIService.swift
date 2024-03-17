//
//  APIService.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/21/24.
//

import Foundation
import Combine
import SwiftUI

class APIService {
    
    //싱글턴 인스턴스 정의
    static let shared = APIService()

    //함수의 반환타입은 AnyPublisher<[User], Error> -> [User]을 제공하거나, Error타입의 에러 발생시키는 퍼블리셔
    func getUsers() -> AnyPublisher<[User], Error> {
        
        //이 부분은 웹 API의 URL을 생성.
        //만약 URL 생성에 실패하면, 즉시 Fail Publisher를 반환하여 에러를 전달.
        guard let url = URL(string: "https://api.github.com/users")
        else
        {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
       
        //Future는 Combine의 Publisher 중 하나로, 단일 값을 비동기적으로 생성하고 전달
        return Future { promise in
            //URLSession을 사용하여 실제 HTTP 요청을 보냅니다. 요청의 결과는 비동기적으로 반환
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let users = try JSONDecoder().decode([User].self, from: data)
                        return promise(.success(users))
                    } catch let error {
                        return promise(.failure(error))
                    }
                }
            }.resume()
        //특정 Publisher의 타입을 AnyPublisher로 변환
        }.eraseToAnyPublisher()
    }
    
    //버스 정류장 API 호출
        static func fetchBusStop() -> AnyPublisher<BusStop, Error> {
            let apiUrl: String =
            "https://apis.data.go.kr/1613000/BusSttnInfoInqireService/getCrdntPrxmtSttnList?serviceKey=bMaapCX0pDYNMXkxCMrkClsR9nAc%2BcMnVZ3somodOj0%2B9y59NKK%2F1BbI1W7GkLz2k67GmVwCxR2iQPYv32YEvg%3D%3D&gpsLati=36.3&gpsLong=127.3&numOfRows=10&pageNo=1&_type=json"
            let encodedURL = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)    //한글 인코딩
            
            return URLSession.shared.dataTaskPublisher(for: URL(string: encodedURL!)!)
                .map { $0.data }
                .decode(type: BusStop.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        
        //버스 도착 예정 목록 API 호출
    static func fetchBusList(citiCode: Int, nodeId: String) -> AnyPublisher<BusLists, Error> {
            let apiUrl: String = "http://apis.data.go.kr/1613000/ArvlInfoInqireService/getSttnAcctoArvlPrearngeInfoList?serviceKey=bMaapCX0pDYNMXkxCMrkClsR9nAc%2BcMnVZ3somodOj0%2B9y59NKK%2F1BbI1W7GkLz2k67GmVwCxR2iQPYv32YEvg&cityCode=25&nodeId=DJB8001793&numOfRows=10&pageNo=1&_type=json"
            
            let encodedURL = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URLSession.shared.dataTaskPublisher(for: URL(string: encodedURL)!)
                .map { $0.data }
                .decode(type: BusLists.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    
    //두 API 연쇄 호출

    static func fetchBusListAfterBusStop() -> AnyPublisher<BusLists, Error> {
        return fetchBusStop()
            .flatMap { busStop -> AnyPublisher<BusLists, Error> in
                let items = busStop.response.body.items.item
                return Publishers.MergeMany(items.map { item in
                    fetchBusList(citiCode: item.citycode, nodeId: item.nodeid)
                })
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}
