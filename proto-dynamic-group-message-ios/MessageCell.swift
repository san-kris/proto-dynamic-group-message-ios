//
//  MessageCell.swift
//  proto-dynamic-group-message-ios
//
//  Created by Santosh Krishnamurthy on 3/22/23.
//

import UIKit

class MessageCell: UITableViewCell {

    let messageLabel = UILabel()
    
    var messageLabelLeadingAnchor: NSLayoutConstraint!
    var messageLabelTrailingAnchor: NSLayoutConstraint!
    
    // introduce a dependency injection using a property
    var chatMessage: ChatMessage! {
        didSet{
            // set the background color of the bubble
            messageBackgroundBubble.backgroundColor = chatMessage.isIncoming ? .white : .darkGray

            // set the textcolor of the label
            messageLabel.textColor = chatMessage.isIncoming ? .black: .white
            
            // set the text
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                messageLabelLeadingAnchor.isActive = true
                messageLabelTrailingAnchor.isActive = false
            } else {
                messageLabelLeadingAnchor.isActive = false
                messageLabelTrailingAnchor.isActive = true
            }

        }
    }
    
    
    let messageBackgroundBubble: UIView = {
        let view =  UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12.0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // bubble is added to cell as a layer in the background
        // no bubble is displayed until autolayout is set
        addSubview(messageBackgroundBubble)
        
        addSubview(messageLabel)
        messageLabel.numberOfLines = 0
        
        // setup some constraints for lable
        // set the text anchor before setting the bubble anchor
        messageLabel.anchor(top: topAnchor,
                                       leading: nil,
                                       bottom: bottomAnchor,
                                       trailing: nil,
                                       padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
                                       size: CGSize(width: 0, height: 0))
        // lessthanor equal constraint will allow chat label to be of max 250 points.
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageLabelLeadingAnchor = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        messageLabelTrailingAnchor = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        
        
        
        // set the bubble anchor after text label anchor
        messageBackgroundBubble.anchor(top: messageLabel.topAnchor,
                                       leading: messageLabel.leadingAnchor,
                                       bottom: messageLabel.bottomAnchor,
                                       trailing: messageLabel.trailingAnchor,
                                       padding: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10),
                                       size: CGSize(width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
