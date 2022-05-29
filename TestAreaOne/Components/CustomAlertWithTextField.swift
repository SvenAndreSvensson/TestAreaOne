import SwiftUI

struct CustomAlertWithTextField: View {
    @State var isShowingEditField = false
    @State var text: String = "12345"

    var body: some View {
        ZStack {
            VStack {
                Text("Value is \(self.text)")
                Button(action: {
                    print("button")
                    self.isShowingEditField = true
                }) {
                    Text("Tap To Test")
                }
            }
            .disabled(self.isShowingEditField)
            .opacity(self.isShowingEditField ? 0.25 : 1.00)

            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 300, height: 100)
                    .shadow(radius: 1) // moved shadow here, so it doesn't affect TextField now

                VStack(alignment: .center) {
                    Text("Edit the text")
                    TextField("", text: self.$text)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(width: 298)

                    Divider().frame(width: 300)

                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowingEditField = false
                                print("completed... value is \(self.text)")
                            }
                        }) {
                            Text("OK")
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .disabled(!self.isShowingEditField)
            .opacity(self.isShowingEditField ? 1.0 : 0.0)
        }
    }
}
