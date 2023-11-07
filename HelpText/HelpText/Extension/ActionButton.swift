//
//  ActionButton.swift
//  HelpText
//
//  Created by yujaehong on 2023/10/30.
//

import SwiftUI

struct ActionButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var subtitle: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 13) {
                    Spacer()
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(red: 249.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, opacity: 0.85))
                    Text(subtitle)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Spacer()
                }
                .padding(5)
                Spacer()
            }
            .padding(.leading, 5)

        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

struct ActionButton2: View {
    var title: String
    var subtitle: String
    var action: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 13) {
                    Spacer()
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(red: 249.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, opacity: 0.85))
                    Text(subtitle)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    Spacer()
                }
                .padding(5)
                Spacer()
            }
            .padding(.leading, 20)

        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }
}

