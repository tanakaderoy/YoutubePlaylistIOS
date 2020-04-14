//
//  ShowMoreView.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import SwiftUI

struct ShowMoreView: View {
    @Binding var isShrunk: Bool
    var description: String

    var body: some View {
        Group{
            Text(description).lineLimit(self.isShrunk ? 4:100)
            HStack{
                Spacer()
                Text( isShrunk ? "Show More" : "Show Less")
            }
        }
    }
}

struct ShowMoreView_Previews: PreviewProvider {
    static var previews: some View {
        ShowMoreView(isShrunk: .constant(false), description: "Hello")
    }
}
