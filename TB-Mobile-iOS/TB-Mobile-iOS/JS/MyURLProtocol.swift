import UIKit
import CoreData

// requestCount
var requestCount = 0

 class MyURLProtocol: URLProtocol , URLSessionDataDelegate, URLSessionTaskDelegate{
    
    // URLSession request data task
    var dataTask:URLSessionDataTask?
    // url response
    var urlResponse: URLResponse?
    //url response data
    var receivedData: NSMutableData?
    
    
    // judge the protocol Whether can handle incomingrequest
    override class func canInit(with request: URLRequest) -> Bool {
        // Request to skip it has processed, to avoid an infinite loop label problem
        if URLProtocol.property(forKey: "MyURLProtocolHandledKey", in: request) != nil {
            return false
        }
        return true
    }
    
    // Back to the standardization of the request (usually just returned to the original request)
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // Determine whether two requests for the same request, if you will use for the requests of the same cached data.
    override class func requestIsCacheEquivalent(_ aRequest: URLRequest,
                                                 to bRequest: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(aRequest, to:bRequest)
    }
    
    // Starts processing the request
    override func startLoading() {
        requestCount+=1
        print("Request请求\(requestCount): \(request.url!.absoluteString)")
        // Determine whether there is a local cache
        let possibleCachedResponse = self.cachedResponseForCurrentRequest()
        if let cachedResponse = possibleCachedResponse {
            print("----- 从缓存中获取响应内容 -----")
            
            // Read data from the local cache
            let data = cachedResponse.value(forKey: "data") as! Data?
            let mimeType = cachedResponse.value(forKey: "mimeType") as! String?
            let encoding = cachedResponse.value(forKey: "encoding") as! String?
            
            // create NSURLResponse Object is used to store data.
            let response = URLResponse(url: self.request.url!, mimeType: mimeType,
                                       expectedContentLength: data!.count,
                                       textEncodingName: encoding)
            
            // The data returned to the client.Then call URLProtocolDidFinishLoading method to finish loading.
            // (set the client cache storage strategy. NotAllowed, namely for the client to do any work related cache)
            self.client!.urlProtocol(self, didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
            self.client!.urlProtocol(self, didLoad: data!)
            self.client!.urlProtocolDidFinishLoading(self)
        } else {
            // The request of network data
            print("===== 从网络获取响应内容 =====")
            
            let newRequest = (self.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            // NSURLProtocol interface setProperty () method can add custom attributes to URL request.
            // (so that the processed the request to make a tag, next time will no longer be handled, to avoid an infinite loop request)
            URLProtocol.setProperty(true, forKey: "MyURLProtocolHandledKey",
                                    in: newRequest)
            
            // use URLSession to get the data from the network
            let defaultConfigObj = URLSessionConfiguration.default
            let defaultSession = Foundation.URLSession(configuration: defaultConfigObj,
                                                       delegate: self, delegateQueue: nil)
            self.dataTask = defaultSession.dataTask(with: self.request)
            self.dataTask!.resume()
        }
    }
    
    // The end of processing this request
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }
    
    // URLSessionDataDelegate
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        self.client?.urlProtocol(self, didReceive: response,
                                 cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        self.receivedData = NSMutableData()
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        self.receivedData?.append(data)
    }
    
    // URLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask
        , didCompleteWithError error: Error?) {
        if error != nil {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            // save data
            saveCachedResponse()
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    // save data
    func saveCachedResponse () {
        print("+++++ 将获取到的数据缓存起来 +++++")
        
        // appdelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            // create NSManagedObject instance to match the Xcdatamodeld files in the corresponding data model。
            let cachedResponse = NSEntityDescription
                .insertNewObject(forEntityName: "CachedURLResponse",
                                 into: context) as NSManagedObject
            cachedResponse.setValue(self.receivedData, forKey: "data")
            cachedResponse.setValue(self.request.url!.absoluteString, forKey: "url")
            cachedResponse.setValue(Date(), forKey: "timestamp")
            cachedResponse.setValue(self.urlResponse?.mimeType, forKey: "mimeType")
            cachedResponse.setValue(self.urlResponse?.textEncodingName, forKey: "encoding")
            
            // save (Core Data, the Data should be placed in the main thread, or concurrency is easy to collapse)
            DispatchQueue.main.async(execute: {
                do {
                    try context.save()
                } catch {
                    print("不能保存：\(error)")
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    /// save data
    func saveOriCachedResponse () {
        print("+++++ 将原始数据缓存起来 +++++")
        
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            // write data
            var filePath = NSHomeDirectory()
            // filepath
            filePath = filePath + "bundle.897b646d204a361b42e8.js"
            
            // create NSManagedObject instance to match the Xcdatamodeld files in the corresponding data model。
            let cachedResponse = NSEntityDescription
                .insertNewObject(forEntityName: "CachedURLResponse",
                                 into: context) as NSManagedObject
            let recData = NSMutableData(contentsOfFile: filePath)
            cachedResponse.setValue(recData, forKey: "data")
            cachedResponse.setValue("\(rootURL)/static/bundle.897b646d204a361b42e8.js", forKey: "url")
            //        cachedResponse.setValue(Date(), forKey: "timestamp")
            //        cachedResponse.setValue(self.urlResponse?.mimeType, forKey: "mimeType")
            //        cachedResponse.setValue(self.urlResponse?.textEncodingName, forKey: "encoding")
            
            // save (Core Data, the Data should be placed in the main thread, or concurrency is easy to collapse)
            DispatchQueue.main.async(execute: {
                do {
                    try context.save()
                } catch {
                    print("不能保存：\(error)")
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    // Retrieve the cache request
    func cachedResponseForCurrentRequest() -> NSManagedObject? {
        // Obtain the data management context
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            // // create NSManagedObject instance to match the Xcdatamodeld files in the corresponding data model。
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            let entity = NSEntityDescription.entity(forEntityName: "CachedURLResponse",
                                                    in: context)
            fetchRequest.entity = entity
            
            // Set the query conditions
            let predicate = NSPredicate(format:"url == %@", self.request.url!.absoluteString)

            fetchRequest.predicate = predicate
            print(predicate)
            // Perform the get request
            do {
                let possibleResult = try context.fetch(fetchRequest)
                    as? Array<NSManagedObject>
                if let result = possibleResult {
                    if !result.isEmpty {
                        return result[0]
                    }
                }
            }
            catch {
                print("获取缓存数据失败：\(error)")
            }
        } else {
            // Fallback on earlier versions
        }
        return nil
    }
}
