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
                let html: String = "<p>An <a href='http://example.com/'><b>example</b></a> link.</p>";
                let doc: Document = try! SwiftSoup.parse(data)
                let link: Element = try! doc.select("th.f_black").first()!
                
//                let text: String = try! doc.body()!.text(); // "An example link"
//                let linkHref: String = try! link.attr("href"); // "http://example.com/"
//                let linkText: String = try! link.text(); // "example""
//
                let linkOuterH: String = try! link.outerHtml(); // "<a href="http://example.com"><b>example</b></a>"
                let linkInnerH: String = try! link.html(); // "<b>example</b>"
                
                //print("linkOuterH : \(linkOuterH)")
                print("")
                print("linkInnerH : \(linkInnerH)")
                print("")
                
                let linka: Element = try! doc.select("tbody").first()!
                
                let doc1: Document = try! SwiftSoup.parse(try! linka.html())
                print("linka.ownText() : \(linka.ownText())")
                print("linka.html() : \(try! linka.html())")
                print("linka.text() : \(try! linka.text())")
                print("")
                
                let els: Elements = try doc1.select("tr")
                print("els.size() : \(els.size())")
                for link: Element in els.array() {
                    //let linkHref: String = try link.attr("href")
                    let linkText: String = try link.text()
                    let linkHtml: String = try! link.html();
                    print("linkText : \(linkText)")
                    print("linkHtml : \(linkHtml)")
                }
                
                let link1: Element = try! doc1.select("tr").first()!
                print("")
                print("link.html()111 : \(try! link1.html())")
                
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
