//import SwiftUI
//
//struct LinescoreView: View {
//    let linescore: LineScore
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text("Inning")
//                Spacer()
//                Text("Home")
//                Spacer()
//                Text("Away")
//            }
//            .font(.headline)
//            .padding(.bottom, 2)
//            
//            ForEach(linescore.currentInning, id: \.num) { inning in
//                HStack {
//                    Text("\(inning.num)")
//                    Spacer()
//                    Text("\(inning.home ?? 0)")
//                    Spacer()
//                    Text("\(inning.away ?? 0)")
//                }
//            }
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}
