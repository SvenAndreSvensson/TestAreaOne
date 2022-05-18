//
//  GitContent.swift
//  TestAreaOne
//
//  Created by Sven Svensson on 18/05/2022.
//

import SwiftUI

struct GitContent: View {
    var body: some View {
        VStack {
            Text("Hello, World!, testing git reset HEAD^, what does it mean")
                .padding()

            Text("hello again")
        }
    }
}

struct GitContent_Previews: PreviewProvider {
    static var previews: some View {
        GitContent()
    }
}
