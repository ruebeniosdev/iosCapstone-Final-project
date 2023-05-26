//
//  DetailItem.swift
//  LittleLemonApp
//
//  Created by D. Rakyan Erlangga Rizki Wardhana on 23.05.2023.
//

import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ScrollView {
            Spacer(minLength: 70)
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.04)
                    ProgressView("Loading")
                }
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            .padding(.vertical, 20)
            Text(dish.title ?? "")
                .font(.subTitleFont())
                .foregroundColor(.primaryColor1)
            Spacer(minLength: 20)
            Text(dish.descriptionDish ?? "")
                .font(.regularText())
                .padding(.horizontal)
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
                .font(.highlightText())
                .foregroundColor(.primaryColor1)
                .monospaced()
            //Spacer()
            
        }
        .navigationTitle(dish.title ?? "")
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
