import SwiftUI
import Lottie

struct CustomDialog: View {
    @Binding var isActive: Bool
    let title: String
    let message: String
    let buttonTitle: String
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack{
            Color(.white)
                .opacity(0.1)
                .onTapGesture {
                    close()
                }
            VStack{
                Text(title)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                
                LottieView(animation: .named("Treasure"))
                    .resizable()
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .frame(width: 300, height: 150)
                
                Button {
                    close()
                } label :{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.green)
                        
                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay{
                VStack{
                    HStack{
                        Spacer()
                        
                        Button{
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        .tint(.black)
                    }
                    Spacer()
                }
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x:0, y:offset)
            .onAppear{
                withAnimation(.spring()){
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func close(){
        withAnimation(.spring()){
            offset = 1000
            isActive = false
        }
    }
}
