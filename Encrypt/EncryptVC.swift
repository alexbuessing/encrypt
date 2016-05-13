//
//  ViewController.swift
//  Encrypt
//
//  Created by Alexander Buessing on 4/24/16.
//  Copyright © 2016 Buessing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var textField: UITextView!
    @IBOutlet var keywordField: UITextField!
    
    var encodeWord: String!
    var encodePhrase: String!
    var isText: Bool = false
    var isKeyword: Bool = false
    var defaults = NSUserDefaults.standardUserDefaults()
    var myCopy = UIPasteboard.generalPasteboard()
    var isDecoded = false
    var timer = NSTimer()
    var encodedString: String!
    var count = -1
    var codedArray: [Character] = []
    var displayString = ""
    
    var messageComposer = MessageComposer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        keywordField.delegate = self
        textField.returnKeyType = UIReturnKeyType.Done
        keywordField.returnKeyType = UIReturnKeyType.Done
        clearAll()
        
    }
    
    @IBAction func clearContent(sender: AnyObject) {
        
        clearAll()
        
    }
    
    @IBAction func copyText(sender: AnyObject) {
        
        myCopy.string = textField.text
        
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        if messageComposer.canSendText() {
            messageComposer.body = textField.text
            
            let messageComposeVC = messageComposer.configureMessageComposeViewController()
            
            presentViewController(messageComposeVC, animated: true, completion: nil)
        } else {
            alert("Cannot Send Text Message", message: "Your device is not able to send text messages.")
        }
    }
    
    func startTime() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: #selector(ViewController.displayText), userInfo: nil, repeats: true)
        
    }
    
    func displayText() {
        
        count += 1
        
        if count == encodedString.characters.count {
            timer.invalidate()
        }
        
        if count < encodedString.characters.count {
            
            displayString.append(codedArray[count])
            
        }
        
        textField.text = displayString
        
    }
    

    @IBAction func decryptText(sender: AnyObject) {
        
            if keywordField.text != nil && keywordField.text != "" && !isDecoded {
                
                if textField.text != nil && textField.text != "" {
                
                    let decode = decryptPhrase(textField.text!, keyWord: keywordField.text!.lowercaseString)
                    textField.text = decode
                    isDecoded = true
                }
            }
    }
    
    @IBAction func encryptText(sender: AnyObject) {
        
        timer.invalidate()
        count = -1
        
        if defaults.valueForKey("encodePhrase") == nil {
        
            if keywordField.text != nil && keywordField.text != "" {
                encodeWord = keywordField.text!.lowercaseString
                isKeyword = true
            }
        
            if textField.text != nil && textField.text != "" {
                encodePhrase = textField.text
                isText = true
            }
        
            if isText && isKeyword {
                
                defaults.setObject(encodePhrase, forKey: "encodePhrase")
                //textField.text = encryptPhrase(String(defaults.valueForKey("encodePhrase")!), codeWord: encodeWord)
                
                encodedString = encryptPhrase(String(defaults.valueForKey("encodePhrase")!), codeWord: encodeWord)
                displayString = ""
                codedArray = []
                for value in encodedString.characters {
                    codedArray.append(value)
                }
                
                isDecoded = false
                startTime()
            }
        } else {
            if isKeyword {
                encodeWord = keywordField.text!
                //textField.text = encryptPhrase(String(defaults.valueForKey("encodePhrase")!), codeWord: keywordField.text!)
                isDecoded = false
                
                encodedString = encryptPhrase(String(defaults.valueForKey("encodePhrase")!), codeWord: encodeWord)
                displayString = ""
                codedArray = []
                for value in encodedString.characters {
                    codedArray.append(value)
                }
                startTime()
            }
        }
    }
    
    func decryptPhrase(cryptedPhrase: String, keyWord: String) -> String {
        
        var count: Int = 0
        var changedLetterNumber: Int!
        var codeArray: [Int] = []
        var newLetter: Character!
        
        let lowercasePhrase = cryptedPhrase.lowercaseString
        var newPhrase = ""
        
        codeArray = getCodeNumbers(keyWord)
        
        // Loop through each character in phrase
        for letter in lowercasePhrase.characters {
            
            // Check to make sure it is a letter
            if isLetter(letter) {
                
                //Reset count value if it gets too high
                if count == codeArray.count {
                    count = 0
                }
                
                // Get the number that the character is associated with.
                for x in 0..<LETTERARRAY.count {
                    
                    //Find what letter the character matches with
                    if letter == Character(LETTERARRAY[x]) {
                        changedLetterNumber = x - codeArray[count]
                        if changedLetterNumber < 0 {
                            changedLetterNumber = changedLetterNumber + 25
                        }
                        newLetter = Character(LETTERARRAY[changedLetterNumber])
                        newPhrase.append(newLetter)
                        
                    }
                }
                count += 1
            } else {
                newPhrase.append(letter)
            }
            
        }
        return newPhrase.uppercaseString
    }
    
    func encryptPhrase(phrase: String, codeWord: String) -> String {
        
        var count: Int = 0
        var changedLetterNumber: Int!
        var codeArray: [Int] = []
        var newLetter: Character!
        
        let lowercasePhrase = phrase.lowercaseString
        var newPhrase = ""
        
        codeArray = getCodeNumbers(encodeWord)
        
        // Loop through each character in phrase
        for letter in lowercasePhrase.characters {
            
            // Check to make sure it is a letter
            if isLetter(letter) {
                
                //Reset count value if it gets too high
                if count == codeArray.count {
                    count = 0
                }
                
                // Get the number that the character is associated with.
                for x in 0..<LETTERARRAY.count {
                    
                    //Find what letter the character matches with
                    if letter == Character(LETTERARRAY[x]) {
                        changedLetterNumber = x + codeArray[count]
                        if changedLetterNumber >= LETTERARRAY.count {
                            changedLetterNumber = changedLetterNumber - 25
                        }
                        newLetter = Character(LETTERARRAY[changedLetterNumber])
                        newPhrase.append(newLetter)
                        
                    }
                }
                count += 1
            } else {
                newPhrase.append(letter)
            }
            
        }
        
        return newPhrase.uppercaseString
    }

    func isLetter(char: Character) -> Bool {
        
        for x in LETTERARRAY {
            if Character(x) == char {
                return true
            }
        }
        
        return false
    }
    
    func getCodeNumbers(encodeWord: String) -> [Int] {
        
        var codeArray: [Int] = []
        
        for character in encodeWord.characters {
            for x in 0..<LETTERARRAY.count {
                if character == Character(LETTERARRAY[x]) {
                    codeArray.append(x)
                }
            }
        }
        return codeArray
        
    }
    
    func clearAll() {
        
        keywordField.text = ""
        textField.text = ""
        defaults.setObject(nil, forKey: "encodePhrase")
        isKeyword = false
        isText = false
        isDecoded = false
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        keywordField.resignFirstResponder()
        return true
    }
    
    
    func alert(title: String, message: String) {
        
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        errorAlert.addAction(action)
        presentViewController(errorAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func infoPressed(sender: AnyObject) {
        performSegueWithIdentifier("showInfo", sender: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textField.resignFirstResponder()
        }
        return true
    }

}

