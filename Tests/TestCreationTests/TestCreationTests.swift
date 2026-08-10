import Testing
@testable import TestCreation

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    
    
   
    let p = Number(7)
    let f = p
    
    
    #expect(f.value == "7")
    let binaryNumber = [

        1, 0, 1, 1, 0, 0, 1, 0,

        0, 1, 1, 1, 0, 1, 0, 1,

        1, 0, 0, 1, 1, 0, 1, 0,

        0, 0, 1, 1, 1, 0, 0, 1,

        1, 1, 0, 0, 1, 0, 1, 1,

        0, 1, 0, 1, 1, 1, 0, 0,

        1, 0, 1, 0, 0, 1, 1, 1,

        0, 0, 1, 1, 0, 1, 0, 1,

        1, 0, 0, 1, 0, 1, 1, 0,

        0, 1, 1, 0, 1, 0, 0, 1,

        1, 1, 0, 1, 0, 0, 1, 0,

        0, 1, 0, 1, 1, 0, 1, 1

    ]
    
    let sum = Number.convertBinaryToNumber(binary: binaryNumber, belowDecimalBinary: [0])
 
    
    print(sum.description)
    
   
    #expect(sum.description == "55230504379650879109414376027")
     
    /*
    var p: Number = 3
    var x = 3
    
    for i in 0..<10 {
        let f = Number(1)
        print("here")
        p = (p) - (f)
        x = x - 1
        
        #expect(p.description == x.description)
    }
     */
    
    
    
}


