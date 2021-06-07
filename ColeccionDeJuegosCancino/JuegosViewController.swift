//
//  JuegosViewController.swift
//  ColeccionDeJuegosCancino
//
//  Created by Mac 09 on 5/12/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var Titulo: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var botonCategoria: UIButton!
    //@IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var tableViewCat: UITableView!
    
    var imagePicker = UIImagePickerController()
    var juego:Jueguito? = nil
    var categoria = ["categoria1","categoria2","categoria3","categoria4","categoria5","categoria6","categoria7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        tableViewCat.delegate = self
        tableViewCat.dataSource = self
        tableViewCat.isHidden = true
        
        if juego != nil {
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            Titulo.text = juego!.titulo
            botonCategoria.setTitle("\(juego!.categoria!)", for: .normal)
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cat = categoria[indexPath.row]
        cell.textLabel?.text = cat
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = categoria[indexPath.row]
        botonCategoria.setTitle("\(cat)", for: .normal)
        animate(toogle: false)
    }
    
    @IBAction func seleccionarCategoria(_ sender: Any) {
        let cate = botonCategoria.currentTitle!
        if tableViewCat.isHidden {
            animate(toogle: true)
        } else{
            animate(toogle: false)
        }
        print("titulooooooooooo: \(cate)")
    }
    
    func animate(toogle: Bool){
        if toogle {
            UIView.animate(withDuration: 0.3){
                self.tableViewCat.isHidden = false
            }
        } else{
            UIView.animate(withDuration: 0.3){
                self.tableViewCat.isHidden = true
            }
        }
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    		
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            let categ = botonCategoria.currentTitle!
            juego!.titulo! = Titulo.text!
            juego!.categoria! = categ
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Jueguito(context: context)
            let categ = botonCategoria.currentTitle!
            juego.titulo = Titulo.text
            juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = categ
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    /*
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegoImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
