//
//  ActicleVC.swift
//  LearnAPI
//
//  Created by sok channy on 12/9/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit

class ActicleVC: UIViewController, UITableViewDelegate, UITableViewDataSource, delegateProtocol{
    
    var idexToUpdate:Int!
    
    @IBOutlet weak var acticleTabelView: UITableView!
    //var acticles:[Acticle] = []
    
    let acticleContext = AticalConext()
    override func viewDidLoad() {
        super.viewDidLoad()
        acticleContext.delegate = self
        acticleTabelView.delegate = self
        acticleTabelView.dataSource = self
        if acticles.count == 0 {
            acticleContext.fetchAtical()
        }else{
            acticleTabelView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acticles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acticleCellId",for:indexPath)
        cell.textLabel?.text = acticles[indexPath.row].title
        //cell.detailTextLabel?.text = acticles[indexPath.row].description
        return cell
        
    }
    
    @IBAction func addActiclePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controllerVC = storyboard.instantiateViewController(withIdentifier: "acticleDetailID") as! ActicleDetailVC
        navigationController?.pushViewController(controllerVC, animated: true)
    }
    
    func success(data: [String:AnyObject]) {
        let data = data["DATA"] as! [[String:AnyObject]]
        for eachData in data{
            let acticle = Acticle(id:eachData["ID"] as! Int,title:eachData["TITLE"] as! String,description:eachData["DESCRIPTION"] as! String)
            acticles.append(acticle)
        }
        acticleTabelView.reloadData()
    }
    
    func response(data: HTTPURLResponse) {
        print("Response : \(data)")
    }
    
    func error(data: NSError) {
        print("Error \(data)")
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{
            action, indexpath in
            self.acticleContext.deleteActicle(id: acticles[indexPath.row].id)
            acticles.remove(at: indexPath.row) // remove from collection
            self.acticleTabelView.deleteRows(at: [indexPath], with: .fade) // remove from table
            
        });
        let EditRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit", handler:{
            action, indexpath in
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let controllerVC = storyBoard.instantiateViewController(withIdentifier: "acticleDetailID") as! ActicleDetailVC
            controllerVC.acticle = acticles[indexPath.row]
            controllerVC.indexToUpdate = indexPath.row
            print(controllerVC.indexToUpdate)
            self.navigationController?.pushViewController(controllerVC, animated: true)
        });
        deleteRowAction.backgroundColor = UIColor.brown
        return [deleteRowAction,EditRowAction]
    }
    
    func successDelete(data: [String : AnyObject]) {
        print("Delete sussess \(data)")
    }
}



