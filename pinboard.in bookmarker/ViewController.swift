//
//  ViewController.swift
//  Pinboard Integration
//
//  Created by Kristof Adriaenssens on 30/12/2018.
//  Copyright © 2018 Kristof Adriaenssens. All rights reserved.
//

import Cocoa
import SafariServices.SFSafariApplication

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet var appNameLabel: NSTextField!
    
    @IBOutlet weak var apiTokenTextField: NSSecureTextField!
    
    @IBOutlet weak var readLaterButton: NSPopUpButton!
   
    @IBOutlet weak var privateButton: NSPopUpButton!
    
    
    let sharedUserDefaults = UserDefaults(suiteName: "pinboard.in_bookmarker")!
    
    func controlTextDidChange(_ obj: Notification) {
        sharedUserDefaults.set(apiTokenTextField.stringValue, forKey: "apiToken")
    }
    
    @IBAction func readLaterButtonAction(_ sender: NSPopUpButton) {
        if let item = sender.selectedItem {
            sharedUserDefaults.set(item.title, forKey: "readLater")
        }
    }
    
    @IBAction func privateButtonAction(_ sender: NSPopUpButton) {
        if let item = sender.selectedItem {
            sharedUserDefaults.set(item.title, forKey: "private")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = "pinboard.in bookmarker";
        self.apiTokenTextField.delegate = self
        if let existingApiToken = sharedUserDefaults.string(forKey: "apiToken") {
            DispatchQueue.main.async {
                self.apiTokenTextField.stringValue = existingApiToken
            }
        } else {
            DispatchQueue.main.async {
                self.apiTokenTextField.stringValue = ""
            }
        }
        
        if let readLater = sharedUserDefaults.string(forKey: "readLater") {
            DispatchQueue.main.async {
                self.readLaterButton.selectItem(withTitle: readLater)
            }
        } else {
            sharedUserDefaults.set("No", forKey: "readLater")
            DispatchQueue.main.async {
                self.readLaterButton.selectItem(withTitle: "No")
            }
        }
        
        if let isPrivate = sharedUserDefaults.string(forKey: "private") {
            DispatchQueue.main.async {
                self.privateButton.selectItem(withTitle: isPrivate)
            }
        } else {
            sharedUserDefaults.set("No", forKey: "private")
            DispatchQueue.main.async {
                self.privateButton.selectItem(withTitle: "No")
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "kristofa.Pinboard-Integration-Extension") { error in
            if let _ = error {
                // Insert code to inform the user that something went wrong.

            }
        }
    }

}
