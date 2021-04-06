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

struct Tag: Identifiable, Hashable, Equatable {
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
    let timer = Timer.publish(every: 0.8, on: .current, in: .common).autoconnect()
    @State private var allTags: [Tags] = [Tags(values: [])]
    @State private var selectedtags: [Tag] = []
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
                                    withAnimation {
                                        if selectedtags.contains(tag) {
                                            selectedtags.removeAll(where: { $0.id == tag.id})
                                        } else {
                                            selectedtags.append(tag)
                                        }
                                    }
                                }, label: {
                                    Text(tag.value)
                                        .foregroundColor(
                                            selectedtags.contains(tag) ?
                                            Color(.systemBackground) :
                                            Color(.label)
                                        )
                                        .font(.system(size: 12, weight: .semibold))
                                        .padding(.horizontal, 15)
                                        .frame(height: 25)
                                        .background(
                                            selectedtags.contains(tag) ?
                                            Color(.label) :
                                            Color(.systemBackground)
                                        )
                                        .clipShape(Capsule())
                                    
                                })
                                
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .onAppear(perform: energize)
                
                
                HStack {
                    TextField("Enter a word", text: $text)
                    
                    Button {
                        withAnimation {
                            let tag = Tag(value: text.trimmingCharacters(in: .whitespaces))
                            addTag(tag: tag)
                            text = ""
                        }
                        
                    } label: {
                        Text("Add")
                            .foregroundColor(Color(.systemBackground))
                            .frame(width: 80, height: 32)
                            .background(Color(.label))
                    }
                    .disabled(text.trimmingCharacters(in: .whitespaces).count < 3)
                }
                .padding(.leading)
                .frame(height: 32)
                .background(Color(.systemBackground))
                .clipShape(Capsule())
                .padding(10)
                // Uncomment if you want to see some extra sauce animation
//                .onReceive(timer, perform: animation)
            }
        }
    }
    
    private func energize() {
        for tag in Tag.tags {
            addTag(tag: tag)
        }
    }
    
    private func addTag(tag: Tag) {
        let itemSize = allTags[index].values.map(tagsize).reduce(0, +)
        let tagSize = tagsize(tag)
        let containerWidth = size.width - 20
        if itemSize + tagSize <= containerWidth {
            allTags[index].values.append(tag)
        } else {
            index += 1
            allTags.append(.init(values: []))
            allTags[index].values.append(tag)
                
        }
    }
    
    private func tagsize(_ tag: Tag) -> CGFloat {
        let margins: CGFloat = 5.0
        let paddings: CGFloat = 30
        return tag.value.widthOfString(usingFont: .systemFont(ofSize: 11, weight: .semibold)) + margins + paddings
    }
    
    private func animation(_ timer: Timer.TimerPublisher.Output) {
        let mainTags = allTags.map({$0.values}).flatMap({ $0 })
        let index = Int.random(in: 0..<mainTags.count)
        withAnimation {
            if selectedtags.contains(mainTags[index]) {
                selectedtags.removeAll(where: { $0.id == mainTags[index].id })
            } else {
                selectedtags.append(mainTags[index])
            }
        }
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
