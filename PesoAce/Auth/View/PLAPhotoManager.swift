//
//  PLAPhotoManager.swift
//  Pesoin
//
//  Created by apple on 2024/7/5.
//

import UIKit
import AVFoundation
import Photos

class PLAPhotoManager: NSObject {
    
    static let shared = PLAPhotoManager()
    
    private override init() {
        super.init()
    }
    
    func checkPhotoLibraryPermissions(completion: @escaping (Bool) -> Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            completion(true)
        case .limited:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    completion(status == .authorized)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .restricted, .denied:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    func presentPhoto(from viewController: UIViewController) {
        checkPhotoLibraryPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "Photo Album")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .photoLibrary, isfront: "")
        }
    }
    
    func presentCamera(from viewController: UIViewController, isfront: String) {
        checkCameraPermissions { [weak self] granted in
            guard granted else {
                self?.showSettingsAlert(from: viewController, for: "Camera")
                return
            }
            self?.showImagePicker(from: viewController, sourceType: .camera, isfront: isfront)
        }
    }
    
    private func showImagePicker(from viewController: UIViewController, sourceType: UIImagePickerController.SourceType, isfront: String) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        if sourceType == .camera {
            if isfront == "1" {
                imagePicker.cameraDevice = .front
                DispatchQueue.main.async {
                    self.hideCameraton(in: imagePicker.view)
                }
            }else {
                imagePicker.cameraDevice = .rear
            }
        }
        imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    private func showSettingsAlert(from viewController: UIViewController, for feature: String) {
        let alert = UIAlertController(
            title: "\(feature) Access has been disabled",
            message: "Please enable it in settings \(feature) Permission to use this feature",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func hideCameraton(in view: UIView) {
            for subview in view.subviews {
                if let button = subview as? UIButton, button.description.contains("CAMFlipButton") {
                    button.isHidden = true
                } else {
                    hideCameraton(in: subview)
                }
            }
        }
    
}
