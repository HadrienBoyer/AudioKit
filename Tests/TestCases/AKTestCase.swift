// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKTestCase: XCTestCase {

    var duration = 0.1
    var output: AKNode?

    let sineOscillatorMD5 = "6ee413495f949542432eb00d32ecd903"

    var input = AKOscillator()

    var MD5: String {
        return AKManager.tester?.MD5 ?? ""
    }

    var afterStart: () -> Void = {}

    func auditionTest() {
        if let existingOutput = output {
            try! AKManager.auditionTest(node: existingOutput, duration: duration)
        }
    }

    func AKTestMD5(_ md5: String, alternate: String = "") {
        print("expected md5: \(md5)")
        var localMD5 = ""
        if let existingOutput = output {
            localMD5 = try! AKManager.test(node: existingOutput, duration: duration, afterStart: afterStart)
        }
        XCTAssertTrue([md5, alternate].contains(localMD5) && localMD5 != sineOscillatorMD5 && localMD5 != "", localMD5)
    }

    func AKTestMD5Not(_ md5: String) {
        if let existingOutput = output {
            try! AKManager.test(node: existingOutput, duration: duration, afterStart: afterStart)
        }
        let  localMD5 = MD5
        XCTAssertFalse(md5 == localMD5, localMD5)
    }

    func AKTestNoEffect() {
        if let existingOutput = output {
            try! AKManager.test(node: existingOutput, duration: duration, afterStart: afterStart)
        }
        let  localMD5 = MD5
        XCTAssertTrue(localMD5 == sineOscillatorMD5, localMD5)
    }

    override func setUp() {
        super.setUp()
        afterStart = { self.input.start() }
        // This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        AKManager.disconnectAllInputs()
        try! AKManager.stop()
        super.tearDown()
    }

}
