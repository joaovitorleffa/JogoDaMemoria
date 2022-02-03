//
//  JogoDaMemoriaTests.swift
//  JogoDaMemoriaTests
//
//  Created by joaovitor on 02/02/22.
//

import XCTest
@testable import JogoDaMemoria

class JogoDaMemoriaTests: XCTestCase {
    var jogoDaMemoria: JogoDaMemoria!
    
    
    override func setUp() {
        jogoDaMemoria = JogoDaMemoria(conteudo: ["imagem-1", "imagem-2"], embaralhar: false)
    }
    
    func test_escolhendoDuasCartasDiferentes_deveManterAsDuasCartasViradasParaBaixo() {
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[0])
        
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[2])
    
        XCTAssertTrue(jogoDaMemoria.cartas.allSatisfy({ $0.jaFoiEncontrada == false }))
    }

    func test_escolhendoDuasCartasIguais_deveVirarAsDuasCartasParaCima() {
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[0])
        
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[1])
        
        XCTAssertTrue(jogoDaMemoria.cartas[0].jaFoiEncontrada == true && jogoDaMemoria.cartas[1].jaFoiEncontrada == true)
    }
    
    func test_tentarGanharOJogo_deveEstarComTodasAsCartasViradasParaCima() {
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[0])
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[1])
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[2])
        
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[3])
        
        XCTAssertTrue(jogoDaMemoria.verificaSeGanhou())
    }
}
