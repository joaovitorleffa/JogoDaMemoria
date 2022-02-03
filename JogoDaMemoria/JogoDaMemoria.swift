//
//  JogoDaMemoria.swift
//  JogoDaMemoria
//
//  Created by joaovitor on 03/02/22.
//

import Foundation
import UIKit

class JogoDaMemoria {
    private(set) var tentativas = 0
    private(set) var cartas: [Carta]
    private var indiceDaPrimeiraEUnicaCartaViradaParaCima: Int?
    
    init(conteudo: [String], embaralhar: Bool) {
        let totalDeCartas = conteudo.count
        cartas = []
        
        for indice in 0..<totalDeCartas {
            cartas.append(Carta(conteudo: conteudo[indice], id: indice * 2))
            cartas.append(Carta(conteudo: conteudo[indice], id: indice * 2 + 1))
        }
        
        if embaralhar == true {
            cartas.shuffle()
        }
    }
    
    func verificaSeGanhou() -> Bool {
        cartas.allSatisfy { $0.jaFoiEncontrada }
    }
    
    func escolherCarta(_ carta: Carta) {
        if let indiceDaCarta = cartas.firstIndex(where: { $0.id == carta.id }),
           !cartas[indiceDaCarta].estaViradaParaCima,
           !cartas[indiceDaCarta].jaFoiEncontrada
        {
            if let potencialIndiceDeAcerto = indiceDaPrimeiraEUnicaCartaViradaParaCima{
                if cartas[indiceDaCarta].conteudo == cartas[potencialIndiceDeAcerto].conteudo {
                    cartas[indiceDaCarta].jaFoiEncontrada = true
                    cartas[potencialIndiceDeAcerto].jaFoiEncontrada = true
                }
                indiceDaPrimeiraEUnicaCartaViradaParaCima = nil
            } else {
                for indice in cartas.indices {
                    cartas[indice].estaViradaParaCima = false
                }
                tentativas += 1
                indiceDaPrimeiraEUnicaCartaViradaParaCima = indiceDaCarta
            }
            cartas[indiceDaCarta].estaViradaParaCima.toggle()
        }
    }
    
    struct Carta {
        var conteudo: String
        var estaViradaParaCima = false
        var jaFoiEncontrada = false
        var id: Int
    }
}

extension JogoDaMemoria {
    class func novoJogo() -> JogoDaMemoria {
        return JogoDaMemoria(conteudo: conteudoDasCartas, embaralhar: true)
    }
}

private let conteudoDasCartas = [
    "001-knight",
    "002-wizard",
    "003-dwarf",
    "004-elf",
    "005-witch"
]
