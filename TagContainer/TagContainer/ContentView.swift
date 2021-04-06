//
//  ContentView.swift
//  TagContainer
//
//  Created by Cédric Bahirwe on 05/03/2021.
//

import SwiftUI

struct Tags: Identifiable {
    var id = UUID()
    var values: [Tag]
    
}

struct Tag: Identifiable {
    var id =  UUID()
    var value: String
    static let tags = [
        Tag(value: "Covid19"),
        Tag(value: "Technology"),
        Tag(value: "Health"),
        Tag(value: "Auto"),
        Tag(value: "Weather"),
        Tag(value: "Party"),
        Tag(value: "LifeStyle"),
        Tag(value: "Comedy"),
        Tag(value: "Animals"),
        Tag(value: "DIY"),
        Tag(value: "Poverty"),
        Tag(value: "Wealth"),
        Tag(value: "Science & Education"),
        Tag(value: "Music"),
        Tag(value: "Dance"),
        Tag(value: "Human health"),
        Tag(value: "Travel"),
        Tag(value: "Learning"),
        Tag(value: "Sports"),
        Tag(value: "Cinema")
    ]
}
struct ContentView: View {
    let size = UIScreen.main.bounds.size
    
    @State private var index: Int = 0
    @State private var text: String = ""
    
    @State private var allTags: [Tags] = [Tags(values: [])]
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
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
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(Color.red)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .onAppear(perform: energize)
                
                HStack {
                    TextField("Enter a word", text: $text)
                    
                    Button {
                        let tag = Tag(value: text.trimmingCharacters(in: .whitespaces))
                        addTag(tag: tag)
                        text = ""
                    } label: {
                        Text("Add")
                            .foregroundColor(Color(.systemBackground))
                            .frame(width: 80, height: 32)
                            .background(Color(.label))
                    }
                }
                .padding(.leading)
                .frame(height: 32)
                .background(Color(.systemBackground))
                .clipShape(Capsule())
                .padding(10)
            }
        }
    }
    
    private func energize() {
        for tag in Tag.tags {
            let itemSize = allTags[index].values.map(tagsize).reduce(0, +)
            if itemSize < size.width-10 {
                allTags[index].values.append(tag)
                
            } else {
                index += 1
                allTags.append(.init(values: []))
                allTags[index].values.append(tag)
            }
        }
    }
    
    private func addTag(tag: Tag) {
        let itemSize = allTags[index].values.map(tagsize).reduce(0, +)
        if itemSize < size.width-10 {
            allTags[index].values.append(tag)
        } else {
            index += 1
            allTags.append(.init(values: []))
            allTags[index].values.append(tag)
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
        re
    }
}
