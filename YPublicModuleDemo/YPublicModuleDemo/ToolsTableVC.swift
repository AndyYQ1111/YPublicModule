//
//  ToolsTableVC.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/6.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

class ToolsTableVC: UITableViewController {

    private var dataArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "工具演示"
        dataArr.append("TabPage滚动翻页：xib")
        dataArr.append("TabPage滚动翻页：纯代码")
        dataArr.append("无限轮播广告")
        dataArr.append("无限轮播广告:xib")
    }
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = dataArr[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataArr[indexPath.row] {
        case "TabPage滚动翻页：xib":
            navigationController?.pushViewController(TestTabPageVC1(), animated: true)
            break
            
        case "TabPage滚动翻页：纯代码":
            navigationController?.pushViewController(TestTabPageVC2(), animated: true)
            break
        case "无限轮播广告":
            navigationController?.pushViewController(BannerVC(), animated: true)
            break
        case "无限轮播广告:xib":
            navigationController?.pushViewController(BannerVC1(), animated: true)
            break
            
        default:
            break
        }
    }
}
