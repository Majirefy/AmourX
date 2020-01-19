//
//  ContentView.swift
//  AmourX
//
//  Created by Fangcheng Song on 2020/1/8.
//  Copyright © 2020 Fangcheng Song. All rights reserved.
//

import SwiftUI
import Alamofire
import KingfisherSwiftUI

struct ContentView: View {
    @State var imageURL: String = ""
    @State var quote: String = "Love is love, as always."
    @State var author: String = "Majirefy"
    @State var category: String = "Love"
    @State var tags: [String] = []
    
    private let mainGradient = LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    private let musicGradient = LinearGradient(gradient: Gradient(colors: [Color.pink, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text(category.capitalized)
                    .font(.largeTitle)
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                Button(action: {}) {
                    Image(systemName: "music.note")
                        .foregroundColor(.pink)
                        .padding()
                }
                .background(Circle().stroke(musicGradient, lineWidth: 2))
            }
            KFImage(URL(string: imageURL))
                .placeholder {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
            }
            .resizable()
            .scaledToFit()
            .cornerRadius(24)
            .shadow(radius: 12)
            Text(quote)
                .italic()
                .font(.custom("Didot-Italic", size: 24))
                .padding()
            Text(author)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding()
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Capsule().fill(Color.blue))
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding()
            Spacer()
            Button(action: {
                Alamofire.request("https://quotes.rest/qod.json?category=life").responseData{ response in
                    switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        do {
                            let responseData = try JSONDecoder().decode(ResponseData.self, from: data)
                            self.imageURL = responseData.contents.quotes[0].background
                            self.quote = responseData.contents.quotes[0].quote
                            self.author = responseData.contents.quotes[0].author
                            self.category = responseData.contents.quotes[0].category
                            self.tags = responseData.contents.quotes[0].tags
                        } catch let error {
                            print(error)
                        }
                    }
                }
            }) {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("Amour")
                    }
                    .padding()
                    .foregroundColor(.red)
                }
                .background(Capsule().stroke(mainGradient, lineWidth: 2).saturation(1.8))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageURL: "https://theysaidso.com/img/bgs/man_on_the_mountain.jpg")
    }
}
