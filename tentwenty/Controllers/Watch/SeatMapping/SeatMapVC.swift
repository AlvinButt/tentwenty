//
//  SeatMapVC.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 10/08/2022.
//

import UIKit

class SeatMapVC: UIViewController {
    
    @IBOutlet weak var datesCV: UICollectionView!
    @IBOutlet weak var ticketsCV: UICollectionView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var name:String = ""
    var date:String = ""
    
    var arrDatesSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSeatsSelectedIndex = [IndexPath]() // This is selected cell Index array
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = name
        lblDate.text = date
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    @IBAction func actionSeatMap(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SeatMappingDetailVCID") as! SeatMappingDetailVC
        vc.date = date
        vc.name = name
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
}

extension SeatMapVC:UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension SeatMapVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == datesCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCellID", for: indexPath) as! GenreCell
            cell.lblName.text = "\(indexPath.row + 1) Mar"
            
            if arrDatesSelectedIndex.contains(indexPath) {
                cell.lblBg.backgroundColor = UIColor(red: 97/255, green: 195/255, blue: 242/255, alpha: 1.0)
                cell.lblName.textColor = UIColor.white
            }
            else {
                cell.lblBg.backgroundColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.1)
                cell.lblName.textColor = UIColor.black
            }
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapTicketCellID", for: indexPath) as! MapTicketCell
        
        cell.ticketBg.layer.cornerRadius = 10
        cell.ticketBg.layer.borderWidth = 1
        
        if arrSeatsSelectedIndex.contains(indexPath) {
            cell.ticketBg.layer.borderColor = UIColor(red: 97/255, green: 195/255, blue: 242/255, alpha: 1.0).cgColor
        }
        else {
            cell.ticketBg.layer.borderColor = UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 0.1).cgColor
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == datesCV {
            return CGSize(width: 90, height: 30)
        }
        
        return CGSize(width: collectionView.bounds.width * 0.75, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == datesCV {
            
            if arrDatesSelectedIndex.contains(indexPath) {
                arrDatesSelectedIndex = arrDatesSelectedIndex.filter { $0 != indexPath}
            }
            else {
                arrDatesSelectedIndex.append(indexPath)
            }
            datesCV.reloadData()
            
        }else{
            
            if arrSeatsSelectedIndex.contains(indexPath) {
                arrSeatsSelectedIndex = arrSeatsSelectedIndex.filter { $0 != indexPath}
            }
            else {
                arrSeatsSelectedIndex.append(indexPath)
            }
            ticketsCV.reloadData()
            
        }
        
    }
    
}
