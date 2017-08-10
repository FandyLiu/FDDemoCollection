//
//  ViewController.swift
//  WebTest
//
//  Created by QianTuFD on 2017/7/14.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://192.168.10.206:8080/hs/h5.html")!
        let req = URLRequest(url: url)
        webView.loadRequest(req)
        webView.delegate = self
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        webView.stringByEvaluatingJavaScript(from:
//            "var script = document.createElement('script');" +
//                "script.type = 'text/javascript';" +
//                "script.text = \"function myFunction2() {" +
//                "var str = \("");" +
//                "alert(); " + //var controls = document.getElementsByTagName('input');" +
//                //                "for(var i=0; i<controls.length; i++){" +
//                //                "if(controls[i].type=='text') {" +
//                //                "str += controls[i].id+':'+ controls[i].value+','" +
//                //                "}}" +
//                //                "alert(str)" +
//                //                "return str" +
//                "}\";" +
//            "document.getElementsByTagName('head')[0].appendChild(script);"
//        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let lengthStr = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input').length") ?? ""
        let length = Int(lengthStr) ?? 0
        for i in 0..<length {
            let value = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input')[\(i)].value;") ?? ""
            let id = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input')[\(i)].id;") ?? ""
            print("id: \(id), value: \(value)")
        }
        

        
        //        let href = webView.stringByEvaluatingJavaScript(from: "document.location.href")!
        //        let title = webView.stringByEvaluatingJavaScript(from: "document.title")!
        //        var count = 2
        //        while let value = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input')[\(count)].value;") {
        //            print("value\(count):" + value)
        //            count += 1
        //        }
        //        let value = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input')[\(count)].value;")!
        //        print("href:" + href)
        //        print("title:" + title)
        //        print("value:" + value)
        
        // 获取元素
        //        NSString *js_result2 = [webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit(); "];
        // 表单提交
        //        :@"document.getElementsByName('q')[0].value='朱祁林';"]
        //        webView.stringByEvaluatingJavaScript(from: "document.getElementById(\"input1\").value=\"bbb\"")
//        let length = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('input').length")
//        print(length)

        
        

        
        //        let a = webView.stringByEvaluatingJavaScript(from:
        //            "var script = document.createElement('script');" +
        //                "script.type = 'text/javascript';" +
        //            "script.text = \"function myFunction() { " +
        //             "var str = \"\"" +
        //            "var controls = document.getElementsByTagName('input')" +
        //            "for(var i=0; i<controls.length; i++){" +
        //            "if(controls[i].type=='text') {" +
        //            "str += controls[i].value" +
        //            "}}" +
        //            "return str}" +
        //            "\"" +
        //            "document.getElementsByTagName('head')[0].appendChild(script);"
        //        )
        
//        let b = webView.stringByEvaluatingJavaScript(from: "myFunction2();")
//        print("b:" + b!)
    }
    /*
     var controls = document.getElementsByTagName('input');
     for(var i=0; i<controls.length; i++){
     if(controls[i].type=='text'){
     controls[i].value='';
     alert("输入的文件名："+controls[i].value);
     }
     }
     
     var script = document.createElement('script');
     script.type = 'text/javascript';
     script.text = "
     document.getElementsByTagName('head')[0].appendChild(script);
     
     
     
     
     [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement_x('script');"
     "script.type = 'text/javascript';"
     "script.text = "function myFunction() { "
     "var field = document.getElementsByName('q')[0];"
     "field.value='朱祁林';"
     "document.forms[0].submit();"
     "}";"
     "document.getElementsByTagName_r('head')[0].appendChild(script);"];
     
     [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
     */
    
    
    
}

