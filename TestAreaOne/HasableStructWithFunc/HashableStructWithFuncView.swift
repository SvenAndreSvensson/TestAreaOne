//
//  HashableStructWithFunc.swift
//  TestAreaOne
//
//  Created by Sven Svensson on 13/10/2022.
//



// This test is to add a function to a struct and also conform to hashable protocol
//

import SwiftUI

typealias voidFunction = () -> Void

struct EnTest: Hashable {
    var name: String
    var action: voidFunction?

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: EnTest, rhs: EnTest) -> Bool {
        lhs.name == rhs.name
    }

}

struct HashableStructWithFuncView: View {


    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HashableStructWithFunc_Previews: PreviewProvider {
    static var previews: some View {
        HashableStructWithFuncView()
    }
}
