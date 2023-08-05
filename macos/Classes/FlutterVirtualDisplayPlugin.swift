import Cocoa
import CoreGraphics
import FlutterMacOS

public class FlutterVirtualDisplayPlugin: NSObject, FlutterPlugin {
  var virtualDisplays = [UInt32: CGVirtualDisplay]()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.virtual_display.flutter_virtual_display", binaryMessenger: registrar.messenger)
    let instance = FlutterVirtualDisplayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "createDisplay":
      let arguments = call.arguments as! [String: Any]
      let name = arguments["name"] as! String
      let width = arguments["width"] as! UInt32
      let height = arguments["height"] as! UInt32

      let display: CGVirtualDisplay = createDisplay(
        name: name,
        width: width,
        height: height
      )
      let displayId = display.displayID
      virtualDisplays[displayId] = display
      result(["displayID": displayId])
    case "removeDisplay":
      let arguments = call.arguments as! [String: Any]
      let displayID = arguments["displayID"] as! UInt32
      virtualDisplays[displayID] = nil
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func createDisplay(name: String, width: UInt32, height: UInt32) -> CGVirtualDisplay {
    let desc = CGVirtualDisplayDescriptor()
    desc.setDispatchQueue(DispatchQueue.main)
    desc.terminationHandler = { a, b in
      print("\(String(describing: a)), \(String(describing: b))")
    }
    desc.name = name
    desc.maxPixelsWide = width
    desc.maxPixelsHigh = height
    desc.sizeInMillimeters = CGSize(width: 1800, height: 1012.5)
    desc.productID = 0x1234
    desc.vendorID = 0x3456
    desc.serialNum = 0x0001

    let display = CGVirtualDisplay(descriptor: desc)

    let settings = CGVirtualDisplaySettings()
    settings.hiDPI = 2
    settings.modes = [
      CGVirtualDisplayMode(width: UInt(width), height: UInt(height), refreshRate: 60),
      CGVirtualDisplayMode(width: UInt(width), height: UInt(height), refreshRate: 30),
    ]
    display.apply(settings)
    return display
  }

//    @available(macOS 13.0, *)
//    func getDisplayStream(displayID: UInt32){
//        let stream: CGDisplayStream? = CGDisplayStream(
//             dispatchQueueDisplay: displayID,
//             outputWidth: 1920,
//             outputHeight: 1080,
//             pixelFormat: 1111970369, // BGRA
//             properties: nil,
//             queue: .main,
//             handler: { [weak self] frameStatus, displayTime, frameSurface, updateRef in
//                 if let surface = frameSurface {
//                    // self?.view.layer?.contents = surface
//                 }
//             }
//         )
//    }
}
