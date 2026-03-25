import Score

@Component
struct Counter {
    @State var count = 0

    @Action
    mutating func increment() {
        count += 1
    }

    @Action
    mutating func decrement() {
        count -= 1
    }

    var body: some Node {
        Stack {
            Button {
                Text { "\u{2212}" }
                    .font(.mono, size: 18, weight: .medium, color: .text)
            }
            .on(.click, action: "decrement")
            .padding(8, at: .horizontal)
            .padding(4, at: .vertical)
            .background(.surface)
            .border(width: 1, color: .border, style: .solid, radius: 6)
            .cursor(.pointer)

            Stack {
                Text { "Count: " }
                    .font(.mono, size: 20, weight: .light, color: .text)
                $count
            }
            .flex(.row, gap: 0, align: .baseline)
            .size(minWidth: 100)

            Button {
                Text { "+" }
                    .font(.mono, size: 18, weight: .medium, color: .text)
            }
            .on(.click, action: "increment")
            .padding(8, at: .horizontal)
            .padding(4, at: .vertical)
            .background(.surface)
            .border(width: 1, color: .border, style: .solid, radius: 6)
            .cursor(.pointer)
        }
        .flex(.row, gap: 16, align: .center)
    }
}
