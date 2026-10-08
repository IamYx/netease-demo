// Copyright (c) 2022 NetEase, Inc. All rights reserved.
// Use of this source code is governed by a MIT license that can be
// found in the LICENSE file.

import NEChatUIKit
import UIKit
import NIMSDK
class CustomChatCell: /*NEChatBaseCell*/NormalChatMessageBaseCell {
    
    public var backView = UIView()
  public var testLabel = UILabel()
    var rigntConstraint: NSLayoutConstraint?
    var leftConstraint: NSLayoutConstraint?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = .clear
      
      backView.backgroundColor = .orange
      backView.layer.cornerRadius = 10
      backView.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(backView)
      NSLayoutConstraint.activate([
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        backView.widthAnchor.constraint(equalToConstant: 140),
        backView.heightAnchor.constraint(equalToConstant: 100),
      ])
      
      leftConstraint = backView.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 200)
      leftConstraint?.isActive = false
      
      rigntConstraint = backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -60)
      rigntConstraint?.isActive = true
      
      
    testLabel.translatesAutoresizingMaskIntoConstraints = false
    backView.addSubview(testLabel)
    NSLayoutConstraint.activate([
      testLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
      testLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
      testLabel.widthAnchor.constraint(equalToConstant: 100),
      testLabel.heightAnchor.constraint(equalToConstant: 80)
    ])
      testLabel.textAlignment = .center
    testLabel.font = UIFont.systemFont(ofSize: 14)
      testLabel.numberOfLines = 0
    testLabel.textColor = UIColor.black
  }

  override func setModel(_ model: MessageContentModel, _ isSend: Bool) {
      
      super.setModel(model, isSend)
      
      if (isSend) {
          rigntConstraint?.isActive = true
          leftConstraint?.isActive = false
      } else {
          rigntConstraint?.isActive = false
          leftConstraint?.isActive = true
      }
      
    print("this is custom message")
      let object : NIMCustomObject = model.message?.messageObject as! NIMCustomObject
      let attachment : CustomAttachment = object.attachment as! CustomAttachment
      
      let index = Int(attachment.goodsName)
      if index == 0 {
          testLabel.text = "石头"
      } else if (index == 1) {
          testLabel.text = "剪子"
      } else {
          testLabel.text = "布"
      }
    
  }
}
