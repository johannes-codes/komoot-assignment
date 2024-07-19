//
//  MessageView.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 19.07.24.
//

import SwiftUI

struct MessageView: View {
    var message: String
    var isError: Bool

    var body: some View {
        Text("\(Image(systemName: isError ? "exclamationmark.triangle.fill" : "info.circle")) \(message)")
            .frame(maxWidth: .infinity)
            .font(.system(.footnote))
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding()
            .background(isError ? Color.red.opacity(0.5) : Color.gray.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
