//
//  szczegolyPokemonaVC.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 09.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit

class szczegolyPokemonaVC: UIViewController {

    @IBOutlet weak var nazwaPokemona: UILabel!
    @IBOutlet weak var obrazekPokemona: UIImageView!
    @IBOutlet weak var typPokemona: UILabel!
    @IBOutlet weak var wysokoscPokemona: UILabel!
    @IBOutlet weak var wagaPokemona: UILabel!
    @IBOutlet weak var obronaPokemona: UILabel!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var podstawowyAtak: UILabel!
    
    @IBOutlet weak var pierwszaEwolucja: UIImageView!
    @IBOutlet weak var drugaEwolucja: UIImageView!
    
    @IBOutlet weak var tekstEwolucji: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(self.pokemon.pokedexId)")
        nazwaPokemona.text = pokemon.imie.capitalizedString
        obrazekPokemona.image = img
        pierwszaEwolucja.image = img
        pokedexID.text = "\(pokemon.pokedexId)"
        
        pokemon.sciagnijSzczegolyPokemonow({  //kod który będzie tutaj wykona się dopiero po ściągniecie przez nas danych, czyli cech char dla pokow itp
            () -> () in
            //this will be called after download is done
            self.aktualizujDane()
            })
    }

    func aktualizujDane(){
        typPokemona.text = pokemon.typ
//        typPokemona.changeColor();
        wysokoscPokemona.text = pokemon.wysokość
        podstawowyAtak.text = pokemon.podstawowyAtak
        wagaPokemona.text = pokemon.waga
        obronaPokemona.text = pokemon.obrona
        
        if pokemon.następnaEwolucjaTekst == ""
        {
            tekstEwolucji.text = "Nie ma kolejnej ewolucji"
            drugaEwolucja.hidden = true
        }
        else
        {
            drugaEwolucja.image = UIImage(named: "\(pokemon.następnaEwolucjaId)")
            drugaEwolucja.hidden = false
            tekstEwolucji.text = "Następna ewolucja: \(pokemon.następnaEwolucjaTekst)"
        }
    }
    
    @IBAction func przyciskPowrotu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func charakterystykaPokemonaSgmnt(sender: AnyObject) {
    }
    @IBAction func atakiPokemonaSgmnt(sender: AnyObject) {
    }
}
