//
//  ViewController.swift
//  Pokedex
//
//  Created by Kamil Wójcik on 08.06.2016.
//  Copyright © 2016 Kamil Wójcik. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var music: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        
        wlaczMuzyke()
        parsowaniePokemonCSV()
    }

    func wlaczMuzyke() {
        let sciezka = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do{
            music = try AVAudioPlayer(contentsOfURL: NSURL(string: sciezka)!)
            music.prepareToPlay()
            music.numberOfLoops = -1
            music.play()
            
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
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let komorka = collectionView.dequeueReusableCellWithReuseIdentifier("pokemonCell", forIndexPath: indexPath) as? pokemonCell{
            
            var poke = pokemon[indexPath.row]
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
        
        if music.playing {
            music.stop()
            sender.alpha = 0.2
        }else {
            music.play()
            sender.alpha = 0.1
        }
    }
    
}

