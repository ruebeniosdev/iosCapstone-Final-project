//
//  Menu.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    @State var isKeyboardVisible = false
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    @State var selectedTab = "all" // Added selectedTab state variable
    @State var loaded = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if !isKeyboardVisible {
                        withAnimation() {
                            Hero()
                                .frame(maxHeight: 180)
                        }
                    }
                    CustomSearch(searchText: $searchText)
                    //.textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color.primaryColor1)
                
                Text("ORDER FOR DELIVERY!")
                    .font(.sectionTitle())
                    .foregroundColor(.highlightColor2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Button("All") {
                                selectedTab = "all"
                                getMenuData()
                            }
                            .fontWeight(.bold)
                            .foregroundColor(selectedTab == "all" ? Color.white : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .background(
                                selectedTab == "all" ?  Color.primaryColor1 : Color.highlightColor1
                            )
                            .cornerRadius(16)
                            
                            
                            Button("Starters") {
                                selectedTab = "starters"
                                getMenuData()
                            }
                            .foregroundColor(selectedTab == "starters" ? Color.white : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .background(
                                selectedTab == "starters" ?  Color.primaryColor1 : Color.highlightColor1
                            )
                            .cornerRadius(16)
                            
                            Button("Mains") {
                                selectedTab = "mains"
                                getMenuData()
                            }
                            .foregroundColor(selectedTab == "mains" ? Color.white : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .background(
                                selectedTab == "mains" ?  Color.primaryColor1 : Color.highlightColor1
                            )
                            .cornerRadius(16)
                            
                            Button("Desserts") {
                                selectedTab = "desserts"
                                getMenuData()
                                
                            }
                            .foregroundColor(selectedTab == "desserts" ? Color.white : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .background(
                                selectedTab == "desserts" ? Color.primaryColor1 : Color.highlightColor1
                            )
                            .cornerRadius(16)
                            
                            Button("Drinks") {
                                selectedTab = "drinks"
                                getMenuData()
                            }
                            .foregroundColor(selectedTab == "drinks" ? Color.white : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                            .background(
                                selectedTab == "drinks" ? Color.primaryColor1 : Color.highlightColor1
                            )
                            .cornerRadius(16)
                        }
                        //.padding(.horizontal)
                    }
                    //.toggleStyle(MyToggleStyle())
                    .padding(.horizontal)
                }
                FetchedObjects(predicate: buildPredicate(selectedTab: selectedTab),
                               sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink(destination: DetailItem(dish: dish)) {
                            FoodItem(dish: dish)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .onAppear {
            if !loaded {
                MenuList.getMenuData(viewContext: viewContext)
                loaded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
            }
        }
    }
    
    func getMenuData() {
        MenuList.getMenuData(viewContext: viewContext)
       }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate(selectedTab: String) -> NSCompoundPredicate {
            let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
            var categoryPredicate: NSPredicate
            
            switch selectedTab {
            case "starters":
                categoryPredicate = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
            case "mains":
                categoryPredicate = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
            case "desserts":
                categoryPredicate = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
            case "drinks":
                categoryPredicate = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
            default:
                categoryPredicate = NSPredicate(value: true) // Default to show all categories
            }
            
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, categoryPredicate])
            return compoundPredicate
        }

}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
