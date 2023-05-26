import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ExampleDatabase")
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores(completionHandler: {_,_ in })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
    }
    
    static func oneDish() -> Dish {
        let dish = Dish(context: shared.container.viewContext)
        dish.title = "Greek Salad"
        dish.descriptionDish = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
        dish.price = "10"
        dish.category = "starters"
        dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
        return dish
    }
}

//class MyNew_Preview: WebPreview {
//	override class var title: String { "My preview" } // optional
//	override class var width: UInt { 100 } // optional
//	override class var height: UInt { 100 } // optional
//
//	@Preview override class var content: Preview.Content {
//		// add styles if needed
//		// AppStyles.id(.happyStyle)
//		// add here as many elements as needed
//		Div("Hello world")
//	}
//}
//
//class MyNew_Preview: WebPreview {
//	override class var title: String { "My preview" } // optional
//	override class var width: UInt { 100 } // optional
//	override class var height: UInt { 100 } // optional
//
//	@Preview override class var content: Preview.Content {
//		// add styles if needed
//		// AppStyles.id(.happyStyle)
//		// add here as many elements as needed
//		Div("Hello world")
//	}
//}
//
//class MyNew_Preview: WebPreview {
//	override class var title: String { "My preview" } // optional
//	override class var width: UInt { 100 } // optional
//	override class var height: UInt { 100 } // optional
//
//	@Preview override class var content: Preview.Content {
//		// add styles if needed
//		// AppStyles.id(.happyStyle)
//		// add here as many elements as needed
//		Div("Hello world")
//	}
//}
//
//class MyNew_Preview: WebPreview {
//	override class var title: String { "My preview" } // optional
//	override class var width: UInt { 100 } // optional
//	override class var height: UInt { 100 } // optional
//
//	@Preview override class var content: Preview.Content {
//		// add styles if needed
//		// AppStyles.id(.happyStyle)
//		// add here as many elements as needed
//		Div("Hello world")
//	}
//}
