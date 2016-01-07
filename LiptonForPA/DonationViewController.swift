//
//  DonationViewController.swift
//  LiptonForPA
//
//  Created by David Balcher on 11/20/15.
//  Copyright © 2015 Xpressive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class DonationViewController: UIViewController, PayPalPaymentDelegate {
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentProduction {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
#if HAS_CARDIO
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
#else
    var acceptCreditCards: Bool = false {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
#endif

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up payPalConfig
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Lipton For PA."
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        // Setting the languageOrLocale property is optional.
        //
        // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
        // its user interface according to the device's current language setting.
        //
        // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
        // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
        // to use that language/locale.
        //
        // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
        
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        
        // Setting the payPalShippingAddressOption property is optional.
        //
        // See PayPalConfiguration.h for details.
        
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")

        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var likeButton: FBSDKLikeButton!
    
    override func viewWillAppear(animated: Bool) {
        likeButton.objectID = "https://www.facebook.com/LiptonForPA"
        PayPalMobile.preconnectWithEnvironment(environment)
    }
    
    
    @IBAction func presetDonationSelected(sender: UIButton) {
        if let amount = sender.titleLabel?.text {
            if let doubleAmount: NSNumber = Double(amount) {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .CurrencyStyle
                makeDonation(Double(doubleAmount))
            }
        }
    }
    
    
    @IBAction func customDonationSelected(sender: UITextField) {
        if let amount = sender.text {
            if let doubleAmount: NSNumber = Double(amount) {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .CurrencyStyle
                if let stringAmount = formatter.stringFromNumber(doubleAmount) {
                    sender.text = stringAmount
                }
                makeDonation(Double(doubleAmount))
            }
        }
    }
    
    
    // MARK: Single Payment
    func makeDonation(donationAmount: Double) {
        // Remove our last completed payment, just for demo purposes.
//        resultText = ""
        
        // Note: For purposes of illustration, this example shows a payment that includes
        //       both payment details (subtotal, shipping, tax) and multiple items.
        //       You would only specify these if appropriate to your situation.
        //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
        //       and simply set payment.amount to your total charge.
        
        let payment = PayPalPayment(amount: NSDecimalNumber(double: donationAmount), currencyCode: "USD", shortDescription: "Alex Lipton for State Representative", intent: .Sale)
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processable: \(payment)")
        }
        
    }

    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        print("PayPal Payment Cancelled")
//        resultText = ""
//        successView.hidden = true
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        print("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
//            self.resultText = completedPayment!.description
//            self.showSuccess()
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
