//
//  BookListTableViewController.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 13/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import Moya
import UIKit

class BookListTableViewController: UITableViewController {
    
    var keyword : String = ""
    init(keyword : String) {
        super.init(style: .plain)
        self.keyword = keyword
    }
    var resultList : [[String:Any]]?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = keyword
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.mainTableView.register(UINib.init(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: BookListTableViewCell.self))
        
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        self.mainTableView.estimatedRowHeight = 120.0
        
        let provider = MoyaProvider<BookListService>()
        provider.request(.searchBook(bookName: keyword)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
//                print( String(data: data, encoding: .utf8))
                if statusCode == 200 {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any], let items = json!["items"] as? [[String: Any]] {
//                        print(items.count)
//                        print(items)
                        self.resultList = items
                        self.tableView.reloadData()
//                        let volumeInfo = self.resultList?[0]["volumeInfo"] as? [String: Any]
//                        print("self.resultList - volumeInfo: ", volumeInfo)
//                        let bookThumbnail = volumeInfo?["imageLinks"] as? [String: Any]
//                        print("self.resultList - bookThumbnail: ", bookThumbnail!["thumbnail"])
                    }
                }
            // do something in your app
            case let .failure(error):
                print(error.localizedDescription)
                // TODO: handle the error == best. comment. ever.
            }
        }
//        print("resultList: ", resultList as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func popController() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let resultList = resultList {
            return resultList.count
        } else {
            return 10
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var booksItem = self.resultList![indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: BookListTableViewCell.self)) as! BookListTableViewCell
        
        if let resultList = resultList, let volumeInfo = self.resultList?[indexPath.row]["volumeInfo"] as? [String: Any] {
            let link = volumeInfo["imageLinks"] as? [String: String]
            let imagePath = link!["thumbnail"] as? String
//            print("image url: ", imagePath)
//            print("title: ", volumeInfo["title"])
//            print("authors: ", volumeInfo["authors"])
//            print("averageRating: ", volumeInfo["averageRating"])
//            print("description: ", volumeInfo["description"])
            
//            if let authorList = volumeInfo["authors"] as? [[String: Any]] {
//                print("authorList: ", authorList)
//            }
//            print("volumeInfo: ", volumeInfo)
            
//            dump(volumeInfo["authors"])
            
            let authorListArray = volumeInfo["authors"] as! [String]
            let authorList = authorListArray.joined(separator: ", ")
            
            let bookRating = volumeInfo["averageRating"] as? Double ?? 0.0
            let averageRating = "\(String(bookRating)) star(s)"
            
            cell.bookNameLabel.text = volumeInfo["title"] as? String
            cell.authorLabel.text = authorList
            cell.averageRatingLabel.text = averageRating
            cell.bookDescriptionLabel.text = volumeInfo["description"] as? String
            
//            let url = URL(string: volumeInfo["description"] as! String ?? "")
            let url = URL(string: imagePath!)
            let data = try? Data(contentsOf: url!)
            if data != nil {
                cell.bookThumbnailImage.image = UIImage(data: data!)
            }
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            
            
            let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
            let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
            let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!

//            let stars = volumeInfo["averageRating"] as? Double
//            print("star: ", stars)

            func getStarImage(_ starNumber: Double, forRating rating: Double) -> UIImage {
                print("starNumber: ", starNumber)
                print("rating: ", rating)
                if rating >= starNumber {
                    return fullStarImage
                } else if rating + 0.5 == starNumber {
                    return halfStarImage
                } else {
                    return emptyStarImage
                }
            }

            let outRatingPoint = volumeInfo["averageRating"] as? Double ?? 0.0
            if let ourRating = outRatingPoint as? Double {
                cell.star1.image = getStarImage(1, forRating: ourRating)
                cell.star2.image = getStarImage(2, forRating: ourRating)
                cell.star3.image = getStarImage(3, forRating: ourRating)
                cell.star4.image = getStarImage(4, forRating: ourRating)
                cell.star5.image = getStarImage(5, forRating: ourRating)
            }
        }
       
        
//        cell.bookThumbnailImage =
//        cell.bookNameLabel.text = booksItem["volumeInfo"]["authors"] as! String
//        cell.authorLabel.text = booksItem.authors
//        cell.averageRatingLabel.text =
//        cell.bookDescriptionLabel.text =

       return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
