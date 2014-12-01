//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Susan on 2014/12/01.
//  Copyright (c) 2014年 watanave. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        if let count = self.fetchedResultsController?.sections?.count
        {
            return count;
        }
        else
        {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if let count = self.fetchedResultsController?.sections?[section].numberOfObjects
        {   
            return count;
        }
        else
        {
            return 0;
        }

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        let model = self.fetchedResultsController?.objectAtIndexPath(indexPath) as Model;

        cell.textLabel.text = model.someDataA;
        // Configure the cell...

        return cell
    }
    
    lazy var fetchedResultsController : NSFetchedResultsController? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
        
            // エンティティのクラス名を指定
            let entityDiscription = NSEntityDescription.entityForName("Model", inManagedObjectContext: managedObjectContext)
            
            // NSFetchRequest SQLのWhere相当
            let fetcheRequest = NSFetchRequest()
            fetcheRequest.entity = entityDiscription
            
            // ソート指定。NSFetchedResultsControllerを生成する際は必須となる。
            var sortDiscriptor = NSSortDescriptor(key: "someDataB", ascending: true)
            fetcheRequest.sortDescriptors = [sortDiscriptor]
            
            // NSFetchedResultsControllerの生成。
            var fetchedResultController = NSFetchedResultsController(fetchRequest: fetcheRequest,
                managedObjectContext: managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            fetchedResultController.delegate = self
            
            // フェッチ
            var error:NSError?
            fetchedResultController.performFetch(&error)
            
            return fetchedResultController
        }
                
        return nil;
    }()

    // MARK: - Fetched result controller delegate
    func controllerWillChangeContent(controller : NSFetchedResultsController) -> Void
    {
        self.tableView.beginUpdates();
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type)
        {
        case .Insert:
            if newIndexPath != nil
            {
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        default:
            println(type);
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.tableView.endUpdates()
    }
}

