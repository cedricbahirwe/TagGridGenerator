//
//  ContentView.swift
//  TagContainer
//
//  Created by Cédric Bahirwe on 05/03/2021.
//

import SwiftUI

struct Tag: Identifiable {
    var id: Int
    var value: String
}

struct Tags: Identifiable {
    var id: Int
    var values: [Tag]
    
    
    static let tags = [
        Tag(id: 1, value: "Covid19"),
        Tag(id: 2, value: "Technology"),
        Tag(id: 3, value: "Health"),
        Tag(id: 4, value: "Auto"),
        Tag(id: 5, value: "Weather"),
        Tag(id: 6, value: "Party"),
        Tag(id: 7, value: "LifeStyle"),
        Tag(id: 8, value: "Comedy"),
        Tag(id: 9, value: "Animals"),
        Tag(id: 10, value: "DIY"),
        
        Tag(id: 11, value: "Poverty"),
        Tag(id: 12, value: "Wealth"),
        Tag(id: 13, value: "Science & Education"),
        Tag(id: 14, value: "Music"),
        Tag(id: 15, value: "Dance"),
        Tag(id: 16, value: "Human health"),
        Tag(id: 17, value: "Travel"),
        Tag(id: 18, value: "Learning"),
        Tag(id: 19, value: "Sports"),
        Tag(id: 20, value: "Cinema")
    ]
}
struct ContentView: View {
    let size = UIScreen.main.bounds.size
    
    @State private var index: Int = 0
    
    @State private var allTags: [Tags] = [Tags(id: 1, values: [])]
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 5)  {
                ForEach(allTags) { allTag in
                    HStack(spacing: 5) {
                        ForEach(allTag.values) { tag in
                            Button(action: {
                                
                            }, label: {
                                Text(tag.value)
                                    .foregroundColor(Color(.label))
                                    .font(.system(size: 10, weight: .semibold))
                                    .padding(.horizontal, 15)
                                    .frame(height: 25)
                                    .background(Color(.systemBackground))
                                    .clipShape(Capsule())
                                
                            })
                            
                        }
                    }
                }
            }
            .padding(10)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .onAppear(perform: energize)
        }
    }
    
    private func energize() {
        for tag in Tags.tags {
            let itemSize = allTags[index].values.map(tagsize).reduce(0, +)
            if itemSize < size.width-10 {
                allTags[index].values.append(tag)
            } else {
                index += 1
                allTags.append(.init(id: index+1, values: []))
                allTags[index].values.append(tag)
            }
        }
    }
    
    private func tagsize(_ tag: Tag) -> CGFloat {
        tag.value.widthOfString(usingFont: .systemFont(ofSize: 14, weight: .semibold)) + 55.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
