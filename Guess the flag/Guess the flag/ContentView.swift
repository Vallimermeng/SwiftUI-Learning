//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showinScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
    @State private var attempt = 0
    
    
    var body: some View {
        ZStack{
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.5, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.45, blue: 0.46), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            
            VStack{
                Spacer()
                Text("Угадай флаг").fontLarge().foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Счет: \(score)").foregroundStyle(.white).font(.title.bold())
                
                if(averageRate().isNaN){
                    Text("Рейтинг: 0%").foregroundStyle(.white).font(.title.bold())
                }else{
                    Text("Рейтинг: \(averageRate())%        ").foregroundStyle(.white).font(.title.bold())
                }
                
                Spacer()
                
                VStack(spacing: 15){
                    VStack{
                        Text("Нажмите на флаг").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).fontLarge()
                    }
                    
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label:{
                            FlagImage(name: countries[number])
                        }
                    }
                }
                //Vstack 15
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
        //ZStack
        .ignoresSafeArea()
        .alert(scoreTitle, isPresented: $showinScore){ // ?
            Button("Продолжить", action: askQuestion)
        }message: {
            Text("Ваш счет: \(score). Оценка: \(averageRate()) %")
            
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Верно"
            score+=1
            attempt+=1
        }else{
            scoreTitle = "Неверно, это флаг \(countries[number])"
            attempt+=1
        }
        showinScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func averageRate() -> Double{
        
        let score_tmp = Double(score)
        let attemp_tmp = Double(attempt)
        let result = (score_tmp /  (attemp_tmp)) * 100
        return result
    }
    
}

struct FlagImage: View{
    var name: String
    
    var body: some View{
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}


struct LargeTitleHeader: ViewModifier{ // for large names
    func body(content: Content) -> some View{
        content
            .font(.largeTitle.weight(.bold))
            
    }
}

extension View {
    func fontLarge() -> some View {
        modifier(LargeTitleHeader())
    }
}


#Preview {
    ContentView()
}
