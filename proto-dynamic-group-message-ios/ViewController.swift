//
//  ViewController.swift
//  proto-dynamic-group-message-ios
//
//  Created by Santosh Krishnamurthy on 3/22/23.
//

import UIKit

extension Date {
    static func dateFromCustomString(customString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {

    fileprivate let cellId = "cellId"
    
    let chatMessages = [
        ChatMessage(text: "First Message", isIncoming: true, date: Date.dateFromCustomString(customString: "03/23/1980")),
        ChatMessage(text: "Focus on the highlighted part if I add a view using auto layout constraints setting translatesAutoresizingMaskIntoConstraints to false and then I change its frame or center value, the changes happen", isIncoming: false, date: Date.dateFromCustomString(customString: "03/23/1980")),
        ChatMessage(text: "Does changing center or frame, make translatesAutoresizingMaskIntoConstraints true again and break the auto layout constraints?", isIncoming: false, date: Date()),
        ChatMessage(text: "If you change the frame or center in a layoutSubviews override, that's fine; you are cooperating with the autolayout engine", isIncoming: true, date: Date()),
        ChatMessage(text: "But if you do it elsewhere, you'll be sorry. Your change may appear to work for a while, but as soon as something triggers layout, the view will jump back to where autolayout puts it.", isIncoming: true, date: Date()),
        ChatMessage(text: "Note that the autoresizing mask constraints fully specify the view’s size and position; therefore, you cannot add additional constraints to modify this size or position without introducing conflicts. If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false, and then provide a non ambiguous, nonconflicting set of constraints for the view.", isIncoming: false, date: Date())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
        
        setupNavigationBar()
        
        // Register new cell class and cell ID
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        
        // remove the seperator line between each cell
        tableView.separatorStyle = .none
        // set table view background color
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    func setupNavigationBar() -> Void {
        // set the title of the navigation bar
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // create a custom datelabel class and override the content size
    class DateHeaderLabel: UILabel {
        override var intrinsicContentSize: CGSize {
            let originalSize = super.intrinsicContentSize
            let height = originalSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            
            return CGSize(width: originalSize.width + 20, height: height)
        }
    }
    
    // create and return a view for section header
    // if a view is provided, then title for header function is ignored
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessage = chatMessages.first{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessage.date)
            
            let label = DateHeaderLabel()
            label.backgroundColor = .black
            label.text = dateString
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 15)
            
            let containerView = UIView()
            containerView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    /*
     
     Title for Header function is ignored, if view for header function is implemented
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let firstMessage = chatMessages.first{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return "Date: \(dateFormatter.string(from: firstMessage.date))"
        }
        return "Section: \(section+1)"
    }
     */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create an instance of table view cell and cast it to custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MessageCell
        cell?.chatMessage = chatMessages[indexPath.row]
        return cell!
    }

}

