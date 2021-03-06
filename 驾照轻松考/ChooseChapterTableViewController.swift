//
//  ChooseChapterTableViewController.swift
//  驾照轻松考
//
//  Created by 卢良潇 on 16/4/17.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

//选择章节
class ChooseChapterTableViewController: UITableViewController {

    // 1是章节练习 2是专项练习
    var chapterType:Int?
    
    var chapterData = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        //从数据库获取数据
      if chapterType == 1
      {
        chapterData =  DataBaseManager.shareManager().getData(SubjectType.chapter) as! [SubjectName]
        }
    
      else
      {
         chapterData = DataBaseManager.shareManager().getData(SubjectType.subChapter) as! [SubChapter]
        }
        
        
    }

    // MARK: - Table view data source

   

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chapterData.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChooseChatperCell", forIndexPath: indexPath) as! ChooseChapterTableViewCell
        cell.backgroundColor = bgGrayColor
        //章节练习
        if chapterType == 1
        {
            cell.chapterName.text = (chapterData as! [SubjectName])[indexPath.row].pname

            cell.chapterNum.text = (chapterData as! [SubjectName])[indexPath.row].pid
        }
        //专项练习
        else
        {
            cell.chapterName.text = (chapterData as! [SubChapter])[indexPath.row].sname
            cell.chapterNum.text = (chapterData as! [SubChapter])[indexPath.row].serial
        }
        
        cell.chapterName.numberOfLines = 0
        cell.chapterName.lineBreakMode = NSLineBreakMode.ByCharWrapping
        cell.chapterNum.backgroundColor = colors[Int(arc4random_uniform(5))]
        cell.chapterNum.clipsToBounds = true
        cell.chapterNum.layer.cornerRadius = 10
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
   
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if currentPage != 0
        {
            
            let alert = UIAlertController(title: "上次已做到第\(currentPage + 1)题,要继续开始吗？", message: nil, preferredStyle: UIAlertControllerStyle.Alert)

            let cancelAction = UIAlertAction(title: "从头开始", style: UIAlertActionStyle.Default) { (action) in
                
                //将page清空
                currentPage = 0
                
               self.pushToTestView()
                
                
            }
            let okAction = UIAlertAction(title: "继续", style: UIAlertActionStyle.Default) { (action) in
            //currentPage从0开始的 所以加1
                currentPage += 1
              self.pushToTestView()
                
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }

     else
        {
         pushToTestView()
        }
 
    }
    
    
    func pushToTestView()
    {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("MainTestVc") as! MainTestViewController
        vc.type = chapterType == 1 ? 1 : 4
        self.navigationController?.pushViewController(vc, animated: true)
    }

 
    
    
}
