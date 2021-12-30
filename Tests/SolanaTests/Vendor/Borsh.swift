import Foundation

import Foundation
import XCTest
@testable import Solana

fileprivate struct Test {
  let x: UInt32
  let y: UInt32
  let z: String
  let q: [UInt128]
}

extension Test: BorshCodable {
  func serialize(to writer: inout Data) throws {
    try x.serialize(to: &writer)
    try y.serialize(to: &writer)
    try z.serialize(to: &writer)
    try q.serialize(to: &writer)
  }

  init(from reader: inout BinaryReader) throws {
    self.x = try .init(from: &reader)
    self.y = try .init(from: &reader)
    self.z = try .init(from: &reader)
    self.q = try .init(from: &reader)
  }
}

class BorshCodableTests: XCTestCase {
    
    func test_should_deserialize(){
        let value = Test(x: 255, y: 20, z: "123", q: [1, 2, 3])
        let buf = try! BorshEncoder().encode(value)
        let new_value = try! BorshDecoder().decode(Test.self, from: buf)
        XCTAssertEqual(new_value.x, 255)
        XCTAssertEqual(new_value.y, 20)
        XCTAssertEqual(new_value.z, "123")
        XCTAssertEqual(new_value.q, [1, 2, 3])
    }
    
    func test_should_serialize_publickey() {
        
        let key = PublicKey(data: Data([3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))!
        
        XCTAssertEqual("CiDwVBFgWV9E5MvXWoLgnEgn2hK7rJikbvfWavzAQz3", key.base58EncodedString)
        let buf = try! BorshEncoder().encode(key)
        XCTAssertEqual(key.data, buf)
        
        XCTAssertEqual(PublicKey(bytes: buf.bytes)!.base58EncodedString, key.base58EncodedString)
        let key2 = try! BorshDecoder().decode(PublicKey.self, from: buf)
        
        XCTAssertEqual(key2.base58EncodedString, key.base58EncodedString)
    }
    
}
