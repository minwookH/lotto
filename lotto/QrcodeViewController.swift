//
//  QrcodeViewController.swift
//  lotto
//
//  Created by teruten on 2018. 4. 3..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

import SwiftSoup

class QrcodeViewController: UIViewController, QRCodeReaderViewControllerDelegate
{
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backAction))
        
        navigationBar.items = [navigationItem]
        // Do any additional setup after loading the view.
        
        
        
        let parameters = [
            "pw_type": "1",
            "cdomain": "mail.teruten.com"
            ] as [String : Any]
        
        //let api = ApiManager(path: "/getUserList")
        let api = NetworkApiManager(isNaver: true, path: "http://m.nlotto.co.kr/qr.do?method=winQr&v=0797q031124364145q020409243334q063337414345q041132363839q0609101933360000000828", method: "get" , parameters: parameters)
        
        api.requestLottoQrCode1(success: {_ in }, fail: {_ in })
        
        api.requestLottoQrCode1(success: {
            (data : String) in
            print("start requestLottoQrCode1 result")
            
            do {
                let html: String = "<p> An <a href='http://example.com/'><b>example</b></a> link. <a href='http://example.com1111/'><b>example1111</b></a></p>";
                let doc: Document = try! SwiftSoup.parse(html)
                let link: Element = try! doc.select("a").first()!
                
//                let text: String = try! doc.body()!.text(); // "An example link"
//                let linkHref: String = try! link.attr("href"); // "http://example.com/"
//                let linkText: String = try! link.text(); // "example""
//
                let linkOuterH: String = try! link.outerHtml(); // "<a href="http://example.com"><b>example</b></a>"
                let linkInnerH: String = try! link.html(); // "<b>example</b>"
                
                //print("linkOuterH : \(linkOuterH)")
                //print("")
                //print("linkInnerH : \(linkInnerH)")
                //print("")
                
                let docc: Document = try SwiftSoup.parse(data)
                
                let linkaaa: Element = try docc.select("li.pt10").first()!
                print("")
                print("linka.html() : \(try! linkaaa.html())")
                print("")
                
                
                
                //let docc1: Document = try! SwiftSoup.parse(linka11.html())
                for aabb: Element in try linkaaa.getElementsByTag("img").array() {
                    
                    print("aabb() : \(try! aabb.attr("alt"))")
                    var bbbb = try! aabb.attr("alt")
                    let indexEndOfText = bbbb.index(bbbb.endIndex, offsetBy: -1)
                    let substring3 = bbbb[..<indexEndOfText] // "Hello"
                    print("substring3() : \(substring3)")
                    print("")
                }
                
                let linka: Element = try! docc.select("tbody").first()!
                
                let doc1: Document = try! SwiftSoup.parse(try! linka.html())
//                print("data() : \(linka.data())")
//                print("tagName() : \(linka.tagName())")
//                print("linka.html() : \(try! linka.html())")
//                print("linka.text() : \(try! linka.text())")
//                print("")
//                print("linka.text111() : \(try! linka.getElementsByTag("td"))")
//                print("linka.text222() : \(try! linka.getElementsByTag("td").html())")
//                print("linka.text333() : \(try! linka.getElementsByTag("td").size())")
                print("")
                for link1: Element in try linka.getElementsByTag("td").array() {
                    //let linkHref: String = try link.attr("href")
                    let linkText: String = try link1.text()
                    let linkHtml: String = try link1.html()
                    
                    var cc = linkText.components(separatedBy: " ")
                    
                    for link11: Element in try link1.getElementsByAttribute("src").array() {
                        
                        let linkText1: String = try link11.text()
                        let linkHtml1: String = try link11.html()
                        let link11: String = try link11.attr("src")
                        
                        if linkHtml1 == "-" {
                            continue
                        }
                        
                        print("l : \(linkText1)")
                        print("li : \(linkHtml1)")
                        print("li11 : \(link11)")
                        print("")
                        
                        let range1 = link11.range(of:"/img/common/small_ball_")
                        let index1 = range1!.upperBound
                        let indexEndOfText = link11.index(link11.endIndex, offsetBy: -4)
                        let subStr1 = String(link11[index1..<indexEndOfText])
                        
                        print("subStr1 : \(subStr1)")
                        
//                        let indexStartOfText = template.index(template.startIndex, offsetBy: 3)
//                        let indexEndOfText = template.index(template.endIndex, offsetBy: -3)
//                        let substring3 = template[indexStartOfText..<indexEndOfText] // "Hello"
                        
                        cc.append(subStr1)
                    }
                    
                    if linkHtml == "-" {
                        continue
                    }
                    
                    print("linkText : \(linkText)")
                    
                    
                    
                    cc.sort(){$0.localizedStandardCompare($1) == .orderedAscending}
                    
                    for part : String in cc {
                        print("part : \(part)")
                    }
                    
                    print("linkHtml : \(linkHtml)")
                    print("-----------------")
                    
                    
                    let docc1: Document = try! SwiftSoup.parse(linkHtml)
                    print("")
                }
                
            } catch Exception.Error(let type, let message) {
                print("Exception.Error : \(message)")
            } catch {
                print("error")
            }
        }, fail: {
            (error: Error?) in print(error)
            print("error : \(error)")
            
        })
    }
    
    @objc func backAction() -> Void {
        print("back action!!!!!")
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
        private func checkScanPermissions() -> Bool {
            do {
                return try QRCodeReader.supportsMetadataObjectTypes()
            } catch let error as NSError {
                let alert: UIAlertController

                switch error.code {
                case -11852:
                    alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                        DispatchQueue.main.async {
                            if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                                UIApplication.shared.openURL(settingsURL)
                            }
                        }
                    }))

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                default:
                    alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                }

                present(alert, animated: true, completion: nil)

                return false
            }
        }

        lazy var reader: QRCodeReader = QRCodeReader()
        lazy var readerVC: QRCodeReaderViewController = {
            let builder = QRCodeReaderViewControllerBuilder {
                $0.reader          = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
                $0.showTorchButton = true

                $0.reader.stopScanningWhenCodeIsFound = false
            }

            return QRCodeReaderViewController(builder: builder)
        }()


        @IBAction func scanInModalAction(_ sender: AnyObject) {
            guard checkScanPermissions() else { return }

            readerVC.modalPresentationStyle = .formSheet
            readerVC.delegate               = self

            readerVC.completionBlock = { (result: QRCodeReaderResult?) in
                if let result = result {
                    print("Completion with result: \(result.value) of type \(result.metadataType)")
                }
            }

            present(readerVC, animated: true, completion: nil)
        }

        @IBAction func scanInPreviewAction(_ sender: Any) {
            guard checkScanPermissions(), !reader.isRunning else { return }

            reader.didFindCode = { result in
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }

            reader.startScanning()
        }

        // MARK: - QRCodeReader Delegate Methods
        func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
            reader.stopScanning()

            dismiss(animated: true) { [weak self] in
                let alert = UIAlertController(
                    title: "QRCodeReader",
                    message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                self?.present(alert, animated: true, completion: nil)
            }
        }

        func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
            print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
        }

        func readerDidCancel(_ reader: QRCodeReaderViewController) {
            reader.stopScanning()

            dismiss(animated: true, completion: nil)
        }

}
