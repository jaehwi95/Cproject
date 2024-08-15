//
//  OptionRootView.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/06.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Text("옵션 화면!")
    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel())
}
