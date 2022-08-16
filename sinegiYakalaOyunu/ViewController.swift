//
//  ViewController.swift
//  sinegiYakalaOyunu
//
//  Created by Recep Akkoyun on 15.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblZaman: UILabel!
    @IBOutlet weak var lblSkor: UILabel!
    @IBOutlet weak var lblEnYuksekSkor: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var keenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var baslatButonu: UIButton!
    
    var timer = Timer()
    var zaman = 10
    var skor = 0
    var enYuksekSkor = 0
    var kennyList = [UIImageView]()
    var kennyTimer = Timer()
    
    
    
    override func viewDidLoad() {
        if zaman > 0 {
            baslatButonu.isEnabled = false
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let yuksekSkoruAl = UserDefaults.standard.object(forKey: "enyuksekskor")
        
        if yuksekSkoruAl == nil {
            enYuksekSkor = 0
            lblEnYuksekSkor.text = "En yüksek skor: \(enYuksekSkor)"
        }
        if let yeniSkor = yuksekSkoruAl as? Int {
            enYuksekSkor = yeniSkor
            lblEnYuksekSkor.text = "En yüksek skor: \(enYuksekSkor)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        keenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let tiklandi1 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi2 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi3 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi4 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi5 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi6 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi7 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi8 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))
        let tiklandi9 = UITapGestureRecognizer(target: self, action: #selector(imgTiklandi))

        kenny1.addGestureRecognizer(tiklandi1)
        kenny2.addGestureRecognizer(tiklandi2)
        kenny3.addGestureRecognizer(tiklandi3)
        kenny4.addGestureRecognizer(tiklandi4)
        kenny5.addGestureRecognizer(tiklandi5)
        kenny6.addGestureRecognizer(tiklandi6)
        keenny7.addGestureRecognizer(tiklandi7)
        kenny8.addGestureRecognizer(tiklandi8)
        kenny9.addGestureRecognizer(tiklandi9)
        
        kennyList = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,keenny7,kenny8,kenny9]
        kennySakla()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFonksiyonu), userInfo: nil, repeats: true)
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(kennySakla), userInfo: nil, repeats: true)
        
        
    }
    
        @objc func kennySakla(){
        for sakla in kennyList{
            sakla.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyList.count - 1)))
        kennyList[random].isHidden = false
    }
    
    
    @objc func imgTiklandi() {
        skor += 1
        lblSkor.text = (" Skor: \(skor)")
    }
    
    @objc func timerFonksiyonu(){
        zaman -= 1
        lblZaman.text = String(zaman)
        if zaman == 0{
            timer.invalidate()
            kennyTimer.invalidate()
            lblZaman.text = "Süreniz Doldu"
            lblZaman.textColor = UIColor.red
            
            //Skor kaydetme
            if self.skor > self.enYuksekSkor {
                self.enYuksekSkor = self.skor
                self.lblEnYuksekSkor.text = "En yüksek skor: \(self.enYuksekSkor)"
                UserDefaults.standard.set(self.enYuksekSkor,forKey: "enyuksekskor")
            }

            
            let uyari = UIAlertController(title:"Süre Doldu!", message:"Tekrar Oynamak İsyer misin ?", preferredStyle: UIAlertController.Style.alert)
            let okButonu = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.baslatButonu.isEnabled = true
            }
                
            let tekrarButonu = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) {
            (UIAlertAction) in
                self.skor = 0
                self.lblSkor.text = ("Skor: \(self.skor)")
                self.zaman  = 10
                self.lblZaman.text = String(self.zaman)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFonksiyonu), userInfo: nil, repeats: true)
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.kennySakla), userInfo: nil, repeats: true)
                for sakla in self.kennyList{
                    sakla.isHidden = true
                }
                
            }
            uyari.addAction(okButonu)
            uyari.addAction(tekrarButonu)
            self.present(uyari, animated: true, completion: nil)
        }
            
    }
    
    @IBAction func btnTekrarOyna(_ sender: Any) {
        baslatButonu.isEnabled = false
        self.skor = 0
        self.lblSkor.text = ("Skor: \(self.skor)")
        self.zaman  = 10
        self.lblZaman.text = String(self.zaman)
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFonksiyonu), userInfo: nil, repeats: true)
        self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.kennySakla), userInfo: nil, repeats: true)
        for sakla in self.kennyList{
            sakla.isHidden = true
        }
    }
    
}

