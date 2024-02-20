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

    private var sortedSounds: Results<SoundModel> {
        viewModel.items!.sorted(by: \.title, ascending: true)
    }

    var body: some View {
        ForEach(sortedSounds) { sound in
            Text(sound.title)
                .searchResultStyle()
                .searchCompletion(sound.title)
        }
    }
}

#Preview {
    SoundSearchSuggestions()
}
