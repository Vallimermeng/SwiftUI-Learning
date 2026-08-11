import SwiftUI


struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var isShowAnotherPercentage = false
    @State private var isZeroPercentage = false
    var typesAmount: [String] = ["Общая сумма", "Итого на человека"]
    @State private var selectedAmount = "Общая сумма"
    
    
    let tipPercentages = [10,15,20,25,0] //choose tip percentages
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        let total = checkAmount + tipValue
        
        return total
    }
    
    
    
    var body: some View {
        NavigationStack{
            
            Form{
                Section("Сумма чека"){
                    TextField("Чек", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Picker("Количество гостей", selection: $numberOfPeople){
                    ForEach(2..<100){
                        Text("\($0) человек")
                    }
                }.pickerStyle(.navigationLink)
                
                
                Section("Процент чаевых"){
                    Picker("Процент чаевых", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                    
                    
                    
                    Button("Выбрать определенный процент"){
                        isShowAnotherPercentage.toggle()
                    }
                
                    if isShowAnotherPercentage{
                        TextField("Ваш процент", value: $tipPercentage, format: .percent)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    
                }
                
                Section("Выберите тип чека"){
                    Picker("Тип чека", selection: $selectedAmount){
                        ForEach(typesAmount, id: \.self){
                            Text("\($0) ")
                        }
                    }
                }
                
                
                switch selectedAmount{
                case "Итого на человека":
                    Section("Итого на человека"){
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                case "Общая сумма":
                    Section("Общая сумма"){
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).background(tipPercentage == 0 ? Color.red.opacity(0.75) : Color.clear).cornerRadius(10)
                    }
                default:
                    EmptyView()
                }
                
               
           
            }
            //navigationStack:
            .navigationTitle("Чек")
            
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    
    }
    
    
}





#Preview {
    ContentView()
}

