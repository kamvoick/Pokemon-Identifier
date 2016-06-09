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

        nazwaPokemona.text = pokemon.imie.capitalizedString
    }

    
    @IBAction func przyciskPowrotu(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func charakterystykaPokemonaSgmnt(sender: AnyObject) {
    }
    @IBAction func atakiPokemonaSgmnt(sender: AnyObject) {
    }
}
