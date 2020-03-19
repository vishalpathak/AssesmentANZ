//
//  ViewController.swift
//  Assessment
//
//  Created by VishalP India on 17/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var tableStamentsList: UITableView!

    fileprivate var sectionArray = [[Statement]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpIntiailUI()
        
        getDataFromJson()
    }
    
    fileprivate func setUpIntiailUI(){
        self.navigationItem.title = CommonStrings.Title
    }
    
    private func getDataFromJson(){
        
        NetworkService.sharedService.dataFromURLPath(fileName: BaseFileName) {(data: AllStatement?, error: Error?) in
            if let err = error{
                print("Er:\(err.localizedDescription)")
                return
            }
            if let res = data{
                var arrayStaments = [Statement]()
                arrayStaments = res.stmts
                arrayStaments.sort { (lhs: Statement, rhs: Statement) -> Bool in
                    let datet1 = Util.convertStringToDate(stringDate: lhs.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
                    let datet2 = Util.convertStringToDate(stringDate: rhs.stamtDate ?? "", givenFormat: "yyyy-MM-dd")
                    if let dt1 = datet1, let dt2 = datet2{
                    return dt1 > dt2
                    }
                    return false
                }
                
                // arrayStaments.map({return StamentViewModel(statement: $0)})
                var arr = Util.sortAndGroupDateByYear(dateArray: arrayStaments)
                let obj = arr[0][0]
                let arrN = [obj]
                arr.insert(arrN, at: 0)
                self.sectionArray = arr//Util.sortAndGroupDateByYear(dateArray: arrayStaments)
                DispatchQueue.main.async {
                    self.tableStamentsList.reloadData()
                }
            }
        }
    }
    
    fileprivate func shareStateMent(statement: Statement) -> Void {
        let date = Util.convertDateFormat(stringDate: statement.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "MMMM yyyy")
        let str = "Export \(date ?? "") statement in which format?"
        
        var alert = UIAlertController()
        if UIDevice.current.userInterfaceIdiom == .pad{
            alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
        }else{
            alert = UIAlertController(title: "", message: str, preferredStyle: .actionSheet)
        }

        alert.addAction(UIAlertAction(title: "Bank Statement (PDF)", style: .default , handler:{ (UIAlertAction)in
            print("PDF")
        }))

        alert.addAction(UIAlertAction(title: "Comma Seprated (CSV)", style: .default , handler:{ (UIAlertAction)in
            print("CSV")
        }))

        alert.addAction(UIAlertAction(title: "Quicken/Microsoft Money (QIF)", style: .default , handler:{ (UIAlertAction)in
            print("QIF")
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("Dismisss")
        }))
       
        self.present(alert, animated: true, completion: {
            print("completion")
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if section == 0{
            return CommonStrings.ThisMonth
        }else{
            let obj = sectionArray[section].first
            let str = Util.convertDateFormat(stringDate: obj?.stamtDate ?? "", givenFormat: "yyyy-MM-dd", expectedFormat: "yyyy")
            return str
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return sectionArray[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            var cell: TopTableViewCell
            if UIDevice.current.userInterfaceIdiom == .pad{
                cell = tableStamentsList.dequeueReusableCell(withIdentifier: "cellnewipadid") as! TopTableViewCell
            }else{
                cell = tableStamentsList.dequeueReusableCell(withIdentifier: "cellnewid") as! TopTableViewCell
            }
            let arr = sectionArray[0]
            let obj = arr[0]
            cell.selectionStyle = .none
            cell.setCurrentData(data: obj)
            return cell
        }else{
            let cell = tableStamentsList.dequeueReusableCell(withIdentifier: "cellId") as! StatementTableViewCell
            let obj = sectionArray[indexPath.section][indexPath.row]
            cell.selectionStyle = .none
            cell.setUpData(data: obj)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let obj = sectionArray[indexPath.section][indexPath.row]
        shareStateMent(statement: obj)
    }
    
    
}
