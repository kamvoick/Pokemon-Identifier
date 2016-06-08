//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 08.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation
class Pokemon {
    private var _imie: String!
    private var _pokedexId: Int!
    
    var imie:String{
        return _imie
    }
    var pokedexId:Int{
        return _pokedexId
    }
    
    init(imie: String, pokedexId: Int){
        self._imie = imie
        self._pokedexId = pokedexId
    }
}