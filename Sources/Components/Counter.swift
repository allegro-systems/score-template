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
            Stack {
                $count
            }
            .font(.mono, size: 32, weight: .light, color: .text)

            Stack {
                Button {
                    Text { "\u{2212}" }
                        .font(.mono, size: 16, weight: .medium, color: .text)
                }
                .on(.click, action: "decrement")
                .padding(6, at: .vertical)
                .padding(12, at: .horizontal)
                .background(.surface)
                .border(width: 1, color: .border, style: .solid, radius: 6)
                .cursor(.pointer)
                .hover { $0.background(.elevated) }

                Button {
                    Text { "+" }
                        .font(.mono, size: 16, weight: .medium, color: .text)
                }
                .on(.click, action: "increment")
                .padding(6, at: .vertical)
                .padding(12, at: .horizontal)
                .background(.surface)
                .border(width: 1, color: .border, style: .solid, radius: 6)
                .cursor(.pointer)
                .hover { $0.background(.elevated) }
            }
            .flex(.row, gap: 8)
        }
        .flex(.column, gap: 12, align: .center)
    }
}
