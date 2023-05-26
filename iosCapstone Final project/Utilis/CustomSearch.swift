//
//  CustomSearch.swift
//  iosCapstone Final project
//
//  Created by Rueben on 26/05/2023.
//

import SwiftUI

struct CustomSearch: View {
    @Binding  var searchText: String
    var body: some View {
        HStack {
           Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search menu", text: $searchText)
                .autocorrectionDisabled(true)
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CustomSearch_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearch(searchText: .constant(""))
    }
}
