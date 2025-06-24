//
//  ContentView.swift
//  PiedraPapelOTijera
//
//  Created by Luis Cano  on 2025-06-24.
//

import SwiftUI


struct ContentView: View {
    
    let palabras = ["Yan", "Ken", "Po"]
    @State private var index = 0
    @State private var mostrarPalabras = true
    @State private var mostrarOpciones = false
    @State private var mostrarResultado = false
    @State private var yaInicioCuenta = false
    
    @State private var ppt = ["piedra", "papel", "tijera"].shuffled()
    @State private var variableAdivina = Int.random(in: 0..<2)
    
    @State private var score = false
    @State private var tituloScore = ""
    @State private var realScore = 0
    
    var body: some View {
        VStack{
            Text("Yan Ken Po")
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            // Fase 1 : Palabras
            if mostrarPalabras{
                Text(palabras[index])
                    .font(.title)
                    .bold()
                    .onAppear{
                        if !yaInicioCuenta {
                            yaInicioCuenta = true
                            iniciarCuentaRegresiva()
                        }
                    }
                
            }
            
            if mostrarResultado{
                Image(ppt[variableAdivina])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50)
            }
            
            
            // Fase 2:mostrar botones
            
            if mostrarOpciones {
                ForEach(0..<3){i in
                    Button{
                        yankenpo(i)
                    }label:{
                        Text("\(ppt[i])")
                            .font(.title2)
                    }
                }
            }
        }
        .alert(tituloScore , isPresented: $score) {
            Button("Dale", action: reiniciarJuego)
        } message: {
            Text("Your score is \(realScore)")
        }
    }
    
    func yankenpo(_ number : Int){
        mostrarOpciones = false
        variableAdivina = Int.random(in: 0..<3)
        mostrarResultado = true
        
        
        if number == variableAdivina{
            tituloScore = "Ganaste"
            realScore += 1
        }else {
            tituloScore = "ohhhh perdiste"
            realScore -= 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            score = true
        }
        
    }
    
    
    func iniciarCuentaRegresiva(){
        index = 0
        mostrarPalabras = true
        mostrarOpciones = false
        mostrarResultado = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if index < palabras.count - 1 {
                    index += 1
            } else {
                timer.invalidate()
                mostrarPalabras = false
                mostrarOpciones = true
            }
            
        }
    }
    
    func reiniciarJuego(){
        score = false
        index = 0
        yaInicioCuenta = false
        mostrarPalabras = true
        mostrarOpciones = false
        mostrarResultado = false
        variableAdivina = Int.random(in: 0..<3)
        ppt.shuffle()
    }
    
    
}

#Preview {
    ContentView()
}
