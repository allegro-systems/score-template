import Foundation
import Score

/// CRUD controller for managing items via a JSON API.
@Controller("/api/items")
struct ItemsController {

    @Route(method: .get)
    func listItems(_ ctx: RequestContext) async throws -> Response {
        try .json(ItemStore.shared.all())
    }

    @Route(method: .post)
    func createItem(_ ctx: RequestContext) async throws -> Response {
        guard let body = ctx.body,
            let input = try? JSONDecoder().decode(CreateInput.self, from: body)
        else {
            return .error("Invalid request body")
        }

        let id = input.id.flatMap(UUID.init(uuidString:)) ?? UUID()
        let item = Item(id: id, title: input.title, description: input.description)
        ItemStore.shared.add(item)

        return try .json(item, status: .created)
    }

    @Route(":id", method: .put)
    func updateItem(_ ctx: RequestContext) async throws -> Response {
        guard let idString = ctx.pathParameters["id"],
            let id = UUID(uuidString: idString)
        else {
            return .error("Invalid item ID")
        }

        guard let body = ctx.body,
            let input = try? JSONDecoder().decode(Item.self, from: body)
        else {
            return .error("Invalid request body")
        }

        let updated = Item(id: id, title: input.title, description: input.description)
        guard ItemStore.shared.update(updated) else {
            return .error("Item not found", status: .notFound)
        }

        return try .json(updated)
    }

    @Route(":id", method: .delete)
    func deleteItem(_ ctx: RequestContext) async throws -> Response {
        guard let idString = ctx.pathParameters["id"],
            let id = UUID(uuidString: idString)
        else {
            return .error("Invalid item ID")
        }

        guard ItemStore.shared.remove(id) else {
            return .error("Item not found", status: .notFound)
        }

        return .ok
    }
}

private struct CreateInput: Codable {
    let id: String?
    let title: String
    let description: String
}
