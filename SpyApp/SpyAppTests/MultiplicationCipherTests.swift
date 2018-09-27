import XCTest
@testable import SpyApp
/*
  These are the tests for our multiplication cipher cases
 
 */
class MultiplicationCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = MultiplicationCipher()
    }
    
    func test_oneCharacterStirngGetsMappedToSelfWith_0_secret() {
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("a", result)
    }
    func test_oneCharacterStirngGetsMappedToSelfWith_2_secret() {
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "2")
        
        XCTAssertEqual("g", result)
    }
    func test_FourCharacterStirngEncodeWith_2_secret() {
        let plaintext = "bcde"
        
        let result = cipher.encode(plaintext, secret: "2")
        
        XCTAssertEqual("hijk", result)
    }
    func test_FourCharacterStirngDecodeWith_2_secret() {
        let plaintext = "hijk"
        
        let result = cipher.decode(plaintext, secret: "2")
        
        XCTAssertEqual("bcde", result)
    }
    func test_FourCharacterStirngEncodeWith_Negative2_secret() {
        let plaintext = "bcde"
        
        let result = cipher.encode(plaintext, secret: "-1")
        
        XCTAssertEqual(nil, result)
    }
   
    
    
    
    
}


