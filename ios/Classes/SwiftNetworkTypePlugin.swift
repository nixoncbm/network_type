import Flutter
import UIKit

public class SwiftNetworkTypePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.nixon/network_type", binaryMessenger: registrar.messenger())
    let instance = SwiftNetworkTypePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  guard call.method == "getNetworkType" else {
      result(FlutterMethodNotImplemented)
      return
    }
    result(getNetworkType())
  }

  func getNetworkType()->String {
      do{
          let reachability:Reachability = try Reachability.reachabilityForInternetConnection()
          do{
              try reachability.startNotifier()
              let status = reachability.currentReachabilityStatus
              if(status == .NotReachable){
                  return ""
              }else if (status == .ReachableViaWiFi){
                  return "Wifi"
              }else if (status == .ReachableViaWWAN){
                  let networkInfo = CTTelephonyNetworkInfo()
                  let carrierType = networkInfo.currentRadioAccessTechnology
                  switch carrierType{
                  case CTRadioAccessTechnologyGPRS?,CTRadioAccessTechnologyEdge?,CTRadioAccessTechnologyCDMA1x?: return "2G"
                  case CTRadioAccessTechnologyWCDMA?,CTRadioAccessTechnologyHSDPA?,CTRadioAccessTechnologyHSUPA?,CTRadioAccessTechnologyCDMAEVDORev0?,CTRadioAccessTechnologyCDMAEVDORevA?,CTRadioAccessTechnologyCDMAEVDORevB?,CTRadioAccessTechnologyeHRPD?: return "3G"
                  case CTRadioAccessTechnologyLTE?: return "4G"
                  default: return ""
                  }


              }else{
                  return ""
              }
          }catch{
              return ""
          }

      }catch{
          return ""
      }


  }
}
