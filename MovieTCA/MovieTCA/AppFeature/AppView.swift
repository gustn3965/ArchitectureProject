//
//  AppView.swift
//  MovieTCA
//
//  Created by 박현수 on 8/12/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import Combine

public struct AppView: View {
    
    var store: StoreOf<AppFeature>
    
    public var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            MovieListView(store: store.scope(state: \.movieListState, action: \.list))
        }
    }
}
