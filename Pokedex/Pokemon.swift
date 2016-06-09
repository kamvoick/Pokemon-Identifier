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
    private var _typ: String!
    private var _obrona: String!
    private var _wysokosc: String!
    private var _waga: String!
    private var _podstawowyAtak: String!
    private var _nastepnaEwolucjaTekst: String!
    
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