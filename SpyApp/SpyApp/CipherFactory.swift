import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "Alphanumeric": AlphanumericCipher(),
        "Alphabet": AlphabeticalCipher(),
        "Multiplication" : MultiplicationCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
