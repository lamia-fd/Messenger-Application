//
//  NewConversationViewController.swift
//  Messenger Application
//
//  Created by لمياء فالح الدوسري on 28/05/1443 AH.
//

import UIKit
//import JGProgressHUD


class NewConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="hi"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    

    private let tableView:UITableView={
        let table=UITableView()
        table.isHidden=true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
      return table
    }()
    
    private let noconversationLable: UILabel = {
        let lable=UILabel()
        lable.text="No Conversation"
        lable.textAlignment = .center
        lable.textColor = .gray
        lable.font = .systemFont(ofSize: 21, weight: .medium)
        lable.isHidden=true
        return lable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(noconversationLable)

        tableView.delegate = self
        tableView.dataSource = self
        fachConversation()
        // Do any additional setup after loading the view.
    }
    

    private func fachConversation(){
        
    }

}
