//
//  SoundSearchSuggestions.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/17/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI
import RealmSwift

struct SoundSearchSuggestions: View {
    @EnvironmentObject private var viewModel: SoundboardViewModel

    var body: some View {
        ForEach(viewModel.searchResult) { sound in
            Text(sound.title)
                .searchResultStyle()
                .searchCompletion(sound.title)
        }
    }
}

#Preview {
    SoundSearchSuggestions()
}
