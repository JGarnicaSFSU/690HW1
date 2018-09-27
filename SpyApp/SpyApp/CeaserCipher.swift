import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String?
    func decode(_ plaintext: String, secret: String) -> String?

}

struct CeaserCipher: Cipher {
    func decode(_ plaintext: String, secret: String) -> String? {
        //This will decode a string
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decoded = ""
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
    

    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
}
/*
    Creates a hidden message by multiplying its a secret by an internal integer and then adding it
    to the unicode of the character. The max for safety is 4
 
 */
struct MultiplicationCipher: Cipher{
        func encode(_ plaintext: String, secret: String) -> String? {
            
            guard var shiftBy = UInt32(secret) else {
                return nil
            }
            var encoded = ""
            
            if(shiftBy > 4 || shiftBy < 0){
                return nil //we cannot have huge numbers for this
            }
            shiftBy = 3 * shiftBy
            for character in plaintext {
                let unicode = character.unicodeScalars.first!.value
                let shiftedUnicode = unicode + shiftBy
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                encoded = encoded + shiftedCharacter
            }
            return encoded
        }
        
        func decode(_ plaintext: String, secret: String) -> String? {
            guard var shiftBy = Int(secret) else {
                return nil
            }
            var decoded = ""
            
            if(shiftBy > 4 || shiftBy < 0){
                return nil //we cannot have huge numbers for this
            }
            shiftBy =  shiftBy * 3
            let newShift = UInt32(shiftBy)
            for character in plaintext {
                let unicode = character.unicodeScalars.first!.value
                let shiftedUnicode = unicode - newShift
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                decoded = decoded + shiftedCharacter
            }
            return decoded
        }
        
    
    
    
    
}
/*
  Returns an encrypted message moved by n where n is a number. The map is mishmashed alphabet and the input can only be alphabetical
 Input: Only lower or uppper alphabetical strings
 Output: Upper case alphabetical strings
 
 */

struct AlphabeticalCipher: Cipher {
    func decode(_ plaintext: String, secret: String) -> String? {
        //This will decode a string
        guard let shiftBy = Int(secret) else {
            return nil
        }
        let inverseShift = shiftBy * -1
        let stringShift = String(inverseShift)
        var decoded = ""
        decoded = encode(plaintext, secret: stringShift)!
                
        
        return decoded
    }
    
    
    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        let library = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N",
                        "O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        
        //There are 26 letters here so 26 values
        let upperCasedplaintext = plaintext.uppercased();
        var encoded = ""
        var position = 0
        
        for character in upperCasedplaintext {
            if((library.firstIndex(of:String(character))) != nil){
                position = library.firstIndex(of:String(character))!
            } //the position in our array, also we need to make sure it is valid input
            else{
                return nil; //ERROR ENCODING
            }
            if (shiftBy > 0)
            {
                //  positive case
                let safeShift = shiftBy % 26
                position = position + Int(safeShift)
                position = position%26 //this is so it can loop arround
            }
            else if (shiftBy == 0)
            {
                //do nothing
                
            }
            else if (shiftBy < 0)
            {
                let positiveShift = Int(shiftBy) * -1
                let safeShift = positiveShift % 26 //This is to reduce huge numbers to what will be usable
                position = position - safeShift
                position = position % 26
                if(position<0){
                    position = 26 + position //this is to restart in the array
                }
                // negative stuff
            }
            
            
            let shiftedCharacter = library[position]
           
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
}

struct AlphanumericCipher: Cipher {
    func decode(_ plaintext: String, secret: String) -> String? {
        //This will decode a string
        //This will decode a string
        guard let shiftBy = Int(secret) else {
            return nil
        }
        let inverseShift = shiftBy * -1
        let stringShift = String(inverseShift)
        var decoded = ""
        decoded = encode(plaintext, secret: stringShift)!
        
        
        return decoded
    }
    
    
    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        let library = ["0", "1", "2","3","4","5","6","7","8","9",
                       "A","B","C","D","E","F","G","H","I","J","K","L","M","N",
                       "O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
        //There are 26 letters here and 9 numbers so 35 values
        let upperCasedplaintext = plaintext.uppercased();
        var encoded = ""
        var position = 0
       
        for character in upperCasedplaintext {
            if((library.firstIndex(of:String(character))) != nil){
                position = library.firstIndex(of:String(character))!
            } //the position in our array, this also makes sure it is valid input
            else{
                return nil;
            }
            if (shiftBy > 0)
            {
                //  Shift is positive case
                 let safeShift = shiftBy % 36
                position = position + Int(safeShift)
                position = position%36 //this is so it can loop arround
            }
            else if (shiftBy == 0)
            {
               //Does nothing
                
            }
            else if (shiftBy < 0)
            {
                 // negative case
                let positiveShift = Int(shiftBy) * -1
                let safeShift = positiveShift % 36
                position = position - safeShift
                position = position % 36
                if(position<0){
                    position = 36 + position //this is done so it can loop around
                }
               
            }
           
          
            let shiftedCharacter = library[position]
          
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
}


