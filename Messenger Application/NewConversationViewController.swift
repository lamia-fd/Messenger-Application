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
        cell.textLabel?.text="hi there"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = chatViewController()
        vc.title="the name"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
         
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
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(noconversationLable)

        
        fachConversation()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func fachConversation(){
        tableView.isHidden=false
        noconversationLable.isHidden=false
    }

}
