import Flutter
import PhotosUI
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var imagePickerChannel: FlutterMethodChannel?
  private var pendingPickerResult: FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let registrar = self.registrar(forPlugin: "MoodooImagePicker")!
    imagePickerChannel = FlutterMethodChannel(
      name: "moodoo/image_picker",
      binaryMessenger: registrar.messenger()
    )
    imagePickerChannel?.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "pickFromGallery": self?.pickFromGallery(result: result)
      case "pickFromCamera": self?.pickFromCamera(result: result)
      default: result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - Pickers

  private func pickFromGallery(result: @escaping FlutterResult) {
    pendingPickerResult = result
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = self
    DispatchQueue.main.async { self.topViewController()?.present(picker, animated: true) }
  }

  private func pickFromCamera(result: @escaping FlutterResult) {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      result(nil)
      return
    }
    pendingPickerResult = result
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.mediaTypes = ["public.image"]
    picker.delegate = self
    DispatchQueue.main.async { self.topViewController()?.present(picker, animated: true) }
  }

  // MARK: - Helpers

  private func topViewController() -> UIViewController? {
    let scene = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.activationState == .foregroundActive }
    var vc = scene?.keyWindow?.rootViewController
    while let presented = vc?.presentedViewController { vc = presented }
    return vc
  }

  private func saveTempImage(_ image: UIImage) -> String? {
    let url = FileManager.default.temporaryDirectory
      .appendingPathComponent("moodoo_\(Int(Date().timeIntervalSince1970 * 1000)).jpg")
    guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
    try? data.write(to: url)
    return url.path
  }
}

// MARK: - PHPickerViewControllerDelegate

extension AppDelegate: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    guard let provider = results.first?.itemProvider,
      provider.canLoadObject(ofClass: UIImage.self)
    else {
      pendingPickerResult?(nil)
      pendingPickerResult = nil
      return
    }
    provider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
      DispatchQueue.main.async {
        if let image = object as? UIImage, let path = self?.saveTempImage(image) {
          self?.pendingPickerResult?(path)
        } else {
          self?.pendingPickerResult?(nil)
        }
        self?.pendingPickerResult = nil
      }
    }
  }
}

// MARK: - UIImagePickerControllerDelegate

extension AppDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    picker.dismiss(animated: true)
    let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
    if let image, let path = saveTempImage(image) {
      pendingPickerResult?(path)
    } else {
      pendingPickerResult?(nil)
    }
    pendingPickerResult = nil
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true)
    pendingPickerResult?(nil)
    pendingPickerResult = nil
  }
}
