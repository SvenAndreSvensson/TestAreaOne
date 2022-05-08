//
//  ContentView.swift
//  TestAreaOne
//
//  Created by Sven Svensson on 06/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    SearchItemsView(model: .init(
                        recentItems: [
                            .init(id: "1", title: "Sommer"),
                            .init(id: "2", title: "Vinter"),
                            .init(id: "3", title: "Hello"),
                        ],
                        savedItems: [
                            .init(id: "4", title: "Kari"),
                            .init(id: "5", title: "Knut"),
                            .init(id: "6", title: "Per"),
                        ])
                    )
                } label: {
                    createTestAreaOneListItem(
                        title: "Scrollview",
                        systemName: "scroll",
                        description: "Scrollview, clipping, contextmenu, card with shadow ")
                }

                NavigationLink(destination: TransactionExampleView()) {
                    createTestAreaOneListItem(
                        title: "Transaction",
                        systemName: "film",
                        description: "Transition, rotationEffect")
                }
            }
        }
    }

    func createTestAreaOneListItem(title: String, systemName: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: systemName)
                Text(title)
            }
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
