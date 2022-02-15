//
//  MemoriaViewController.swift
//  JogoDaMemoria
//
//  Created by joaovitor on 02/02/22.
//

import UIKit

class MemoriaViewController: UIViewController {
    private var jogoDaMemoria = JogoDaMemoria.novoJogo()
    
    @IBOutlet var botoesDeCarta: [UIButton]!
    
    @IBAction func toqueBotaoCarta(_ sender: UIButton) {
        jogoDaMemoria.escolherCarta(jogoDaMemoria.cartas[sender.tag])
        atualizarTela()
        if jogoDaMemoria.verificaSeGanhou() == true { notificarVitoria() }
    }
    
    @IBAction func reiniciar() {
        reiniciarJogo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        criarSombra()
    }
    
    func criarSombra() {
        for botao in botoesDeCarta {
            adicionarSombraAoBotao(botao)
        }
    }
    
    func reiniciarJogo() {
        jogoDaMemoria = JogoDaMemoria.novoJogo()
        atualizarTela()
    }
}

// MARK: - UI
extension MemoriaViewController {
    func atualizarTela() {
        for botao in botoesDeCarta {
            let carta = jogoDaMemoria.cartas[botao.tag]
            
            if carta.estaViradaParaCima == true {
                botao.setImage(UIImage(named: carta.conteudo), for: .normal)
            } else if carta.jaFoiEncontrada == true {
                botao.layer.opacity = 0
            } else {
                botao.layer.opacity = 1
                botao.setImage(UIImage(named: "card-logo"), for: .normal)
            }
        }
    }
    
    func adicionarSombraAoBotao(_ botao: UIButton) {
        botao.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        botao.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        botao.layer.shadowOpacity = 1
        botao.layer.shadowRadius = 8
        botao.layer.masksToBounds = false
        botao.layer.cornerRadius = 8
    }
    
    func notificarVitoria() {
        let alerta = UIAlertController(
            title: "Boa, você terminou!",
            message: "Você precisou de \(jogoDaMemoria.tentativas) tentativas para finalizar o jogo da memória",
            preferredStyle: .alert
        )
        
        alerta.addAction(
            UIAlertAction(title: "Bacana, bora de novo", style: .default) { _ in
                self.reiniciarJogo()
            }
        )
        
        present(alerta, animated: true)
    }
}
