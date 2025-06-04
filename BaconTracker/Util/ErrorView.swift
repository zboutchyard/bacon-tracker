//
//  ErrorView.swift
//  Pong
//
//  Created by Zack Boutchyard on 5/15/25.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(maxHeight: 75)
                .padding()
                .overlay {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                        Text("Oops! Something went wrong")
                            .font(.custom("Fredoka-Bold", size: 20))
                    }
                }
        }
        .background(Image(.landingViewBackground))
    }
}

#Preview {
    ErrorView()
}
