//
//  SoundboardPadList.swift
//  Soundboard
//
//  Created by Pawel Milek on 2/16/24.
//  Copyright © 2024 Pawel Milek. All rights reserved.
//

import SwiftUI

struct SoundboardPadList: View {
    @EnvironmentObject private var viewModel: SoundboardViewModel
    @Binding var selectedSoundId: String?

    var body: some View {
        List(viewModel.searchResult, selection: $selectedSoundId) { sound in
            SoundboardPadRow(item: sound)
        }
    }
}

#Preview {
    SoundboardPadList(selectedSoundId: .constant(""))
}
