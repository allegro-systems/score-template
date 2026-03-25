import Score

struct FeatureItem: Node {
    let title: String
    let description: String

    var body: some Node {
        Stack {
            Text { title }
                .font(.sans, size: 16, weight: .semibold, color: .text)
            Text { description }
                .font(.mono, size: 13, color: .muted)
        }
        .flex(.column, gap: 8)
        .padding(20)
        .background(.surface)
        .border(width: 1, color: .border, style: .solid, radius: 8)
    }
}
