//
//  ViewController.swift
//  ColeccionDeJuegosCancino
//
//  Created by Mac 09 on 5/12/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var juegos:[Jueguito] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try juegos = context.fetch(Jueguito.fetchRequest())
            tableView.reloadData()	
        }catch{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? Jueguito
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movido = self.juegos[sourceIndexPath.row]
                  juegos.remove(at: sourceIndexPath.row)
                  juegos.insert(movido, at: destinationIndexPath.row)
               NSLog("%@","\(sourceIndexPath.row) => \(destinationIndexPath.row) \(juegos)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.detailTextLabel?.text = juego.categoria
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let juego = juegos[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(juego)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                juegos = try
                    context.fetch(Jueguito.fetchRequest())
                tableView.reloadData()
            }catch{}
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    /*
     let movido = self.juegos[fromIndexPath.row]
              juegos.remove(at: fromIndexPath.row)
              juegos.insert(movido, at: to.row)
           NSLog("%@","\(fromIndexPath.row) => \(to.row) \(juegos)")
*/
}

