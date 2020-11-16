//
//  DetailViewController.swift
//  JokesApp
//
//  Created by Angelina Tsuboi on 11/16/20.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 100%; font-family: "sans-serif";} </style>
        </head>
        <body>
            <h2>\(detailItem.question)</h2>
            <p>\(detailItem.correct_answer)</p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

}
