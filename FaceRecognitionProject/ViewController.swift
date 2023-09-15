//
//  ViewController.swift
//  FaceRecognitionProject
//
//  Created by Atil Samancioglu on 28.07.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import UIKit
import LocalAuthentication

// info plistte privacy - face id usage description kısmına To Authenticate yazıyoruz. kullanıcıya faceid izni sorulur
// simulatoru açıp bilgisayar ekranının üstünde feature den face id yi seçip enrolled yaparsak simulatorden face id yi kontrol edebiliriz. matching face i seçince

class ViewController: UIViewController {

    @IBOutlet var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signInClicked(sender: AnyObject) {
        
        let authContext = LAContext() // doğrulama işlemleri için kullanılan obje
        
        var error: NSError? // aşağıdaki parametreye bu şekilde error değişkeni vermek gerekiyor
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) { // biyometrik kullanarak doğrulama yapıyoruz. biyometrik ya kullanıcının yüzü ya da parmak izidir. kullanıcı hangi telefonu kullanıyosa ona göre değişir
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in // localizedReason neden bunu yaptığını sorar. gerçekten sen misin onu deniyorum diyoruz. bu da bi closure oluşturur
                if success == true { // success true ise doğrulama başarılı olmuştur
                    //successful auth
                    DispatchQueue.main.async { // bu kodu mainde (arka planda değil) asenkron olarak çalıştır. arka planda çalıştırılırsa diğeri de arka planda çalıştığı için uygulama çöker
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil) // ikinci viewcontroller açılır
                    }
                } else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Error!"
                    }
                }
            }
            
            
        }
        
        
    }
}

