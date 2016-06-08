//
//  pokemonCell.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 08.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class pokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var obrazekPokemona: UIImageView!
    @IBOutlet weak var podpisPokemona: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func skonfigurujKomorke(pokemon: Pokemon){
        self.pokemon = pokemon //jeżeli zmienilibyśmy pokemon w funkcji na inne nie musielibyśmy wstawiac self, bo zauważ że pokemon używamy dwa razy
        podpisPokemona.text = pokemon.imie.capitalizedString
        obrazekPokemona.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
    
}
