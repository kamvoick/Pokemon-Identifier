//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 08.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _imie: String!
    private var _pokedexId: Int!
    private var _typ: String!
    private var _obrona: String!
    private var _wysokosc: String!
    private var _waga: String!
    private var _podstawowyAtak: String!
    private var _nastepnaEwolucjaTekst: String!
    private var _następnaEwolucjaId: String!
    private var _następnaEwolucjaLVL: String!
    private var _pokemonUrl: String!
    private var _opis: String!
    
    var imie:String{
        return _imie
    }
    var pokedexId:Int{
        return _pokedexId
    }
    
    var typ:String{
        if _typ == nil{
            _typ = ""
        }
        return _typ
    }
    
    var obrona:String{
        if _obrona == nil{
            _obrona = ""
        }
        return _obrona
    }
    
    var wysokość:String{
        if _wysokosc == nil{
            _wysokosc = ""
        }
        return _wysokosc
    }
    
    var waga:String{
        if _waga == nil{
            _waga = ""
        }
        return _waga
    }
    
    var podstawowyAtak:String{
        if _podstawowyAtak == nil{
            _podstawowyAtak = ""
        }
        return _podstawowyAtak
    }
    
    var następnaEwolucjaTekst:String{
        if _nastepnaEwolucjaTekst == nil{
            _nastepnaEwolucjaTekst = ""
        }
        return _nastepnaEwolucjaTekst
    }
    
    var następnaEwolucjaId: String
    {
        if _następnaEwolucjaId == nil
        {
            _następnaEwolucjaId = ""
        }
        return _następnaEwolucjaId
    }
    
    init(imie: String, pokedexId: Int){
        self._imie = imie
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(urlPodstawowy)\(urlPokemona)\(self._pokedexId)/"
    }
    //kiedy sciaganie bedzie skonczone wykonamy ta funkcje tutaj, poniewaz w przypadku gdy pykniemy na naszego poka sciagniete dane nie beda od razu wsadzone, trzeba powiedziec zeby sie wsadzily tam gdzie maja byc
    func sciagnijSzczegolyPokemonow(Skonczone: sciaganieSkonczone) {
        let url = NSURL(string: _pokemonUrl)! //zawsze musimy zamienic nasz url na nsurl
        
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let waga = dict["weight"] as? String{
                    self._waga = waga
                }
                
                if let wysokość = dict["height"] as? String{
                    self._wysokosc = wysokość
                }
                
                if let atak = dict["attack"] as? Int{
                    self._podstawowyAtak = "\(atak)"
                }
                if let obrona = dict["defense"] as? Int{
                    self._obrona = "\(obrona)"
                }
                
                if let typy = dict["types"] as? [Dictionary<String, String>] where typy.count > 0
                {
                    if let name = typy[0]["name"]
                    {
                        self._typ = name.capitalizedString
                    }
                    if typy.count > 1
                    {
                        for var x = 1; x < typy.count; x++
                        {
                            if let name = typy[x]["name"]
                            {
                                self._typ! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                }
                else
                {
                    self._typ = "";
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0
                {
                    if let url = descArr[0]["resource_uri"]
                    {
                        let nsurl = NSURL(string: "\(urlPodstawowy)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON
                            { (response: Response<AnyObject, NSError>) -> Void in
                                
                                if let descDict = response.result.value as? Dictionary<String, AnyObject>
                                {
                                    if let description = descDict["description"] as? String
                                    {
                                        self._opis = description
                                    }
                                }
                                
                                Skonczone()
                        }
                    }
                }
                else
                {
                    self._opis = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0
                {
                    if let to = evolutions[0]["to"] as? String
                    {
                        //Can't support Mega Pokemon right now
                        if to.rangeOfString("mega") == nil
                        {
                            if let uri = evolutions[0]["resource_uri"] as? String
                            {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")

                                self._następnaEwolucjaId = num
                                self._nastepnaEwolucjaTekst = to
                                
                                if let lvl = evolutions[0]["level"] as? Int
                                {
                                    self._następnaEwolucjaLVL = "\(lvl)"
                                }
                                else
                                {
                                    if let method = evolutions[0]["method"] as? String
                                    {
                                        self._następnaEwolucjaLVL = method
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
            }


            
            }

        
        } //działamy na alamofire, pobieramy (.GET)
    }
