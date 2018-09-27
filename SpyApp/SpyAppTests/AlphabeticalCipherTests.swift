import XCTest
@testable import SpyApp

class AlphabeticalCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphabeticalCipher()
    }
    
    func test_oneCharacterStirngGetsMappedToSelfWith_0_secret() {
        let plaintext = "a"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual("A", result)
    }
    func test_FourCharacterStirngEncodeWith_2_secret() {
        let plaintext = "bcde"
        
        let result = cipher.encode(plaintext, secret: "2")
        
        XCTAssertEqual("DEFG", result)
    }
    func test_FourCharacterStirngDecodeWith_2_secret() {
        let plaintext = "defg"
        
        let result = cipher.decode(plaintext, secret: "2")
        
        XCTAssertEqual("BCDE", result)
    }
    func test_FourCharacterStirngEncodeWith_Negative2_secret() {
        let plaintext = "bcde"
        
        let result = cipher.encode(plaintext, secret: "-2")
        
        XCTAssertEqual("ZABC", result)
    }
    func test_FourCharacterStirngDecodeWith_Negative2_secret() {
        let plaintext = "ZABC"
        
        let result = cipher.decode(plaintext, secret: "-2")
        
        XCTAssertEqual("BCDE", result)
    }
    
    
    
    
}


