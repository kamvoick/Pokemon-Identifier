//
//  ViewController.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 08.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemon = [Pokemon]()
    var filtrowanePokemony = [Pokemon]()
    var trybWyszukiwania = false
    
    var muzyka: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        wlaczMuzyke()
        parsowaniePokemonCSV()
    }

    func wlaczMuzyke() {
        let sciezka = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do{
            muzyka = try AVAudioPlayer(contentsOfURL: NSURL(string: sciezka)!)
            muzyka.prepareToPlay()
            muzyka.numberOfLoops = -1
            muzyka.play()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsowaniePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let imie = row["identifier"]!//wyjątkowe przypadki, bo nigdy się nie zmienią
                let poke_mon = Pokemon(imie: imie, pokedexId: pokeId)
                pokemon.append(poke_mon)
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke: Pokemon!
        
        if trybWyszukiwania {
            poke = filtrowanePokemony[indexPath.row]
        }else{
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("szczegolyPokemonaVC", sender: poke) //sender to obiekt który chcemy wysłać
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if trybWyszukiwania{
            return filtrowanePokemony.count
        }else {
        return pokemon.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let komorka = collectionView.dequeueReusableCellWithReuseIdentifier("pokemonCell", forIndexPath: indexPath) as? pokemonCell{

            let poke: Pokemon!
            
            if trybWyszukiwania {
                poke = filtrowanePokemony[indexPath.row]
            }else{
                poke = pokemon[indexPath.row]
            }
            
            komorka.skonfigurujKomorke(poke)
            return komorka
        }else{
            return UICollectionViewCell()
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func przyciskMuzyki(sender: UIButton!) {
        
        if muzyka.playing {
            muzyka.stop()
            sender.alpha = 0.2
        }else {
            muzyka.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            trybWyszukiwania = false
            view.endEditing(true)
            collection.reloadData()
        }else{
            trybWyszukiwania = true
            let maleLitery = searchBar.text!.lowercaseString
            filtrowanePokemony = pokemon.filter({$0.imie.rangeOfString(maleLitery) != nil})
            collection.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "szczegolyPokemonaVC" { //jeżeli używamy tego konkretnego segueya
            if let szczegolyVC = segue.destinationViewController as? szczegolyPokemonaVC{//to wtedy złapmy ten kontroller do którego będziemy iść, zamieniamy go na klase szczegolypokemonavc poniewaz dziedziczy z uiviewcontr
                if let poke = sender as? Pokemon{//potem jeżeli nasz wysyłany obiket ma nazwe poke a ma wyżej to wtedy
                    szczegolyVC.pokemon = poke//tutaj nasz szczegolyVC to ten kontroller do ktorego sie odnosimy a my w tamtej klasie zainicjowalismy zmienna pokemon ktora bedzie przechowywac nasz obiekt poke jak wysłannik, spoko
                    
                }
            }
        }
    }
}

